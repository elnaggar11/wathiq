class EndPoint {
  static const String baseUrl = 'https://api.ittlt.com';
  // static const String baseUrl = 'https://api.broker.sa';
  // static const String baseUrl = 'https://api.wathiq.sa.com';
  //! Auth
  static const String signUp = '/api/users/signup';
  static const String completeSignUp = '/api/users/signup';
  static const String verify = '/api/users/verify-code';
  static const String resendCode = '/api/users/resend-code';
  static const String login = '/api/users/signin';
  static const String forgetPassword = '/api/users/forget-password';
  static const String resetPassword = '/api/users/forget-password';
  static const String countries = '/api/users/countries';
  //paegs
  static const String getQuestions = '/api/users/questions';
  static const String getCategories = '/api/users/categories';
  static const String getSocial = '/api/users/social';
  static const String addRealState = '/api/users/real-estate';
  static const String contactUs = '/api/users/contact-us';
  static const String createSalesAgent = '/api/users/provider-requests';
  static const String notifications = '/api/users/notifications';

  //profile
  static const String profile = '/api/users/profile';
  static const String changeProfileImage = '/api/users/profile';
  static const String changePassword = '/api/users/change-password';
  static const String email = '/api/users/email';
  static const String phone = '/api/users/phone-number';
  static const String agencies = '/api/users/agencies';
  static const String logOut = '/api/users/logout';

  //home
  static const String getAuctions = '/api/users/auctions';
  static const String getUserAuctions = '/api/users/auctions/user-auctions';
  static const String favorite = '/api/users/favorites';
  static const String enrollment = '/api/users/auction-enrollment';
  static const String getWallet = '/api/users/wallet';
  static const String addWalletBalance = '/api/users/wallet/add-balance';
  static const String privacyPolicy = '/api/admin/privacy-policy';
  static const String heldFunds = '/api/users/wallet/held-funds';
  static const String getUserInvoices = '/api/users/wallet/invoices';
  static const String getWithdraw = '/api/users/withdraw';
  static const String posWithdraw = '/api/users/withdraw';
  //
  static const String checkEmail = '/password/check-email';
  static const String checkCode = '/password/check-code';
  static const String deleteAccount = '/delete-account';
}
