import 'package:dio/dio.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/params/add_real_state_params.dart';
import '../../../../core/params/contact_us_params.dart';
import '../../../../core/params/get_questions_params.dart';
import '../../../../core/params/profile/sales_agent_params.dart';
import '../../../../core/params/properity_managment.dart';

class PagesRemoteDataSource {
  final ApiConsumer apiConsumer;

  PagesRemoteDataSource({required this.apiConsumer});

  Future<Response> addRealState(AddRealStateParams params) async {
    final response = await apiConsumer.post(
      EndPoint.addRealState,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> properityManagment(ProperityManagment params) async {
    final response = await apiConsumer.post(
      EndPoint.addRealState,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> getQuestions(GetQuestionsParams params) async {
    final response = await apiConsumer.get(EndPoint.getQuestions, query: {
      if (params.categoryId != null) 'category': params.categoryId,
      if (params.search != null || params.search != '') 'search': params.search,
    });
    return response;
  }

  Future<Response> getCategories() async {
    final response = await apiConsumer.get(
      EndPoint.getCategories,
    );
    return response;
  }

  Future<Response> getNotifications() async {
    final response = await apiConsumer.get(
      EndPoint.notifications,
    );
    return response;
  }

  Future<Response> deleteNotifications() async {
    final response = await apiConsumer.delete(
      EndPoint.notifications,
    );
    return response;
  }

  Future<Response> getSocial() async {
    final response = await apiConsumer.get(
      EndPoint.getSocial,
    );
    return response;
  }

  Future<Response> postcontactUs(ContactUsParams params) async {
    final response = await apiConsumer.post(
      EndPoint.contactUs,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> createSalesAgent(SalesAgentParams params) async {
    var body = await params.toFormData();
    print('body ${body.fields}');
    final response = await apiConsumer.post(
      EndPoint.createSalesAgent,
      body: body,
    );
    return response;
  }
}
