import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/features/paegs/data/models/notification_model.dart';
import 'package:wathiq/features/paegs/data/models/question_model.dart';
import 'package:wathiq/features/paegs/data/models/social_model.dart';

import '../../../../app/injector.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/functions/pick_images_and_files.dart';
import '../../../../core/params/add_real_state_params.dart';
import '../../../../core/params/contact_us_params.dart';
import '../../../../core/params/get_questions_params.dart';
import '../../../../core/params/profile/sales_agent_params.dart';
import '../../../../core/params/properity_managment.dart';
import '../../../../core/storage/i_app_local_storage.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../data/models/categories_model.dart';
import '../../data/repository/pages_repo.dart';
import '../../data/socket/notifications_socket.dart';

part 'pages_state.dart';

class PagesCubit extends Cubit<PagesState> {
  PagesCubit(this._pageRepository) : super(PagesState());

  final PagesRepository _pageRepository;
  QestionsCategory? category;
  final questionsSearchController = TextEditingController();
  final messageController = TextEditingController();
  final nameController = TextEditingController();
  String taxType = 'خاضع للضريبة';
  String typeOfContactUs = 'suggestion';
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ContactFormKey = GlobalKey<FormState>();
  // create sales
  final bankCertificateController = TextEditingController();
  final commissionerAttachmentsController = TextEditingController();
  final companyAttachmentsController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyPhoneNumberController = TextEditingController();
  final companyPhoneKeyController = TextEditingController();
  final bankAccountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final realEstateActivityController =
      TextEditingController(text: 'مزادات عقارية');
  final valAuctionsLicenseNumberController = TextEditingController();
  final taxTypeController = TextEditingController();
  final taxNumberController = TextEditingController();
  final commercialRegNumberController = TextEditingController();
  final commercialRegStartDateController = TextEditingController();
  final commercialRegEndDateController = TextEditingController();
  final userNameController = TextEditingController();
  final userPhoneKeyController = TextEditingController();
  final userPhoneNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final userBirthDayController = TextEditingController();
  final userIdentityNumberController = TextEditingController();
  final userPasswordController = TextEditingController();
  final companyDataFormKey = GlobalKey<FormState>();
  final bankDateFormKey = GlobalKey<FormState>();
  final UserDataFormKey = GlobalKey<FormState>();
  //bank
  File? bankCertificate;

  //company
  File? valAttachment;
  File? commercialRegisterAttachment;
  File? TaxRegisterAttachment;
  //user
  File? NationalIDAttachment;
  File? AssociationAttachment;
  File? DelegationAttachment;
  //
  bool approvedByNafath = true;
  bool accreditationRequest = false;

  //Notifications
  List<NotificationModel> notifications = [];

  final notificationsSocket = NotificationsSocket();

  final realStatephoneNumberController = TextEditingController();
  final realStateNameController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final descriptionController = TextEditingController();
  bool certifiedNotifier = true;
  final addRealFormKey = GlobalKey<FormState>();
  //
  final properityPhoneNumberController = TextEditingController();
  final properityRealTypeController = TextEditingController();
  final properityCityController = TextEditingController();
  final properityAreaController = TextEditingController();
  final properityNeighborhoodController = TextEditingController();
  final properityRealeCategoryController = TextEditingController();
  final properityFormKey = GlobalKey<FormState>();
  void addRealState() async {
    if (!addRealFormKey.currentState!.validate()) return;
    emit(state.copyWith(addRealStateRequestState: RequestState.loading));
    AddRealStateParams params = AddRealStateParams(
      phoneNumber: realStatephoneNumberController.text.trim(),
      name: realStateNameController.text.trim(),
      city: cityController.text.trim(),
      area: areaController.text.trim(),
      neighborhood: neighborhoodController.text.trim(),
      certified: certifiedNotifier,
      description: descriptionController.text.trim(),
    );
    final result = await _pageRepository.addRealState(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          addRealStateRequestState: RequestState.error,
          addRealStateError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(
          state.copyWith(
            addRealStateRequestState: RequestState.loaded,
            addRealStateMessage: msg,
          ),
        );
        clearAddRealStetaFormFields();
      },
    );
  }

  void properityManagment() async {
    if (!addRealFormKey.currentState!.validate()) return;
    emit(state.copyWith(properityManagmentRequestState: RequestState.loading));
    ProperityManagment params = ProperityManagment(
      area: properityAreaController.text.trim(),
      city: properityCityController.text.trim(),
      neighborhood: properityNeighborhoodController.text.trim(),
      realType: properityRealTypeController.text.trim(),
      realCategory: properityRealeCategoryController.text.trim(),
      phoneNumber: properityPhoneNumberController.text.trim(),
    );
    final result = await _pageRepository.properityManagment(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          properityManagmentRequestState: RequestState.error,
          properityManagmentError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(
          state.copyWith(
            properityManagmentRequestState: RequestState.loaded,
            properityManagmentMessage: msg,
          ),
        );
        clearProperityManagmentFormFields();
      },
    );
  }

  void clearProperityManagmentFormFields() {
    properityPhoneNumberController.clear();
    properityRealTypeController.clear();
    properityCityController.clear();
    properityAreaController.clear();
    properityNeighborhoodController.clear();
  }

  void clearAddRealStetaFormFields() {
    realStateNameController.clear();
    realStatephoneNumberController.clear();
    cityController.clear();
    areaController.clear();
    neighborhoodController.clear();
    descriptionController.clear();
  }

  getUserCashedData() {
    dynamic Useremail =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.Useremail) ?? '';
    dynamic userName =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.userName) ?? "";
    dynamic phoneNum =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.phoneNum) ?? '';
    emailController.text = Useremail;
    phoneNumberController.text = phoneNum;
    nameController.text = userName;
  }

  Future getUnReadCount() async {
    emit(
      state.copyWith(
        getNotificationsRequestState: RequestState.loading,
      ),
    );

    notificationsSocket.unReadCountStream.listen((count) {
      emit(
        state.copyWith(
          getNotificationsRequestState: RequestState.loaded,
          notificationCount: count,
        ),
      );
    });
    notificationsSocket.emitUnReadCount();
    log("unread cont is ${state.notificationCount}");
    emit(
      state.copyWith(
        getNotificationsRequestState: RequestState.loaded,
      ),
    );
  }

  void newNotifications() async {
    notificationsSocket.newNotificationStream.listen(
      (notification) {
        if (!notifications.contains(notification)) {
          notifications.insert(0, notification);
        }
        if (!isClosed)
          emit(state.copyWith(
            getNotificationsRequestState: RequestState.loaded,
            notifications: notifications,
          ));
      },
    );
  }

  void getNotifications() async {
    emit(state.copyWith(getNotificationsRequestState: RequestState.loading));
    final result = await _pageRepository.getNotifications();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getNotificationsRequestState: RequestState.error,
          notificationsError: failure,
        ));
        log(failure.toString());
      },
      (r) {
        notifications = r;
        emit(state.copyWith(
          getNotificationsRequestState: RequestState.loaded,
          notifications: r,
        ));
      },
    );
  }

  void deleteNotifications() async {
    emit(state.copyWith(deleteNotificationsRequestState: RequestState.loading));
    final result = await _pageRepository.deleteNotifications();

    result.fold(
      (failure) {
        emit(state.copyWith(
          deleteNotificationsRequestState: RequestState.error,
          deleteNotificationsError: failure,
        ));
        log(failure.toString());
      },
      (r) {
        emit(state.copyWith(
          deleteNotificationsRequestState: RequestState.loaded,
          deleteNotificationsMessage: r,
        ));
        getNotifications();
      },
    );
  }

  void getQuestions() async {
    emit(state.copyWith(qestionsRequestState: RequestState.loading));
    GetQuestionsParams questionsParams = GetQuestionsParams(
      categoryId: category?.id,
      search: questionsSearchController.text,
    );
    final result = await _pageRepository.getQuestions(questionsParams);

    result.fold(
      (failure) {
        emit(state.copyWith(
          qestionsRequestState: RequestState.error,
          qestionsError: failure,
        ));
        log(failure.toString());
      },
      (qestionsModel) {
        emit(state.copyWith(
          qestionsRequestState: RequestState.loaded,
          qestionsModel: qestionsModel,
        ));
      },
    );
  }

  void getQestionsCategories() async {
    emit(state.copyWith(qestionsCategoriesRequestState: RequestState.loading));
    final result = await _pageRepository.getQestionsCategories();

    result.fold(
      (failure) {
        emit(state.copyWith(
          qestionsCategoriesRequestState: RequestState.error,
          qestionsCategoriesError: failure,
        ));
        log(failure.toString());
      },
      (model) {
        emit(state.copyWith(
          qestionsCategoriesRequestState: RequestState.loaded,
          qestionsCategoriesModel: model,
        ));
      },
    );
  }

  void getSocial() async {
    emit(state.copyWith(getsocialRequestState: RequestState.loading));
    final result = await _pageRepository.getSocial();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getsocialRequestState: RequestState.error,
          socialError: failure,
        ));
        log(failure.toString());
      },
      (model) {
        emit(state.copyWith(
          getsocialRequestState: RequestState.loaded,
          socialModel: model,
        ));
      },
    );
  }

  void postcontactUs() async {
    if (!ContactFormKey.currentState!.validate()) return;
    emit(state.copyWith(postcontactUsRequestState: RequestState.loading));
    ContactUsParams params = ContactUsParams(
      phoneNumber: phoneNumberController.text,
      email: emailController.text,
      type: typeOfContactUs,
      name: nameController.text,
      message: messageController.text,
    );
    final result = await _pageRepository.postcontactUs(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          postcontactUsRequestState: RequestState.error,
          postcontactUsError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(
          state.copyWith(
            postcontactUsRequestState: RequestState.loaded,
            postcontactUMessage: msg,
          ),
        );
        cleareControllers();
      },
    );
  }

  void createSalesAgent() async {
    if (!validateDates()) {
      return;
    }
    SalesAgentParams params = getSalesAgentParams();
    emit(state.copyWith(createSalesAgentRequestState: RequestState.loading));
    final result = await _pageRepository.createSalesAgent(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          createSalesAgentRequestState: RequestState.error,
          createSalesAgentError: failure,
        ));
        log(failure.toString());
      },
      (msg) {
        emit(
          state.copyWith(
            createSalesAgentRequestState: RequestState.loaded,
            createSalesAgentMessage: msg,
          ),
        );

        ClearCreateSalesAgentData();
      },
    );
  }

  bool validateDates() {
    if (commercialRegStartDateController.text.isNotEmpty &&
        commercialRegEndDateController.text.isNotEmpty) {
      try {
        DateTime startDate =
            DateTime.parse(commercialRegStartDateController.text);
        DateTime endDate = DateTime.parse(commercialRegEndDateController.text);
        if (endDate.isBefore(startDate)) {
          emit(state.copyWith(
            createSalesAgentRequestState: RequestState.error,
            createSalesAgentError: AppFailure(
                message: 'تاريخ الانتهاء يجب أن يكون بعد تاريخ الإصدار'),
          ));
          return false;
        }
      } catch (e) {
        emit(state.copyWith(
          createSalesAgentRequestState: RequestState.error,
          createSalesAgentError: AppFailure(message: 'تنسيق التاريخ غير صحيح'),
        ));
        return false;
      }
    }
    return true;
  }

  void ClearCreateSalesAgentData() {
    //bank
    bankCertificate = null;
    //company
    valAttachment = null;
    commercialRegisterAttachment = null;
    TaxRegisterAttachment = null;
    //user
    NationalIDAttachment = null;
    AssociationAttachment = null;
    DelegationAttachment = null;
    companyNameController.clear();
    companyEmailController.clear();
    companyPhoneNumberController.clear();
    companyPhoneKeyController.clear();
    bankAccountNumberController.clear();
    bankNameController.clear();
    valAuctionsLicenseNumberController.clear();
    taxNumberController.clear();
    commercialRegNumberController.clear();
    commercialRegStartDateController.clear();
    commercialRegEndDateController.clear();
    userNameController.clear();
    userPhoneKeyController.clear();
    userPhoneNumberController.clear();
    userEmailController.clear();
    userBirthDayController.clear();
    userIdentityNumberController.clear();
    userPasswordController.clear();
  }

  SalesAgentParams getSalesAgentParams() {
    SalesAgentParams params = SalesAgentParams(
      valAttachment: valAttachment,
      commercialAttachment: commercialRegisterAttachment,
      taxAttachment: TaxRegisterAttachment,
      //
      articlesOfAssociation: AssociationAttachment,
      identityAttachment: NationalIDAttachment,
      letterOfAuthorization: DelegationAttachment,
      //
      bankCertificate: bankCertificate,
      companyName: companyNameController.text.trim(),
      companyEmail: companyEmailController.text.trim(),
      companyPhoneNumber: companyPhoneNumberController.text.trim(),
      companyPhoneKey: companyPhoneKeyController.text.trim(),
      bankAccountNumber: bankAccountNumberController.text.trim(),
      bankName: bankNameController.text.trim(),
      realEstateActivity: 'مزادات عقارية',
      valAuctionsLicenseNumber: valAuctionsLicenseNumberController.text.trim(),
      taxType: taxType,
      taxNumber: taxNumberController.text.trim(),
      commercialRegNumber: commercialRegNumberController.text.trim(),
      commercialRegStartDate: commercialRegStartDateController.text.trim(),
      commercialRegEndDate: commercialRegEndDateController.text.trim(),
      userName: userNameController.text.trim(),
      userPhoneKey: userPhoneKeyController.text.trim(),
      userPhoneNumber: userPhoneNumberController.text.trim(),
      userEmail: userEmailController.text.trim(),
      userBirthDay: userBirthDayController.text.trim(),
      userIdentityNumber: userIdentityNumberController.text.trim(),
      userPassword: userPasswordController.text.trim(),
      accreditationRequest: accreditationRequest,
      approvedByNafath: approvedByNafath,
    );
    return params;
  }

  Future pickDelegationAttachment() async {
    DelegationAttachment = await pickFile();
  }

  Future deleteDelegationAttachment() async {
    DelegationAttachment = null;
  }

  Future pickAssociationAttachment() async {
    AssociationAttachment = await pickFile();
  }

  Future deleteAssociationAttachment() async {
    AssociationAttachment = null;
  }

  Future pickNationalIDAttachment() async {
    NationalIDAttachment = await pickFile();
  }

  Future deleteNationalIDAttachment() async {
    NationalIDAttachment = null;
  }

  //company
  Future pickTaxRegisterAttachment() async {
    TaxRegisterAttachment = await pickFile();
  }

  Future deleteTaxRegisterAttachment() async {
    TaxRegisterAttachment = null;
  }

  Future pickCommercialRegisterAttachment() async {
    commercialRegisterAttachment = await pickFile();
  }

  Future deletecommercialRegisterAttachment() async {
    commercialRegisterAttachment = null;
  }

  Future pickvalAttachment() async {
    valAttachment = await pickFile();
  }

  Future deletevalAttachment() async {
    valAttachment = null;
  }

  Future pickbankCertificate() async {
    bankCertificate = await pickFile();
  }

  Future deletebankCertificate() async {
    bankCertificate = null;
  }

  void cleareControllers() {
    phoneNumberController.clear();
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }
}
