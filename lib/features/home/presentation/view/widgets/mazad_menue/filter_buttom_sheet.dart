import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_menue/mazad_type_dropdown_button_form_field_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

Future<void> filterSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const FilterSheetBottomSheetBodyWidget(),
      );
    },
  );
}

class FilterSheetBottomSheetBodyWidget extends StatefulWidget {
  const FilterSheetBottomSheetBodyWidget({
    super.key,
  });

  @override
  State<FilterSheetBottomSheetBodyWidget> createState() =>
      _FilterSheetBottomSheetBodyWidgetState();
}

class _FilterSheetBottomSheetBodyWidgetState
    extends State<FilterSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().agencyId = null;
    context.read<ProfileCubit>().status = AppStrings.approved;
    context.read<ProfileCubit>().getAgencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'البحث',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleMedium18(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SvgPicture.asset(AppAssets.app_imagesCloseSquare),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              TextFormFieldWithTitleWidget(
                label: 'اسم المزاد',
                controller: homeCubit.auctionFilterSearch,
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 16, end: 8.w),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: InkWell(
                      child: SvgPicture.asset(
                        Assets.imagesMagnifer,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const MazadtypeDropdownButtonFormFieldWidget(),
              const SizedBox(height: 38),
              SizedBox(
                height: 54,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeCubit.filterAuctiontype = null;
                        homeCubit.auctionFilterSearch.clear();
                        homeCubit.refreshAuctionsForTab();
                        context.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.50,
                          vertical: 18,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 0.84,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFFEBEEF3),
                            ),
                            borderRadius: BorderRadius.circular(13.50),
                          ),
                        ),
                        child: Text(
                          'الغاء',
                          textAlign: TextAlign.start,
                          style: AppStyles.styleMedium18(context).copyWith(
                            color: AppColors.typographySubTitle(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop();
                          homeCubit.refreshAuctionsForTab();
                        },
                        child: Text(
                          'بحث',
                          style: AppStyles.styleMedium18(context).copyWith(
                            color: AppColors.white(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
