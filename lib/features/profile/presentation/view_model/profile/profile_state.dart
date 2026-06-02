// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.askEditPhoneRequestState = RequestState.ideal,
    this.askEditPhoneError,
    this.askEditPhoneMsg,
    this.addPhoneRequestState = RequestState.ideal,
    this.addPhoneError,
    this.addPhoneModelMsg,
    this.logOutRequestState = RequestState.ideal,
    this.logOutError,
    this.logOutMsg,
    this.getAgenciesRequestState = RequestState.ideal,
    this.getAgenciesError,
    this.getAgenciesModel,
    this.createAgencyRequestState = RequestState.ideal,
    this.createAgencyError,
    this.createAgencyMsg,
    this.deleteAgenciesRequestState = RequestState.ideal,
    this.deleteAgenciesError,
    this.deleteAgenciesMsg,
    this.activeAgenciesRequestState = RequestState.ideal,
    this.activeAgenciesError,
    this.activeAgenciesMsg,
    this.deleteAccountRequestState = RequestState.ideal,
    this.deleteAccountError,
    this.deleteAccountMsg,
    this.imageFile,
    this.editUserInfoCountryID,
    this.agencyAttachment,
    this.changeProfileImageRequestState = RequestState.ideal,
    this.changeProfileImageError,
    this.changeProfileImageMsg,
    this.askAddEmailRequestState = RequestState.ideal,
    this.askAddEmailError,
    this.askAddEmailMsg,
    this.addEmailRequestState = RequestState.ideal,
    this.addEmailError,
    this.addEmailModelMsg,
    this.changePasswordRequestState = RequestState.ideal,
    this.changePasswordError,
    this.changePasswordMsg,
    this.profileRequestState = RequestState.ideal,
    this.profileError,
    this.profileModel,
  });

  final RequestState profileRequestState;
  final Failure? profileError;
  final ProfileModel? profileModel;
  //
  final RequestState changeProfileImageRequestState;
  final Failure? changeProfileImageError;
  final String? changeProfileImageMsg;
  final File? imageFile;
  final String? editUserInfoCountryID;

  //
  final RequestState askAddEmailRequestState;
  final Failure? askAddEmailError;
  final String? askAddEmailMsg;
  //
  final RequestState addEmailRequestState;
  final Failure? addEmailError;
  final String? addEmailModelMsg;
  //
  //
  final RequestState askEditPhoneRequestState;
  final Failure? askEditPhoneError;
  final String? askEditPhoneMsg;
  //
  final RequestState addPhoneRequestState;
  final Failure? addPhoneError;
  final String? addPhoneModelMsg;
  //
  final RequestState changePasswordRequestState;
  final Failure? changePasswordError;
  final String? changePasswordMsg;
  //
  //
  final RequestState deleteAccountRequestState;
  final Failure? deleteAccountError;
  final String? deleteAccountMsg;
  //
  //
  final RequestState getAgenciesRequestState;
  final Failure? getAgenciesError;
  final AgenciesModel? getAgenciesModel;
  //
  //
  final RequestState createAgencyRequestState;
  final Failure? createAgencyError;
  final String? createAgencyMsg;
  final File? agencyAttachment;
  //
  //
  final RequestState deleteAgenciesRequestState;
  final Failure? deleteAgenciesError;
  final String? deleteAgenciesMsg;
  //
  //
  final RequestState activeAgenciesRequestState;
  final Failure? activeAgenciesError;
  final String? activeAgenciesMsg;
  //
  //
  final RequestState logOutRequestState;
  final Failure? logOutError;
  final String? logOutMsg;
  //

  @override
  List<Object?> get props => [
        askEditPhoneRequestState,
        askEditPhoneError,
        askEditPhoneMsg,
        addPhoneRequestState,
        addPhoneError,
        addPhoneModelMsg,
        logOutError,
        logOutMsg,
        logOutRequestState,
        getAgenciesError,
        getAgenciesModel,
        getAgenciesRequestState,
        activeAgenciesError,
        activeAgenciesMsg,
        activeAgenciesRequestState,
        createAgencyError,
        createAgencyMsg,
        createAgencyRequestState,
        deleteAccountError,
        deleteAccountMsg,
        deleteAccountRequestState,
        imageFile,
        profileRequestState,
        profileError,
        profileModel,
        changeProfileImageError,
        changeProfileImageRequestState,
        changeProfileImageMsg,
        askAddEmailError,
        askAddEmailMsg,
        askAddEmailRequestState,
        addEmailError,
        addEmailModelMsg,
        addEmailRequestState,
        changePasswordError,
        changePasswordMsg,
        changePasswordRequestState,
        agencyAttachment,
        deleteAgenciesError,
        deleteAgenciesMsg,
        deleteAccountRequestState,
        editUserInfoCountryID
      ];

  ProfileState copyWith({
    RequestState? profileRequestState,
    Failure? profileError,
    ProfileModel? profileModel,
    RequestState? changeProfileImageRequestState,
    Failure? changeProfileImageError,
    String? changeProfileImageMsg,
    File? imageFile,
    String? editUserInfoCountryID,
    RequestState? askAddEmailRequestState,
    Failure? askAddEmailError,
    String? askAddEmailMsg,
    RequestState? addEmailRequestState,
    Failure? addEmailError,
    String? addEmailModelMsg,
    RequestState? askEditPhoneRequestState,
    Failure? askEditPhoneError,
    String? askEditPhoneMsg,
    RequestState? addPhoneRequestState,
    Failure? addPhoneError,
    String? addPhoneModelMsg,
    RequestState? changePasswordRequestState,
    Failure? changePasswordError,
    String? changePasswordMsg,
    RequestState? deleteAccountRequestState,
    Failure? deleteAccountError,
    String? deleteAccountMsg,
    RequestState? getAgenciesRequestState,
    Failure? getAgenciesError,
    AgenciesModel? getAgenciesModel,
    RequestState? createAgencyRequestState,
    Failure? createAgencyError,
    String? createAgencyMsg,
    File? agencyAttachment,
    RequestState? deleteAgenciesRequestState,
    Failure? deleteAgenciesError,
    String? deleteAgenciesMsg,
    RequestState? activeAgenciesRequestState,
    Failure? activeAgenciesError,
    String? activeAgenciesMsg,
    RequestState? logOutRequestState,
    Failure? logOutError,
    String? logOutMsg,
  }) {
    return ProfileState(
      profileRequestState: profileRequestState ?? this.profileRequestState,
      profileError: profileError ?? this.profileError,
      profileModel: profileModel ?? this.profileModel,
      changeProfileImageRequestState:
          changeProfileImageRequestState ?? this.changeProfileImageRequestState,
      changeProfileImageError:
          changeProfileImageError ?? this.changeProfileImageError,
      changeProfileImageMsg:
          changeProfileImageMsg ?? this.changeProfileImageMsg,
      imageFile: imageFile ?? this.imageFile,
      editUserInfoCountryID:
          editUserInfoCountryID ?? this.editUserInfoCountryID,
      askAddEmailRequestState:
          askAddEmailRequestState ?? this.askAddEmailRequestState,
      askAddEmailError: askAddEmailError ?? this.askAddEmailError,
      askAddEmailMsg: askAddEmailMsg ?? this.askAddEmailMsg,
      addEmailRequestState: addEmailRequestState ?? this.addEmailRequestState,
      addEmailError: addEmailError ?? this.addEmailError,
      addEmailModelMsg: addEmailModelMsg ?? this.addEmailModelMsg,
      askEditPhoneRequestState:
          askEditPhoneRequestState ?? this.askEditPhoneRequestState,
      askEditPhoneError: askEditPhoneError ?? this.askEditPhoneError,
      askEditPhoneMsg: askEditPhoneMsg ?? this.askEditPhoneMsg,
      addPhoneRequestState: addPhoneRequestState ?? this.addPhoneRequestState,
      addPhoneError: addPhoneError ?? this.addPhoneError,
      addPhoneModelMsg: addPhoneModelMsg ?? this.addPhoneModelMsg,
      changePasswordRequestState:
          changePasswordRequestState ?? this.changePasswordRequestState,
      changePasswordError: changePasswordError ?? this.changePasswordError,
      changePasswordMsg: changePasswordMsg ?? this.changePasswordMsg,
      deleteAccountRequestState:
          deleteAccountRequestState ?? this.deleteAccountRequestState,
      deleteAccountError: deleteAccountError ?? this.deleteAccountError,
      deleteAccountMsg: deleteAccountMsg ?? this.deleteAccountMsg,
      getAgenciesRequestState:
          getAgenciesRequestState ?? this.getAgenciesRequestState,
      getAgenciesError: getAgenciesError ?? this.getAgenciesError,
      getAgenciesModel: getAgenciesModel ?? this.getAgenciesModel,
      createAgencyRequestState:
          createAgencyRequestState ?? this.createAgencyRequestState,
      createAgencyError: createAgencyError ?? this.createAgencyError,
      createAgencyMsg: createAgencyMsg ?? this.createAgencyMsg,
      agencyAttachment: agencyAttachment ?? this.agencyAttachment,
      deleteAgenciesRequestState:
          deleteAgenciesRequestState ?? this.deleteAgenciesRequestState,
      deleteAgenciesError: deleteAgenciesError ?? this.deleteAgenciesError,
      deleteAgenciesMsg: deleteAgenciesMsg ?? this.deleteAgenciesMsg,
      activeAgenciesRequestState:
          activeAgenciesRequestState ?? this.activeAgenciesRequestState,
      activeAgenciesError: activeAgenciesError ?? this.activeAgenciesError,
      activeAgenciesMsg: activeAgenciesMsg ?? this.activeAgenciesMsg,
      logOutRequestState: logOutRequestState ?? this.logOutRequestState,
      logOutError: logOutError ?? this.logOutError,
      logOutMsg: logOutMsg ?? this.logOutMsg,
    );
  }
}
