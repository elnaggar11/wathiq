import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/auth/presentation/view/screens/splash_screen.dart';

import '../../../../../app/injector.dart';
import '../../../../../core/storage/i_app_local_storage.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/images.dart';

Future<void> changeAppDateSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return ChangeAppDateSheetBodyWidget();
    },
  );
}

class ChangeAppDateSheetBodyWidget extends StatefulWidget {
  const ChangeAppDateSheetBodyWidget({super.key});

  @override
  State<ChangeAppDateSheetBodyWidget> createState() =>
      _ChangeAppDateSheetBodyWidgetState();
}

class _ChangeAppDateSheetBodyWidgetState
    extends State<ChangeAppDateSheetBodyWidget> {
  bool isHijri = false;

  @override
  void initState() {
    super.initState();
    isHijri =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.KisHijri) ??
            false;
  }

  void toggleDateFormat(bool hijriSelected) {
    setState(() {
      isHijri = hijriSelected;
      KisHijri = hijriSelected;
    });
    serviceLocator<IAppLocalStorage>().setValue(AppStrings.KisHijri, isHijri);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تاريخ التطبيق',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleMedium16(context).copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: SvgPicture.asset(AppAssets.app_imagesCloseSquare),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => toggleDateFormat(false),
                      child: Container(
                        height: 70,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2, // Thicker border for selection
                              color: isHijri
                                  ? Color(0xFFD6D9E1)
                                  : AppColors.primary(context),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'ميلادي',
                            style: AppStyles.styleMedium16(context).copyWith(
                              color: isHijri
                                  ? AppColors.typographyHeading(context)
                                  : AppColors.primary(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => toggleDateFormat(true),
                      child: Container(
                        height: 70,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color: isHijri
                                  ? AppColors.primary(context)
                                  : Color(0xFFD6D9E1),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'هجري',
                            style: AppStyles.styleMedium16(context).copyWith(
                              color: isHijri
                                  ? AppColors.primary(context)
                                  : AppColors.typographyHeading(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
