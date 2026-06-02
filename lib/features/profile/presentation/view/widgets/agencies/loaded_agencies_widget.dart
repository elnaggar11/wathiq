import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/empty_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/inactive_active_agencies_row_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/show_reson_bottom_sheet.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../data/models/agencies_model.dart';

class LoadedAgenciesWidget extends StatelessWidget {
  const LoadedAgenciesWidget({
    super.key,
    required this.agencies,
  });

  final List<Agency> agencies;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return agencies.isEmpty
        ? Center(
            child: EmptyWidget(
              title: 'لا توجد وكالات ',
              // textButton:
              //     (tapIndex == 2 || tapIndex == 3) ? null : 'إضافة وكالة',
              // onPressed: (tapIndex == 2 || tapIndex == 3)
              //     ? null
              //     : () {
              //         showAddAgenciesBottomSheet(context);
              //       },
            ),
          )
        : Container(
            // margin: EdgeInsets.only(top: 16),
            margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (profileCubit.status == AppStrings.rejected ||
                          profileCubit.status == AppStrings.blocked)
                      ? () {
                          showResonBottomSheet(
                              context,
                              agencies[index].status?.reason ??
                                  'تم رفض الوكالة لاسباب تتعلق بالادمن');
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsetsDirectional.only(
                        top: 16, start: 8, end: 8, bottom: 16),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: AppColors.backgroundTertiary(context)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              AppAssets.app_imagesNajezSvg,
                              height: 40,
                              width: 84,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: ShapeDecoration(
                                color: (profileCubit.status ==
                                        AppStrings.rejected)
                                    ? Color(0xFFC21818).withOpacity(0.1)
                                    : (profileCubit.status ==
                                            AppStrings.pending)
                                        ? Color(0xFF9E5C21).withOpacity(0.1)
                                        : (profileCubit.status ==
                                                AppStrings.blocked)
                                            ? Color(0xFF7A7B7A).withOpacity(0.1)
                                            : (profileCubit.status ==
                                                    AppStrings.approved)
                                                ? Color(0xFF219653)
                                                    .withOpacity(0.1)
                                                : Color(0xFFC21818)
                                                    .withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                (profileCubit.status == AppStrings.rejected)
                                    ? 'مرفوضة'
                                    : (profileCubit.status ==
                                            AppStrings.pending)
                                        ? 'تحت الإجراء'
                                        : (profileCubit.status ==
                                                AppStrings.blocked)
                                            ? 'ملغية'
                                            : (profileCubit.status ==
                                                    AppStrings.approved)
                                                ? 'مقبولة'
                                                : 'منتهية',
                                style: AppStyles.styleBold14(context).copyWith(
                                  color: (profileCubit.status ==
                                          AppStrings.rejected)
                                      ? Color(0xFFC21818)
                                      : (profileCubit.status ==
                                              AppStrings.pending)
                                          ? Color(0xFF9E5C21)
                                          : (profileCubit.status ==
                                                  AppStrings.blocked)
                                              ? Color(0xFF7A7B7A)
                                              : (profileCubit.status ==
                                                      AppStrings.approved)
                                                  ? Color(0xFF219653)
                                                  : Color(0xFFC21818),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        AgencyRowTextWidget(
                          title: agencies[index].agencyName,
                          desc: '',
                        ),
                        SizedBox(height: 12),
                        AgencyRowTextWidget(
                          title: 'رقم الوكالة :',
                          desc: agencies[index].agencyNumber,
                        ),
                        SizedBox(height: 12),
                        AgencyRowTextWidget(
                          title: (profileCubit.status == AppStrings.pending)
                              ? 'تاريخ إصدار الوكالة :'
                              : 'تاريخ انتهاء الوكالة :',
                          desc: (profileCubit.status == AppStrings.pending)
                              ? DateFormat("yyyy-MM-dd")
                                  .format(agencies[index].agencyIssuedDate)
                              : (agencies[index].expireAt == null)
                                  ? 'غير موجود'
                                  : DateFormat("yyyy-MM-dd")
                                      .format(agencies[index].expireAt!),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child:
                                  SvgPicture.asset(AppAssets.app_imagesPdfIcon),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'مرفق الوكالة.${agencies[index].agencyAttachment.split('.').last}',
                              style:
                                  AppStyles.styleSemiBold12(context).copyWith(
                                color: AppColors.typographyHeading(context),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        // (profileCubit.status == AppStrings.pending) != 0 ? Divider() : SizedBox.shrink(),
                        SizedBox(height: 8),
                        (profileCubit.status == AppStrings.approved) == 0
                            ? ActiveAgenciesRowWidget(
                                isActive: agencies[index].active,
                                agencyId: agencies[index].id,
                              )
                            : InActiveAgenciesRowWidget(
                                dateTime: agencies[index].createdAt,
                              )
                      ],
                    ),
                  ),
                );
              },
              itemCount: agencies.length,
            ),
          );
  }
}

class AgencyRowTextWidget extends StatelessWidget {
  const AgencyRowTextWidget({
    super.key,
    required this.title,
    required this.desc,
  });
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.styleMedium16(context).copyWith(
            color: AppColors.typographyHeading(context),
          ),
        ),
        SizedBox(width: 4),
        Text(
          desc,
          style: AppStyles.styleSemiBold16(context).copyWith(
            color: AppColors.typographyHeading(context),
          ),
        )
      ],
    );
  }
}
