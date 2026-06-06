import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/features/auth/data/models/auth_model.dart';
import 'package:wathiq/features/auth/data/models/sign_up_model.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/app/injector.dart';
import 'package:wathiq/core/error/failure.dart';
import 'package:wathiq/core/params/auth/complete_sign_up.dart';
import 'package:wathiq/core/params/auth/login.dart';
import 'package:wathiq/core/params/auth/reset_password.dart';
import 'package:wathiq/core/params/auth/verify_params.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/features/auth/data/models/countries_model.dart';
import 'package:wathiq/features/auth/data/repository/auth_repo.dart';

part 'auth_state.dart';

String otpCode = '';
//TODO : return it to cubit

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState());

  // State Management Controllers
  bool passwordVisibility = false;
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final completeSignUpFormKey = GlobalKey<FormState>();

  final verifyFormKey = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  // Controllers
  final identityNumberController = TextEditingController(text: '1234567890');
  //
  final loginPasswordController = TextEditingController(text: 'Mohamed@1');
  //
  final verifyController = TextEditingController();

  final signUpNationalIDController = TextEditingController();

  final completeSignUpNameController = TextEditingController(text: 'kkk');
  final completeSignUpNationalIDController = TextEditingController();
  final completeSignUpPasswordController = TextEditingController();
  final completeSignUpConfirmPasswordController = TextEditingController();
  String? completeSignUpCountryID;
  final completeSignUpPhoneController = TextEditingController();

  final resetPasswordNewController = TextEditingController();
  final resetPasswordConfirmController = TextEditingController();

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    emit(state.copyWith(passwordVisiblity: passwordVisibility));
  }

  // Login Function
  void login() async {
    if (!loginFormKey.currentState!.validate()) return;

    emit(state.copyWith(loginRequestState: RequestState.loading));

    final params = LoginParams(
      identityNumber: identityNumberController.text.trim(),
      password: loginPasswordController.text.trim(),
    );

    final result = await _authRepository.login(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          loginRequestState: RequestState.error,
          loginError: failure,
        ));
        log(failure.toString());
      },
      (code) {
        otpCode = code;
        emit(state.copyWith(
          loginRequestState: RequestState.loaded,
          loginMsg: code,
        ));
      },
    );
  }

  // Sign Up Function
  void signUp() async {
    if (!signUpFormKey.currentState!.validate()) return;

    emit(state.copyWith(signUpRequestState: RequestState.loading));

    final nationalID = signUpNationalIDController.text.trim();
    final result = await _authRepository.signUp(nationalID);

    result.fold(
      (failure) {
        emit(state.copyWith(
          signUpRequestState: RequestState.error,
          signUpError: failure,
        ));
        log(failure.toString());
      },
      (signUpModel) {
        assginCompleteSignUPControllers(signUpModel);
        //clear the controllers
        emit(state.copyWith(
          signUpRequestState: RequestState.loaded,
          signUpModel: signUpModel,
        ));
      },
    );
  }

  void getCountries() async {
    emit(state.copyWith(getCountriesRequestState: RequestState.loading));

    final result = await _authRepository.getCountries();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getCountriesRequestState: RequestState.error,
          getCountriesError: failure,
        ));
        log(failure.toString());
      },
      (getCountriesModel) {
        emit(state.copyWith(
          getCountriesRequestState: RequestState.loaded,
          getCountriesModel: getCountriesModel,
        ));
      },
    );
  }

  void assginCompleteSignUPControllers(SignUpModel signUpModel) {
    completeSignUpNameController.text = signUpModel.data.name;
    completeSignUpNationalIDController.text = signUpModel.data.identityNumber;
    identityNumberController.text = signUpModel.data.identityNumber;
  }

  // Complete Sign Up Function
  void completeSignUp() async {
    if (!completeSignUpFormKey.currentState!.validate()) return;

    emit(state.copyWith(completeSignUpRequestState: RequestState.loading));

    final params = CompleteSignUpParams(
      password: completeSignUpPasswordController.text.trim(),
      country: completeSignUpCountryID ?? '',
      phoneNumber: completeSignUpPhoneController.text.trim(),
    );

    final result = await _authRepository.completeSignUp(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          completeSignUpRequestState: RequestState.error,
          completeSignUpError: failure,
        ));
        log(failure.toString());
      },
      (code) {
        otpCode = code;
        emit(state.copyWith(
            completeSignUpRequestState: RequestState.loaded,
            completeSignUpMsg: code));
      },
    );
  }

  // Verify OTP Function
  void verifyOtp() async {
    // if (!verifyFormKey.currentState!.validate()) return;

    emit(state.copyWith(verifyRequestState: RequestState.loading));
    final identityNumber = serviceLocator<IAppLocalStorage>()
            .getValue(AppStrings.userIdentityNumber) ??
        identityNumberController.text.trim();
    log('identityNumber: $identityNumber');

    final params = VerifyParams(
      otp: otpCode,
      identityNumber: identityNumber,
      fcmToken: 'kjubhbhjbubhbu5',
    );
    final result = await _authRepository.verify(params);
    print('verifyed with this code $otpCode');
    result.fold(
      (failure) {
        emit(state.copyWith(
          verifyRequestState: RequestState.error,
          verifyError: failure,
        ));
        log(failure.toString());
      },
      (message) {
        //clear the controllers
        _cleareControllers();

        emit(state.copyWith(
          verifyRequestState: RequestState.loaded,
        ));
        log(message);
        KisGuest = false;
      },
    );
  }

  void _cleareControllers() {
    loginPasswordController.clear();
    verifyController.clear();
    resetPasswordNewController.clear();
    resetPasswordConfirmController.clear();
    completeSignUpNameController.clear();
    completeSignUpNationalIDController.clear();
    completeSignUpPhoneController.clear();
    completeSignUpPasswordController.clear();
    completeSignUpConfirmPasswordController.clear();
  }

  // Forget Password Function
  void forgetPassword() async {
    if (!forgetPasswordFormKey.currentState!.validate()) return;

    emit(state.copyWith(forgetPassWordRequestState: RequestState.loading));

    final identityNumber = identityNumberController.text.trim();
    final result = await _authRepository.foregtPassword(identityNumber);

    result.fold(
      (failure) {
        emit(state.copyWith(
          forgetPassWordRequestState: RequestState.error,
          forgetPassWordError: failure,
        ));
        log(failure.toString());
      },
      (code) {
        otpCode = code;
        emit(state.copyWith(
            forgetPassWordRequestState: RequestState.loaded,
            forgetPassWordMsg: code));
        log(code);
      },
    );
  }

  // Reset Password Function
  void resetPassword() async {
    if (!resetPasswordFormKey.currentState!.validate()) return;

    emit(state.copyWith(resetPasswordRequestState: RequestState.loading));

    final params = ResetPasswordParams(
      newPassword: resetPasswordNewController.text.trim(),
      identityNumber: identityNumberController.text.trim(),
    );

    final result = await _authRepository.resetPassword(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          resetPasswordRequestState: RequestState.error,
          resetPasswordError: failure,
        ));
        log(failure.toString());
      },
      (message) {
        // clear the identity number after successful reset
        identityNumberController.clear();
        _cleareControllers(); // to ensure other controllers are clean

        emit(state.copyWith(
          resetPasswordRequestState: RequestState.loaded,
        ));
        log(message);
        KisGuest = false;
      },
    );
  }

  void resendCode() async {
    emit(state.copyWith(resendCodeRequestState: RequestState.loading));

    final result = await _authRepository.resendCode(
      identityNumberController.text.trim(),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          resendCodeRequestState: RequestState.error,
          resendCodeError: failure,
        ));
        log(failure.toString());
      },
      (code) {
        otpCode = code;
        emit(state.copyWith(
          resendCodeRequestState: RequestState.loaded,
          resendCodeMsg: code,
        ));
        log(code);
      },
    );
  }
}
