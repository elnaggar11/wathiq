import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/core/functions/pick_images_and_files.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/profile/data/models/agencies_model.dart';
import 'package:wathiq/features/profile/data/models/profile_model.dart';
import 'package:wathiq/core/network/socket/socket_service.dart';

import '../../../../../app/injector.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/params/profile/change_password_params.dart';
import '../../../../../core/params/profile/create_agency_params.dart';
import '../../../../../core/storage/flutter_secure_storage.dart';
import '../../../../../core/storage/i_app_local_storage.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/enums.dart';
import '../../../data/repository/profile_repo.dart';

part 'profile_state.dart';

String? Kemail;
String? Kphone;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileState());
  final ProfileRepository _profileRepository;
  File? imageFile;
  File? agencyAttachment;
  //
  TextEditingController firstNameController = TextEditingController();
  TextEditingController SecondNameController = TextEditingController();
  TextEditingController thirdNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController editablePhoneController = TextEditingController();

  //
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController ConfirmNewPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController agencyNameController = TextEditingController();
  TextEditingController agencyNumberController = TextEditingController();
  TextEditingController agencyIdentityNumberController =
      TextEditingController();
  bool isAcceptAgencyPolicy = true;
  TextEditingController agencyIssuedDateController = TextEditingController();
  final editEmaileKey = GlobalKey<FormState>();
  final editphoneKey = GlobalKey<FormState>();
  final changePasswordeKey = GlobalKey<FormState>();
  final createAgenciesKey = GlobalKey<FormState>();
  String status = AppStrings.approved; //rejected  approved  pending
  String agencyId = '';
  List<Agency> agencies = [];
  int agenciesLength = 0;
  List<Agency>? rejectedAgencies;
  List<Agency>? approvedAgencies;
  List<Agency>? pendingAgencies;
  //
  String? editUserInfoCountryID;

  void getProfile([bool idLoading = true]) async {
    if (idLoading) {
      emit(state.copyWith(profileRequestState: RequestState.loading));
    }

    final result = await _profileRepository.getProfile();

    result.fold(
      (failure) {
        emit(state.copyWith(
          profileRequestState: RequestState.error,
          profileError: failure,
        ));
        log(failure.toString());
      },
      (profileModel) {
        setProfileControllers(profileModel);
        emit(state.copyWith(
          profileRequestState: RequestState.loaded,
          profileModel: profileModel,
        ));
        Kemail = profileModel.data.email;
        Kphone = profileModel.data.phoneNumber.number;
      },
    );
  }

  setProfileControllers(ProfileModel profileModel) {
    List<String> userName = profileModel.data.name.split(' ');
    if (userName.length < 4) {
      userName.addAll(['', '', '', '']);
    }

    firstNameController.text = userName[0];
    SecondNameController.text = userName[1];
    thirdNameController.text = userName[2];
    lastNameController.text = userName[3];
    phoneController.text =
        '${profileModel.data.phoneNumber.key.replaceAll('+', '')}${profileModel.data.phoneNumber.number}+';
    emailController.text = profileModel.data.email ?? '';
    identityNumberController.text = profileModel.data.identityNumber;
  }

  void changeProfileImage() async {
    emit(state.copyWith(changeProfileImageRequestState: RequestState.loading));

    final result = await _profileRepository.changeProfileImage(
        imageFile, editUserInfoCountryID);

    result.fold(
      (failure) {
        emit(state.copyWith(
          changeProfileImageRequestState: RequestState.error,
          changeProfileImageError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(state.copyWith(
          changeProfileImageRequestState: RequestState.loaded,
          changeProfileImageMsg: msg,
        ));
        deletePickedImage();
        deleteCountryIDFunction();
        getProfile(false);
      },
    );
  }

  pickProfileImage() async {
    imageFile = await pickImage();
    if (imageFile != null) {
      emit(state.copyWith(
        imageFile: imageFile,
      ));
    }
  }

  EditCountryIDFunction() async {
    emit(state.copyWith(
      editUserInfoCountryID: editUserInfoCountryID,
    ));
  }

  deletePickedImage() async {
    imageFile = null;

    emit(state.copyWith(
      changeProfileImageRequestState: RequestState.loaded,
      imageFile: null,
    ));
    emit(state.copyWith(
      changeProfileImageRequestState: RequestState.ideal,
      imageFile: null,
    ));
  }

  deleteCountryIDFunction() async {
    editUserInfoCountryID = null;

    emit(state.copyWith(
      changeProfileImageRequestState: RequestState.loaded,
      editUserInfoCountryID: null,
    ));
    emit(state.copyWith(
      changeProfileImageRequestState: RequestState.ideal,
      editUserInfoCountryID: null,
    ));
  }

  void askAddEmail() async {
    emit(state.copyWith(askAddEmailRequestState: RequestState.loading));

    final result = await _profileRepository.askAddEmail();

    result.fold(
      (failure) {
        emit(state.copyWith(
          askAddEmailRequestState: RequestState.error,
          askAddEmailError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        otpCode = msg ?? '011101';
        emit(state.copyWith(
          askAddEmailRequestState: RequestState.loaded,
          askAddEmailMsg: msg,
        ));
      },
    );
  }

  void addEmail() async {
    if (!editEmaileKey.currentState!.validate()) return;
    emit(state.copyWith(addEmailRequestState: RequestState.loading));
    final result =
        await _profileRepository.addEmail(emailController.text.trim());

    result.fold(
      (failure) {
        emit(state.copyWith(
          addEmailRequestState: RequestState.error,
          addEmailError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        otpCode = msg ?? '011101';

        emit(state.copyWith(
          addEmailRequestState: RequestState.loaded,
          addEmailModelMsg: msg,
        ));
      },
    );
  }

  void askEditPhone() async {
    emit(state.copyWith(askEditPhoneRequestState: RequestState.loading));

    final result = await _profileRepository.askEditPhone();

    result.fold(
      (failure) {
        emit(state.copyWith(
          askEditPhoneRequestState: RequestState.error,
          askEditPhoneError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        otpCode = msg ?? '011101';
        emit(state.copyWith(
          askEditPhoneRequestState: RequestState.loaded,
          askEditPhoneMsg: msg,
        ));
      },
    );
  }

  void addPhone() async {
    if (!editphoneKey.currentState!.validate()) return;
    emit(state.copyWith(addPhoneRequestState: RequestState.loading));
    final result =
        await _profileRepository.addPhone(editablePhoneController.text.trim());

    result.fold(
      (failure) {
        emit(state.copyWith(
          addPhoneRequestState: RequestState.error,
          addPhoneError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        otpCode = msg ?? '011101';
        emit(state.copyWith(
          addPhoneRequestState: RequestState.loaded,
          addPhoneModelMsg: msg,
        ));
      },
    );
  }

  void changePassword() async {
    if (!changePasswordeKey.currentState!.validate())
      emit(state.copyWith(changePasswordRequestState: RequestState.loading));
    ChangePasswordParams changePasswordParams = ChangePasswordParams(
      newPassword: newPasswordController.text.trim(),
      oldPassword: oldPasswordController.text.trim(),
    );

    final result =
        await _profileRepository.changePassword(changePasswordParams);

    result.fold(
      (failure) {
        emit(state.copyWith(
          changePasswordRequestState: RequestState.error,
          changePasswordError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(state.copyWith(
          changePasswordRequestState: RequestState.loaded,
          changePasswordMsg: msg,
        ));
      },
    );
  }

  void deleteAccount() async {
    emit(state.copyWith(deleteAccountRequestState: RequestState.loading));

    final result = await _profileRepository.deleteAccount();

    result.fold(
      (failure) {
        emit(state.copyWith(
          deleteAccountRequestState: RequestState.error,
          deleteAccountError: failure,
        ));
        log(failure.toString());
      },
      (msg) async {
        emit(state.copyWith(
          deleteAccountRequestState: RequestState.loaded,
          deleteAccountMsg: msg,
        ));
        await SecureStorageServices().deleteCookie().then((value) => value);
        SocketService().token = null;
        serviceLocator<IAppLocalStorage>().deleteValue(AppStrings.userImage);
        serviceLocator<IAppLocalStorage>().deleteValue(AppStrings.userName);
      },
    );
  }

  void getAgencies() async {
    print('status  $status');
    agenciesLength = 0;
    emit(state.copyWith(getAgenciesRequestState: RequestState.loading));

    final result = await _profileRepository.getAgencies(status);

    result.fold(
      (failure) {
        emit(state.copyWith(
          getAgenciesRequestState: RequestState.error,
          getAgenciesError: failure,
        ));
        log(failure.toString());
      },
      (model) {
        agencies = model.data;
        agenciesLength = agencies.length;
        emit(state.copyWith(
          getAgenciesRequestState: RequestState.loaded,
          getAgenciesModel: model,
        ));
      },
    );
  }

  void createAgency() async {
    if (!createAgenciesKey.currentState!.validate()) return;
    emit(state.copyWith(createAgencyRequestState: RequestState.loading));
    CreateAgencyParams params = CreateAgencyParams(
      agencyName: agencyNameController.text.trim(),
      agencyNumber: agencyNumberController.text.trim(),
      agencyIssuedDate: agencyIssuedDateController.text.trim(),
      agencyAttachment: agencyAttachment!,
      identityNumber: agencyIdentityNumberController.text.trim(),
    );
    final result = await _profileRepository.createAgency(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          createAgencyRequestState: RequestState.error,
          createAgencyError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(state.copyWith(
          createAgencyRequestState: RequestState.loaded,
          createAgencyMsg: msg,
        ));
        // getAgencies();
        clearCreateAgenciesData();
      },
    );
  }

  void clearCreateAgenciesData() {
    agencyIssuedDateController.clear();
    agencyNameController.clear();
    agencyNumberController.clear();
    agencyAttachment = null;
    agencyIdentityNumberController.clear();
  }

  Future pickAgencyAttachment() async {
    agencyAttachment = await pickFile();
    if (agencyAttachment != null) {
      emit(
        state.copyWith(
          agencyAttachment: agencyAttachment,
        ),
      );
    }
  }

  deleteAgencyAttachment() async {
    agencyAttachment = null;

    emit(state.copyWith(
      changeProfileImageRequestState: RequestState.loaded,
      agencyAttachment: null,
    ));
    emit(state.copyWith(
      changeProfileImageRequestState: RequestState.ideal,
      agencyAttachment: null,
    ));
  }

  void deleteAgencies() async {
    emit(state.copyWith(deleteAgenciesRequestState: RequestState.loading));

    final result = await _profileRepository.deleteAgencies(agencyId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          deleteAgenciesRequestState: RequestState.error,
          deleteAgenciesError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(state.copyWith(
          deleteAgenciesRequestState: RequestState.loaded,
          deleteAgenciesMsg: msg,
        ));
        print('deleteAgencies success');
        // getAgencies();
      },
    );
  }

  void activeAgencies() async {
    emit(state.copyWith(activeAgenciesRequestState: RequestState.loading));

    final result = await _profileRepository.activeAgencies(agencyId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          activeAgenciesRequestState: RequestState.error,
          activeAgenciesError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(state.copyWith(
          activeAgenciesRequestState: RequestState.loaded,
          activeAgenciesMsg: msg,
        ));
      },
    );
  }

  void logOut() async {
    emit(state.copyWith(logOutRequestState: RequestState.loading));

    final result = await _profileRepository.logOut();

    result.fold(
      (failure) {
        emit(state.copyWith(
          logOutRequestState: RequestState.error,
          logOutError: failure,
        ));
        log(failure.toString());
      },
      (msg) async {
        emit(state.copyWith(
          logOutRequestState: RequestState.loaded,
          logOutMsg: msg,
        ));
        await SecureStorageServices().deleteCookie().then((value) => value);
        SocketService().token = null;
        serviceLocator<IAppLocalStorage>().deleteValue(AppStrings.userImage);
        serviceLocator<IAppLocalStorage>().deleteValue(AppStrings.userName);
      },
    );
  }
}
