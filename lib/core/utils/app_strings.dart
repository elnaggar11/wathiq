class AppStrings {
  const AppStrings._();
  static const AppStrings _instance = AppStrings._();
  factory AppStrings() => _instance;

  static const String noRouteFound = 'No Route Found';

  static const String contentType = 'Content-Type';
  static const String cookie = 'cookie';
  static const String userId = 'userId';
  static const String KisHijri = 'KisHijri';
  static const String isAppLocked = 'isLockApp';

  static const String lang = 'lang';
  static const String fcmToken = 'fcm_token';
  static const String applicationJson = 'application/json';
  static const String serverError = 'Server Error';
  static const String cachedError = 'Cached Error';
  static const String fetchDataError = 'Fetch Data Error';
  static const String unExpectedError = 'UnExpected Error';
  static const String badRequestError = 'Bad Request Error';
  static const String unauthorizedError = 'Un Authorized Error';
  static const String notFoundError = 'Not Found Error';
  static const String conflictError = 'Conflict Error';
  static const String internalServerError = 'Internal Server Error';
  static const String noInternetConnectionError = 'No Internet Connection';
  static const String categoryFailure = 'حدث خطا في تحميل الاقسام';
  static const String tryToGetCategory = 'حاول مجددا';
  static const String genderMale = 'ذكر';
  //
  static const String rejected = 'rejected'; //rejected  approved  pending
  static const String approved = 'approved';
  static const String terminated = 'expired'; //TODO:
  static const String pending = 'pending';
  static const String blocked = 'blocked ';

  //
  static const String userName = 'userName';
  static const String phoneNum = 'phoneNum';
  static const String Useremail = 'Useremail';
  static const String userImage = 'userImage';
  static const String userIdentityNumber = 'userIdentityNumber';
  //auctions status
  static const String auctionsOnGoing = 'on_going'; // الحاليه
  static const String auctionsInProgress = 'in_progress'; //الحاليه
  static const String auctionsCompleted = 'completed';
  //enroll
  static const String enrollShareAsGenuine = 'genuine';
  static const String enrollShareAsAgent = 'agent';
  static const String enrolltypeOnline = 'online';
  static const String enrolltypeOffline = 'offline';

  //
  static const String online = 'online';
  static const String hybrid = 'hybrid';
  static const String offline = 'offline';

  //
  static const String salesAgentIntroText =
      """منصة وثيق هي بوابتك الذكية لعالم المزادات! نقدم لك حلولاً مبتكرة واحترافية لإدارة وتسويق المزادات بكل أنواعها — بسهولة، مرونة، وكفاءة عالية. تواصل معنا الآن وابدأ رحلتك مع الأفضل في تنظيم المزادات.""";
}

bool containsUppercase(String value) {
  return RegExp(r'[A-Z]').hasMatch(value);
}

bool containsLowercase(String value) {
  return RegExp(r'[a-z]').hasMatch(value);
}

bool containsSpecialCharacter(String value) {
  return RegExp(r'[@$!%*?&]').hasMatch(value);
}

bool containsNumber(String value) {
  return RegExp(r'\d').hasMatch(value);
}
