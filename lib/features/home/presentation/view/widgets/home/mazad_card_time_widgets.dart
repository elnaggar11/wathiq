import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../view_model/home/home_cubit.dart';
import '../../screens/assets_details_screen.dart';

class comingMazadTimeWidget extends StatelessWidget {
  const comingMazadTimeWidget({
    super.key,
    required this.text1,
    required this.text2,
    this.text3,
    this.text4,
    required this.subText1,
    required this.subText2,
    this.subText3,
    this.subText4,
    this.showCurrancyLogo = true,
  });
  final String text1, text2, subText1, subText2;

  final String? text3, text4, subText3, subText4;
  final bool showCurrancyLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFEBEEF3)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DateTimeColumWidget(
                dateLabel: text1,
                date: subText1,
                showCurrancyLogo: showCurrancyLogo,
              ),
              Container(
                height: 54,
                width: 1.2,
                color: AppColors.separatingBorder(context),
              ),
              DateTimeColumWidget(
                dateLabel: text2,
                date: subText2,
                showCurrancyLogo: showCurrancyLogo,
              ),
            ],
          ),
          text3 != null ? SizedBox(height: 12) : SizedBox.shrink(),
          text3 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DateTimeColumWidget(
                      dateLabel: text3 ?? '',
                      date: subText3 ?? '',
                      showCurrancyLogo: false,
                    ),
                    Container(
                      height: 54,
                      width: 1.2,
                      color: AppColors.separatingBorder(context),
                    ),
                    DateTimeColumWidget(
                      dateLabel: text4 ?? '',
                      date: subText4 ?? '',
                      showCurrancyLogo: false,
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class EndAssetsTimeWidget extends StatelessWidget {
  const EndAssetsTimeWidget({
    super.key,
    this.text3,
    this.text4,
    this.subText3,
    this.subText4,
  });

  final String? text3, text4, subText3, subText4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFEBEEF3)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: ShapeDecoration(
              color: Color(0xFFF5FFFC),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0x19EBEEF3)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Color(0x190E8340),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: SvgPicture.asset(Assets.imagesTopUsers),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اعلي مزايدة',
                      style: AppStyles.styleBold14(context).copyWith(
                        color: AppColors.typographySubTitle(context),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '550000',
                          style: AppStyles.styleBold16(context).copyWith(
                            color: AppColors.typographyHeading(context),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 2),
                        CurrancyLogoWidget(
                          maxHeight: 22,
                          maxWidth: 22,
                          color: AppColors.typographyHeading(context),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          text3 != null ? SizedBox(height: 12) : SizedBox.shrink(),
          text3 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DateTimeColumWidget(
                      dateLabel: text3 ?? '',
                      date: subText3 ?? '',
                      showCurrancyLogo: true,
                    ),
                    Container(
                      height: 54,
                      width: 1.2,
                      color: AppColors.separatingBorder(context),
                    ),
                    DateTimeColumWidget(
                      dateLabel: text4 ?? '',
                      date: subText4 ?? '',
                      showCurrancyLogo: true,
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class DateTimeColumWidget extends StatelessWidget {
  const DateTimeColumWidget({
    super.key,
    required this.dateLabel,
    required this.date,
    required this.showCurrancyLogo,
  });
  final String dateLabel, date;
  final bool showCurrancyLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateLabel,
          style: AppStyles.styleBold14(context).copyWith(
            color: AppColors.typographySubTitle(context),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 90),
              child: Text(
                date,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppStyles.styleBold16(context).copyWith(
                  color: AppColors.typographyHeading(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(width: showCurrancyLogo ? 2 : 0),
            showCurrancyLogo
                ? CurrancyLogoWidget(
                    maxHeight: 20,
                    maxWidth: 20,
                    color: AppColors.typographyHeading(context),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}

class AssetsDetailsCardColumWidget extends StatelessWidget {
  const AssetsDetailsCardColumWidget({
    super.key,
    required this.dateLabel,
    required this.date,
    required this.showCurrancyLogo,
    required this.icon,
    this.maxWidth,
  });
  final String dateLabel, date;
  final String icon;
  final bool showCurrancyLogo;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: maxWidth ?? 85,
                    child: Text(
                      dateLabel,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.styleBold14(context).copyWith(
                        color: AppColors.typographyBodyWhite(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth ?? 85),
                    child: Text(
                      date,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyles.styleBold18(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ),
                  SizedBox(width: showCurrancyLogo ? 2 : 0),
                  showCurrancyLogo
                      ? CurrancyLogoWidget(
                          maxHeight: 20,
                          maxWidth: 20,
                          color: AppColors.typographyHeading(context),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

getKTapIndex(BuildContext context, [String? status]) {
  print('getKTapIndex $status');
  if (status == null) {
    status = context.read<HomeCubit>().auctionData!.status;
    print('ststus after init from cubit $status');
  }
  KtapIndex = status == AppStrings.auctionsOnGoing
      ? 1
      : status == AppStrings.auctionsInProgress
          ? 2
          : 3;
  return KtapIndex;
}
