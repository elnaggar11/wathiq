import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/contact_us/select_type_radio_button.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/core/widgets/show_success_bottom_sheet.dart';

class ContactUsFormWidget extends StatelessWidget {
  const ContactUsFormWidget({
    super.key,
    required this.pagesCubit,
  });

  final PagesCubit pagesCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.primarySurface(context),
            controller: pagesCubit.nameController,
            label: 'الإسم',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'يرجى ادخال الاسم ';
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.primarySurface(context),
            controller: pagesCubit.phoneNumberController,
            label: 'رقم الجوال',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى ادخال رقم الجوال';
              }
              if (!RegExp(r'^5\d{8}$').hasMatch(value)) {
                return 'يجب أن يبدأ رقم الجوال ب 5 ويتكون من 9 أرقام';
              }
              return null;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(9),
            ],
            keyboardType: TextInputType.number,
            suffixIconSize: 70,
            suffix: Row(
              children: [
                Container(
                  height: 50.h,
                  width: 1.w,
                  color: AppColors.separatingBorder(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 0.w,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      '966+',
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.primarySurface(context),
            controller: pagesCubit.emailController,
            label: 'البريد الإلكتروني',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'يرجى ادخال البريد الالكتروني';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          Text(
            'نوع الإستفسار',
            style: AppStyles.styleSemiBold18(context),
          ),
          const SizedBox(height: 4),
          const SelectTypeRadioButton(),
          const SizedBox(height: 24),
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.primarySurface(context),
            controller: pagesCubit.messageController,
            label: 'الرسالة',
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'يرجى ادخال الرسالة ';
              }
              if (value.length < 10) {
                return 'يجب ان تكون الرساله اكثر من 40 حرف';
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<PagesCubit>().postcontactUs();
            },
            child: BlocConsumer<PagesCubit, PagesState>(
              listenWhen: (previous, current) =>
                  previous.postcontactUsRequestState !=
                  current.postcontactUsRequestState,
              listener: (context, state) {
                if (state.postcontactUsRequestState == RequestState.loaded) {
                  showSuccessBottomSheet(
                    context: context,
                    title:
                        'تم إرسال رسالتك بنجاح! شكرًا لتواصلك معنا. سنقوم بمراجعة طلبك والرد عليك قريبًا',
                  );
                } else if (state.postcontactUsRequestState ==
                    RequestState.error) {
                  mySnackBar(
                    state.postcontactUsError?.message ??
                        'هناك شئ ما خطأ حاول مجددا',
                    context,
                    isError: true,
                  );
                }
              },
              builder: (context, state) {
                if (state.postcontactUsRequestState == RequestState.loading) {
                  return Lottie.asset(
                    AppAnimationAssets.loading,
                  );
                } else {
                  return Text(
                    'إرسال',
                    style: AppStyles.styleSemiBold18(context).copyWith(
                      color: AppColors.white(context),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
