// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pages_cubit.dart';

class PagesState extends Equatable {
  const PagesState({
    this.properityManagmentRequestState = RequestState.ideal,
    this.properityManagmentError,
    this.properityManagmentMessage,
    this.addRealStateRequestState = RequestState.ideal,
    this.addRealStateError,
    this.addRealStateMessage,
    this.deleteNotificationsRequestState = RequestState.ideal,
    this.deleteNotificationsError,
    this.deleteNotificationsMessage,
    this.notificationCount = 0,
    this.getNotificationsRequestState = RequestState.ideal,
    this.createSalesAgentRequestState = RequestState.ideal,
    this.createSalesAgentError,
    this.createSalesAgentMessage,
    this.notificationsError,
    this.postcontactUsRequestState = RequestState.ideal,
    this.postcontactUsError,
    this.postcontactUMessage,
    this.qestionsCategoriesRequestState = RequestState.ideal,
    this.qestionsCategoriesError,
    this.qestionsCategoriesModel,
    this.getsocialRequestState = RequestState.ideal,
    this.socialError,
    this.socialModel,
    this.qestionsRequestState = RequestState.ideal,
    this.qestionsError,
    this.qestionsModel,
    this.notifications,
  });
  final RequestState addRealStateRequestState;
  final Failure? addRealStateError;
  final String? addRealStateMessage;
  //
  final RequestState properityManagmentRequestState;
  final Failure? properityManagmentError;
  final String? properityManagmentMessage;
  //
  final RequestState qestionsRequestState;
  final Failure? qestionsError;
  final QuestionsModel? qestionsModel;
  //
  final RequestState qestionsCategoriesRequestState;
  final Failure? qestionsCategoriesError;
  final QestionsCategoriesModel? qestionsCategoriesModel;
  //
  final RequestState getsocialRequestState;
  final Failure? socialError;
  final SocialModel? socialModel;
  //
  final RequestState postcontactUsRequestState;
  final Failure? postcontactUsError;
  final String? postcontactUMessage;
  //
  //
  final RequestState createSalesAgentRequestState;
  final Failure? createSalesAgentError;
  final String? createSalesAgentMessage;
  //
  final List<NotificationModel>? notifications;
  final RequestState? getNotificationsRequestState;
  final int? notificationCount;
  final Failure? notificationsError;
  //
  final RequestState deleteNotificationsRequestState;
  final Failure? deleteNotificationsError;
  final String? deleteNotificationsMessage;

  @override
  List<Object?> get props => [
        properityManagmentRequestState,
        properityManagmentError,
        properityManagmentMessage,
        addRealStateRequestState,
        addRealStateError,
        addRealStateMessage,
        deleteNotificationsRequestState,
        deleteNotificationsError,
        deleteNotificationsMessage,
        notificationCount,
        notifications,
        notificationsError,
        createSalesAgentError,
        createSalesAgentMessage,
        createSalesAgentRequestState,
        getNotificationsRequestState,
        qestionsRequestState,
        qestionsError,
        qestionsModel,
        qestionsCategoriesError,
        qestionsCategoriesModel,
        qestionsCategoriesRequestState,
        socialError,
        socialModel,
        getsocialRequestState,
        postcontactUMessage,
        postcontactUsError,
        postcontactUsRequestState,
      ];

  PagesState copyWith({
    RequestState? addRealStateRequestState,
    Failure? addRealStateError,
    String? addRealStateMessage,
    RequestState? properityManagmentRequestState,
    Failure? properityManagmentError,
    String? properityManagmentMessage,
    RequestState? qestionsRequestState,
    Failure? qestionsError,
    QuestionsModel? qestionsModel,
    RequestState? qestionsCategoriesRequestState,
    Failure? qestionsCategoriesError,
    QestionsCategoriesModel? qestionsCategoriesModel,
    RequestState? getsocialRequestState,
    Failure? socialError,
    SocialModel? socialModel,
    RequestState? postcontactUsRequestState,
    Failure? postcontactUsError,
    String? postcontactUMessage,
    RequestState? createSalesAgentRequestState,
    Failure? createSalesAgentError,
    String? createSalesAgentMessage,
    List<NotificationModel>? notifications,
    RequestState? getNotificationsRequestState,
    int? notificationCount,
    Failure? notificationsError,
    RequestState? deleteNotificationsRequestState,
    Failure? deleteNotificationsError,
    String? deleteNotificationsMessage,
  }) {
    return PagesState(
      addRealStateRequestState:
          addRealStateRequestState ?? this.addRealStateRequestState,
      addRealStateError: addRealStateError ?? this.addRealStateError,
      addRealStateMessage: addRealStateMessage ?? this.addRealStateMessage,
      properityManagmentRequestState:
          properityManagmentRequestState ?? this.properityManagmentRequestState,
      properityManagmentError:
          properityManagmentError ?? this.properityManagmentError,
      properityManagmentMessage:
          properityManagmentMessage ?? this.properityManagmentMessage,
      qestionsRequestState: qestionsRequestState ?? this.qestionsRequestState,
      qestionsError: qestionsError ?? this.qestionsError,
      qestionsModel: qestionsModel ?? this.qestionsModel,
      qestionsCategoriesRequestState:
          qestionsCategoriesRequestState ?? this.qestionsCategoriesRequestState,
      qestionsCategoriesError:
          qestionsCategoriesError ?? this.qestionsCategoriesError,
      qestionsCategoriesModel:
          qestionsCategoriesModel ?? this.qestionsCategoriesModel,
      getsocialRequestState:
          getsocialRequestState ?? this.getsocialRequestState,
      socialError: socialError ?? this.socialError,
      socialModel: socialModel ?? this.socialModel,
      postcontactUsRequestState:
          postcontactUsRequestState ?? this.postcontactUsRequestState,
      postcontactUsError: postcontactUsError ?? this.postcontactUsError,
      postcontactUMessage: postcontactUMessage ?? this.postcontactUMessage,
      createSalesAgentRequestState:
          createSalesAgentRequestState ?? this.createSalesAgentRequestState,
      createSalesAgentError:
          createSalesAgentError ?? this.createSalesAgentError,
      createSalesAgentMessage:
          createSalesAgentMessage ?? this.createSalesAgentMessage,
      notifications: notifications ?? this.notifications,
      getNotificationsRequestState:
          getNotificationsRequestState ?? this.getNotificationsRequestState,
      notificationCount: notificationCount ?? this.notificationCount,
      notificationsError: notificationsError ?? this.notificationsError,
      deleteNotificationsRequestState: deleteNotificationsRequestState ??
          this.deleteNotificationsRequestState,
      deleteNotificationsError:
          deleteNotificationsError ?? this.deleteNotificationsError,
      deleteNotificationsMessage:
          deleteNotificationsMessage ?? this.deleteNotificationsMessage,
    );
  }
}
