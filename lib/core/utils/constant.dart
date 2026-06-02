import 'package:flutter/material.dart';

class AppConstant {
  const AppConstant._();
  static const AppConstant _instance = AppConstant._();
  factory AppConstant() => _instance;

  static Widget horizontalDivider() => const Divider(color: Colors.transparent);
  static Widget verticalDivider() =>
      const VerticalDivider(color: Colors.transparent);

  static const String skipOnBoarding = 'skipOnBoarding';
  static const String token = 'token';
  static const String userName = 'userName';
  static const String userImage = 'userImage';
  static String cityId = 'cityID';
  static String countryId = 'countryID';
  static String countryName = 'countryName';
  static String downloadsBox = 'downloads';
  static String isFromFormsScreen = 'isFromFormsScreen';

  static String authState = 'authState';
}
