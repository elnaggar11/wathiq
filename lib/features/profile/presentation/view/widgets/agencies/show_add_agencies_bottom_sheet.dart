import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/create_agencies_button_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/picked_agency_attachment_widget.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../auth/presentation/view/widgets/sign_up/date_picker_widegt.dart';

Future<void> showAddAgenciesBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 32,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<ProfileCubit>().createAgenciesKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'إضافة وكالة',
                          style: AppStyles.styleBold24(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child:
                              SvgPicture.asset(AppAssets.app_imagesCloseSquare),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormFieldWithTitleWidget(
                      controller:
                          context.read<ProfileCubit>().agencyNameController,
                      label: 'إسم الوكالة',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل اسم الوكالة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    TextFormFieldWithTitleWidget(
                      controller:
                          context.read<ProfileCubit>().agencyNumberController,
                      label: 'رقم الوكالة',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل رقم الوكالة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    TextFormFieldWithTitleWidget(
                      controller: context
                          .read<ProfileCubit>()
                          .agencyIdentityNumberController,
                      label: 'هوية الموكل',
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى إدخال رقم الهوية الوطنية / الاقامة';
                        }
                        if (value.isEmpty) {
                          return 'يرجى إدخال رقم الهوية الوطنية / الاقامة';
                        }
                        if (value.length != 10) {
                          return 'رقم الهوية الوطنية يجب ان يتكون من 10 ارقام';
                        }
                        if (!value.startsWith('1') && !value.startsWith('2')) {
                          return 'رقم الهوية الوطنية / الاقامة خطأ';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.number,
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16.w,
                        ),
                        child: SvgPicture.asset(AppAssets.app_imagesNationalId),
                      ),
                    ),
                    SizedBox(height: 24),
                    DatePickerWidegt(
                      text: 'تاريخ اصدار الوكالة',
                      controller: context
                          .read<ProfileCubit>()
                          .agencyIssuedDateController,
                      filled: false,
                    ),
                    SizedBox(height: 24),
                    PickedAgencyAttachmentWidget(),
                    SizedBox(height: 24),
                    AgenciesTermsAndConditionsWidget(),
                    SizedBox(height: 24),
                    CreateAgenciesButtonWidget(
                      profileCubit: context.read<ProfileCubit>(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class AgenciesTermsAndConditionsWidget extends StatefulWidget {
  const AgenciesTermsAndConditionsWidget({super.key});

  @override
  State<AgenciesTermsAndConditionsWidget> createState() =>
      _AgenciesTermsAndConditionsWidgetState();
}

class _AgenciesTermsAndConditionsWidgetState
    extends State<AgenciesTermsAndConditionsWidget> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
              context.read<ProfileCubit>().isAcceptAgencyPolicy =
                  value ?? false;
            });
          },
          checkColor: AppColors.white(context),
          activeColor: AppColors.primary(context),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.typographySubTitle(context),
                width: 1,
              ),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              context.navigateTo(Routes.policyScreen);
            },
            child: Text(
              'أنا اقبل الشروط والاحكام',
              style: AppStyles.styleRegular16(context)
                  .copyWith(color: AppColors.typographyBody(context)),
            ),
          ),
        ),
      ],
    );
  }
}
