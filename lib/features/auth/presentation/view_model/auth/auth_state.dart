// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.getCountriesRequestState = RequestState.ideal,
    this.getCountriesError,
    this.getCountriesModel,
    this.loginMsg,
    this.completeSignUpMsg,
    this.forgetPassWordMsg,
    this.resendCodeMsg,
    this.resendCodeRequestState = RequestState.ideal,
    this.resendCodeError,
    this.passwordVisiblity,
    this.signUpRequestState = RequestState.ideal,
    this.signUpError,
    this.signUpModel,
    this.completeSignUpRequestState = RequestState.ideal,
    this.completeSignUpError,
    this.verifyRequestState = RequestState.ideal,
    this.verifyError,
    this.authModel,
    this.loginRequestState = RequestState.ideal,
    this.loginError,
    this.forgetPassWordRequestState = RequestState.ideal,
    this.forgetPassWordError,
    this.resetPasswordRequestState = RequestState.ideal,
    this.resetPasswordError,
  });
  final bool? passwordVisiblity;

  final RequestState loginRequestState;
  final Failure? loginError;
  final String? loginMsg;
  //
  final RequestState signUpRequestState;
  final Failure? signUpError;
  final SignUpModel? signUpModel;
  //
  //
  final RequestState getCountriesRequestState;
  final Failure? getCountriesError;
  final CountriesModel? getCountriesModel;
  //
  final RequestState completeSignUpRequestState;
  final Failure? completeSignUpError;
  final String? completeSignUpMsg;
  //
  final RequestState forgetPassWordRequestState;
  final Failure? forgetPassWordError;
  final String? forgetPassWordMsg;
  //
  final RequestState resetPasswordRequestState;
  final Failure? resetPasswordError;

  //
  final RequestState verifyRequestState;
  final Failure? verifyError;
  //
  final RequestState resendCodeRequestState;
  final Failure? resendCodeError;
  final String? resendCodeMsg;
  //
  final AuthModel? authModel;

  @override
  List<Object?> get props {
    return [
      getCountriesRequestState,
      getCountriesError,
      getCountriesModel,
      loginMsg,
      forgetPassWordMsg,
      completeSignUpMsg,
      resendCodeMsg,
      passwordVisiblity,
      loginError,
      loginRequestState,
      signUpError,
      signUpModel,
      signUpRequestState,
      completeSignUpError,
      completeSignUpRequestState,
      forgetPassWordError,
      forgetPassWordRequestState,
      verifyError,
      verifyRequestState,
      resetPasswordError,
      resetPasswordRequestState,
      authModel,
      resendCodeError,
      resendCodeRequestState,
    ];
  }

  AuthState copyWith({
    bool? passwordVisiblity,
    RequestState? loginRequestState,
    Failure? loginError,
    String? loginMsg,
    RequestState? signUpRequestState,
    Failure? signUpError,
    SignUpModel? signUpModel,
    RequestState? getCountriesRequestState,
    Failure? getCountriesError,
    CountriesModel? getCountriesModel,
    RequestState? completeSignUpRequestState,
    Failure? completeSignUpError,
    String? completeSignUpMsg,
    RequestState? forgetPassWordRequestState,
    Failure? forgetPassWordError,
    String? forgetPassWordMsg,
    RequestState? resetPasswordRequestState,
    Failure? resetPasswordError,
    RequestState? verifyRequestState,
    Failure? verifyError,
    RequestState? resendCodeRequestState,
    Failure? resendCodeError,
    String? resendCodeMsg,
    AuthModel? authModel,
  }) {
    return AuthState(
      passwordVisiblity: passwordVisiblity ?? this.passwordVisiblity,
      loginRequestState: loginRequestState ?? this.loginRequestState,
      loginError: loginError ?? this.loginError,
      loginMsg: loginMsg ?? this.loginMsg,
      signUpRequestState: signUpRequestState ?? this.signUpRequestState,
      signUpError: signUpError ?? this.signUpError,
      signUpModel: signUpModel ?? this.signUpModel,
      getCountriesRequestState:
          getCountriesRequestState ?? this.getCountriesRequestState,
      getCountriesError: getCountriesError ?? this.getCountriesError,
      getCountriesModel: getCountriesModel ?? this.getCountriesModel,
      completeSignUpRequestState:
          completeSignUpRequestState ?? this.completeSignUpRequestState,
      completeSignUpError: completeSignUpError ?? this.completeSignUpError,
      completeSignUpMsg: completeSignUpMsg ?? this.completeSignUpMsg,
      forgetPassWordRequestState:
          forgetPassWordRequestState ?? this.forgetPassWordRequestState,
      forgetPassWordError: forgetPassWordError ?? this.forgetPassWordError,
      forgetPassWordMsg: forgetPassWordMsg ?? this.forgetPassWordMsg,
      resetPasswordRequestState:
          resetPasswordRequestState ?? this.resetPasswordRequestState,
      resetPasswordError: resetPasswordError ?? this.resetPasswordError,
      verifyRequestState: verifyRequestState ?? this.verifyRequestState,
      verifyError: verifyError ?? this.verifyError,
      resendCodeRequestState:
          resendCodeRequestState ?? this.resendCodeRequestState,
      resendCodeError: resendCodeError ?? this.resendCodeError,
      resendCodeMsg: resendCodeMsg ?? this.resendCodeMsg,
      authModel: authModel ?? this.authModel,
    );
  }
}
