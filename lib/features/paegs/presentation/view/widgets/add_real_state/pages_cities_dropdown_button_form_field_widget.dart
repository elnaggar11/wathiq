import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/core/utils/enums.dart';

class PagesCitiesDropdownButtonFormFieldWidget extends StatefulWidget {
  const PagesCitiesDropdownButtonFormFieldWidget({super.key});

  @override
  State<PagesCitiesDropdownButtonFormFieldWidget> createState() =>
      _PagesCitiesDropdownButtonFormFieldWidgetState();
}

class _PagesCitiesDropdownButtonFormFieldWidgetState
    extends State<PagesCitiesDropdownButtonFormFieldWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthCubit>().state.getCountriesModel == null) {
        context.read<AuthCubit>().getCountries();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.getCountriesRequestState == RequestState.error) {
          return ErrorAppWidget(
              text: 'حدث خطأ ما',
              onTap: () {
                context.read<AuthCubit>().getCountries();
              });
        } else {
          final countries = state.getCountriesModel?.data ?? [];

          // إنشاء قائمة فريدة من العناصر
          final uniqueItems = countries
              .map((country) => DropdownMenuItem<String>(
                    value: country.name,
                    onTap: () {
                      pagesCubit.cityController.text = country.name;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        country.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.styleRegular16(context)
                            .copyWith(color: AppColors.typographyBody(context)),
                      ),
                    ),
                  ))
              .toList();

          return DropdownButtonFormField<String>(
            isExpanded: true,
            icon: selectedValue == null
                ? SvgPicture.asset(
                    Assets.imagesArrowDownIcon,
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        selectedValue = null;
                      });
                      pagesCubit.cityController.clear();
                    },
                    child: SizedBox(
                      child: SvgPicture.asset(
                        Assets.imagesCloseIcon,
                      ),
                    ),
                  ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ),
              filled: true,
              fillColor: AppColors.white(context),
              focusColor: AppColors.white(context),
              iconColor: context.theme.colorScheme.shadow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.error(context), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary(context), width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary(context), width: 1),
              ),
            ),
            hint: Text(
              'اختر المدينة',
              style: AppStyles.styleRegular14(context),
            ),
            value: selectedValue,
            items: uniqueItems,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              pagesCubit.cityController.text = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'برجاء ادخال المدينة';
              }
              return null;
            },
          );
        }
      },
    );
  }
}
