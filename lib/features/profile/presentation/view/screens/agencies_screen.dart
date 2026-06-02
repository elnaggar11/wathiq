import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/show_add_agencies_bottom_sheet.dart';

class AgenciesScreen extends StatelessWidget {
  const AgenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton.icon(
              onPressed: () {
                showAddAgenciesBottomSheet(context);
              },
              icon: Icon(
                Icons.add,
                color: AppColors.white(context),
                size: 24,
              ),
              label: Text(
                'إضافة وكالة',
                style: AppStyles.styleMedium16(context)
                    .copyWith(color: AppColors.white(context)),
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.backgroundPrimary(context),
        appBar: CoustomAppBarWidget(
          title: 'الوكالات',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              AgenciesCardWidegt(
                onTap: () {
                  context.read<ProfileCubit>().status = AppStrings.approved;
                  context.navigateTo(Routes.AgenciesDetailsScreen);
                },
                boxColor: const Color(0x0C1D6E4F),
                icon: AppAssets.app_imagesActiveSvg,
                title: 'النشطة',
              ),
              const SizedBox(height: 16),
              AgenciesCardWidegt(
                onTap: () {
                  context.read<ProfileCubit>().status = AppStrings.pending;
                  context.navigateTo(Routes.AgenciesDetailsScreen);
                },
                boxColor: const Color(0x0C9E5C21),
                icon: AppAssets.app_imagesPindding,
                title: 'تحت الإجراء',
              ),
              const SizedBox(height: 16),
              AgenciesCardWidegt(
                onTap: () {
                  context.read<ProfileCubit>().status = AppStrings.blocked;
                  context.navigateTo(Routes.AgenciesDetailsScreen);
                },
                boxColor: const Color(0x0C2E343F),
                icon: AppAssets.app_imagesCanceled,
                title: 'الملغية',
              ),
              const SizedBox(height: 16),
              AgenciesCardWidegt(
                onTap: () {
                  context.read<ProfileCubit>().status = AppStrings.rejected;
                  context.navigateTo(Routes.AgenciesDetailsScreen);
                },
                boxColor: const Color(0x0CAF2A1A),
                icon: AppAssets.app_imagesRejected,
                title: 'المرفوضة',
              ),
              const SizedBox(height: 16),
              AgenciesCardWidegt(
                onTap: () {
                  context.read<ProfileCubit>().status =
                      AppStrings.approved; //TODO:
                  context.navigateTo(Routes.AgenciesDetailsScreen);
                },
                boxColor: const Color(0x0CAF2A1A),
                icon: AppAssets.app_imagesTerminated,
                title: 'منتهية',
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class AgenciesCardWidegt extends StatelessWidget {
  const AgenciesCardWidegt({
    super.key,
    required this.title,
    required this.icon,
    required this.boxColor,
    required this.onTap,
  });
  final String title, icon;
  final Color boxColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: boxColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: SizedBox(
                  height: 24, width: 24, child: SvgPicture.asset(icon)),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppStyles.styleBold16(context)
                  .copyWith(color: AppColors.typographyHeading(context)),
            ),
            const Spacer(),
            SvgPicture.asset(AppAssets.app_imagesArrowAgencies),
          ],
        ),
      ),
    );
  }
}
