import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';

import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/core/widgets/show_success_bottom_sheet.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/core/functions/format_number.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/auth_app_logo_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/bank_names_dropdown_button_form_field_widget.dart';
import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String? selectedBank;
  final List<String> bankOptions = [
    'البنك الأهلي السعودي',
    'مصرف الراجحي',
    'بنك الرياض',
    'البنك السعودي الفرنسي',
    'البنك العربي الوطني',
    'بنك البلاد',
    'بنك الجزيرة',
    'البنك السعودي للاستثمار',
    'البنك السعودي الأول (ساب)',
    'مصرف الإنماء',
    'بنك الخليج الدولي - السعودية',
    'بنك إس تي سي (STC Bank)',
    'البنك السعودي الرقمي',
    'بنك دال ثلاث مئة وستون (D360 Bank)'
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    WalletCubit walletCubit = context.read<WalletCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'سحب رصيد',
        ),
        body: SingleChildScrollView(
          child: Form(
            key: walletCubit.withdrawFormKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      TextFormFieldWithTitleWidget(
                        controller: walletCubit.beneficiaryNameController,
                        label: 'إسم المستفيد',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'إسم المستفيد مطلوب';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldWithTitleWidget(
                        controller: walletCubit.contactNumberController,
                        label: 'رقم التواصل',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'رقم التواصل مطلوب';
                          }
                          if (value.length != 9) {
                            return 'رقم التواصل غير صحيح';
                          }
                          return null;
                        },
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
                                  style:
                                      AppStyles.styleBold16(context).copyWith(
                                    color: AppColors.typographyHeading(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const BankNamesDropdownButtonFormFieldWidget(
                        filled: false,
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldWithTitleWidget(
                        controller: walletCubit.ibanNumberController,
                        label: 'رقم الأيبان',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null) {
                            return ' رقم الايبان مطلوب';
                          }
                          if (value.isEmpty) {
                            return ' رقم الايبان مطلوب';
                          }
                          if (value.length != 24) {
                            return ' رقم الايبان يجب ان يتكون من 22 رقم';
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(24),
                        ],
                        onChanged: (value) {
                          if (value != null && !value.startsWith('SA')) {
                            walletCubit.ibanNumberController.text = 'SA';
                            walletCubit.ibanNumberController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                offset: walletCubit
                                    .ibanNumberController.text.length,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          walletCubit.pickIbanAttachment().then((val) {
                            setState(() {});
                          });
                        },
                        child: TextFormFieldWithTitleWidget(
                          label: walletCubit.ibanAttachment == null
                              ? 'شهادة الايبان (إختياري )'
                              : walletCubit.ibanAttachment!.path
                                  .split('/')
                                  .last,
                          hintStyle: AppStyles.styleBold16(context),
                          filled: true,
                          fillColor: AppColors.backgroundPrimary(context),
                          enabled: false,
                          keyboardType: TextInputType.number,
                          suffix: Container(
                            margin: const EdgeInsetsDirectional.only(
                              top: 8,
                              bottom: 8,
                              end: 16,
                            ),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.primary(context)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SvgPicture.asset(
                              Assets.imagesUploadeFile,
                              fit: BoxFit.fill,
                              color: AppColors.primary(context),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldWithTitleWidget(
                        controller: walletCubit.withdrawAmountController,
                        label: 'مبلغ السحب ',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          walletCubit.withdrawAmountController.text =
                              formatNumber(parseFormattedNumber(walletCubit
                                      .withdrawAmountController.text
                                      .trim()))
                                  .toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'مبلغ السحب مطلوب';
                          }

                          if (parseFormattedNumber(value) <= 0) {
                            return 'مبلغ السحب يجب أن يكون أكبر من صفر';
                          }
                          return null;
                        },
                        suffix: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 18.w,
                          ),
                          child: CurrancyLogoWidget(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      const SubmitWithdrawButtonWidget(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitWithdrawButtonWidget extends StatelessWidget {
  const SubmitWithdrawButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WalletCubit walletCubit = context.read<WalletCubit>();

    return ElevatedButton(
      onPressed: () {
        walletCubit.submitWithdrawRequest();
      },
      child: BlocConsumer<WalletCubit, WalletState>(
        listenWhen: (previous, current) =>
            previous.submitWithdrawRequestState !=
            current.submitWithdrawRequestState,
        listener: (context, state) {
          if (state.submitWithdrawRequestState == RequestState.loaded) {
            context.pop();
            showSuccessBottomSheet(
              context: context,
              title: 'تم إرسال طلب السحب ',
              subTitle: 'سيتم التواصل معك قريبا .........',
              showHomeButton: false,
            );
          } else if (state.submitWithdrawRequestState == RequestState.error) {
            mySnackBar(
              state.submitWithdrawError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.submitWithdrawRequestState == RequestState.loading) {
            return SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: AppColors.white(context),
              ),
            );
          } else {
            return Text(
              'إرسال',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
