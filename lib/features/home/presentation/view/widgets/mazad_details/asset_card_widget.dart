import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/asset_title_and_location_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/completed_assets_card_body_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/in_progress_assets_card_body_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/on_going_assets_card_body_idget.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../auth/presentation/view/screens/splash_screen.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/mazad_card_time_widgets.dart';

class AssetCardWidget extends StatelessWidget {
  const AssetCardWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return GestureDetector(
      onTap: () {
        homeCubit.auctionOrigin = homeCubit.originList[index];
        KoriginId = homeCubit.originList[index].id;

        context.navigateTo(Routes.assetsDetailsScreen);
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 24, end: 16, start: 16),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: const Color(0xFFD7DBD7),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 8),
            AssetTitleAndLocationWidget(
              index: index,
            ),
            SizedBox(height: 16),
            getKTapIndex(context) == 1
                ? OnGoingAssetsCardBodyWidget(
                    index: index,
                  )
                : getKTapIndex(context) == 2
                    ? InProgressAssetsCardBodyWidget(
                        index: index,
                      )
                    : CompletedAssetsCardBodyWidget(
                        index: index,
                      ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class AssetDepositScreen extends StatelessWidget {
  AssetDepositScreen({
    super.key,
    required this.title,
    required this.desc,
    this.descColor,
  });
  final String title, desc;
  Color? descColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.styleBold14(context).copyWith(
            color: AppColors.typographySubTitle(context),
          ),
        ),
        SizedBox(height: 4),
        Text(
          desc,
          style: AppStyles.styleBold14(context).copyWith(
            color: descColor ?? AppColors.typographyHeading(context),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

String formatDateFunction(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);

  if (KisHijri) {
    HijriCalendar hijriDate = HijriCalendar.fromDate(dateTime);
    return '${hijriDate.hYear}/${hijriDate.hMonth.toString().padLeft(2, '0')}/${hijriDate.hDay.toString().padLeft(2, '0')}';
  } else {
    return '${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}';
  }
}

String formatTimeFunction(String isoDate) {
  DateTime dateTime =
      DateTime.parse(isoDate).toLocal(); // Convert to local time
  int hour = dateTime.hour;
  String period = hour < 12 ? 'صباحاً' : 'مساءً';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Handle 12-hour format
  String formattedTime =
      '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
  return formattedTime;
}
