// import 'package:flutter/material.dart';
// import 'package:pregnancy_application/core/utils/app_colors.dart';
// import 'package:pregnancy_application/core/utils/media_query_values.dart';

// import '../../config/routes/app_routes.dart';

// void goToImagePreview(BuildContext context, List<String> image) {
//   context.navigateToWithArguments(
//     Routes.imageViewRoute,
//     image,
//     // [
//     //   "https://images.freeimages.com/images/large-previews/303/random-art-2-1542645.jpg",
//     //   "https://media.istockphoto.com/id/1395878839/photo/despair.jpg?s=2048x2048&w=is&k=20&c=1StBH3t5NnmqeR3aFOeqFBWskQeFdqCImhs5hGfvfqw=",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     //   "https://images.freeimages.com/images/large-previews/f48/random-pics-1-1324287.jpg",
//     // ],
//   );
// }

// String getStatus(int status) {
//   if (status == 1) {
//     return 'مقبولة';
//   } else if (status == 2) {
//     return 'مرفوضة';
//   } else {
//     return 'تحت الإجراء';
//   }
// }

// Color getColor(int status) {
//   if (status == 1) {
//     return AppColors.primary;
//   } else if (status == 2) {
//     return AppColors.error;
//   } else {
//     return AppColors.secondColor;
//   }
// }

class GlobalVar {
  const GlobalVar._();
  static const GlobalVar _instance = GlobalVar._();
  static bool KisAnonymous = false;
}

class Privacy {
  const Privacy._();
  static const Privacy _instance = Privacy._();
  factory Privacy() => _instance;
  static String titleOfScreen = """
Welcome to Sirtz.com. We are committed to protecting your privacy and ensuring that your experience with us is safe and enjoyable. This policy explains how we collect, use and protect your personal information.
""";

  static List<String> titleList = [
    "1. Collect information",
    "2. Use of information",
    "    3. Information protection",
    "4. Share information",
    "5. Your rights",
    "6. Changes in policy",
    "7. Contact us",
  ];
  static List<String> descList = [
    """
When you register and use our site, we may collect the following
- user name
- E-mail
- mobile number
- password
""",
    """
We use the information we collect for the following purposes:
- Create your personal account and log in.
- Providing the services you request.
- Communicate with you about your account or our services.
- Improving and developing our services.
- Protecting our website and our users.""",
    """We take steps to protect your personal information from unauthorized access, disclosure, modification or destruction. The security measures we use include:
- Data encryption.
- Restrictions on access to personal information.
- Periodic security reviews.""",
    """We do not sell, rent, or share your personal information with third parties except in the following cases:
- When you agree to this.
- If we are required to do so by law.
- To protect our rights, property, or the safety of our users.""",
    """
You have the right to access, correct or delete the personal information we hold about you. You can do this through your account settings or contact us directly.
""",
    """We may update this policy from time to time. We will notify you of any changes by posting the new policy on our website. We advise you to review this policy regularly.""",
    """If you have any questions or concerns about this Policy or how we use your personal information, please contact us via email at support@sirtz.com."""
  ];
}
