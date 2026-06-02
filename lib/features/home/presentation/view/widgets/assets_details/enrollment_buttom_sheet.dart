import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/enrollment_first_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../../app/app.dart';
import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../../../profile/presentation/view_model/profile/profile_cubit.dart';
import '../../../../../wallet/presentation/view/widgets/add_balance_sheet.dart';
import '../home/mazad_card_time_widgets.dart';

Future<void> enrollmentSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return EnrollmentSheetBottomSheetBodyWidget();
    },
  );
}

class EnrollmentSheetBottomSheetBodyWidget extends StatefulWidget {
  const EnrollmentSheetBottomSheetBodyWidget({
    super.key,
  });

  @override
  State<EnrollmentSheetBottomSheetBodyWidget> createState() =>
      _EnrollmentSheetBottomSheetBodyWidgetState();
}

class _EnrollmentSheetBottomSheetBodyWidgetState
    extends State<EnrollmentSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().agencyId = null;
    context.read<ProfileCubit>().status = AppStrings.approved;
    // context.read<ProfileCubit>().getAgencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final profileCubit = context.read<ProfileCubit>();
        if (!profileCubit.isClosed) {
          profileCubit.getAgencies();
        }
      }
    });
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
          color: AppColors.white(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'التسجيل فى المزاد',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleMedium22(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgPicture.asset(
                      AppAssets.app_imagesCloseSquare,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.borderPrimary(context),
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.white(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 310,
                      child: Text(
                        homeCubit.auctionOrigin!.title ?? '',
                        maxLines: 3,
                        style: AppStyles.styleMedium20(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'المشاركة ك',
                textAlign: TextAlign.start,
                style: AppStyles.styleBold16(context).copyWith(
                  color: AppColors.typographyHeading(context),
                ),
              ),
              SizedBox(height: 16),
              SelectSharAsRadioButton(),
              // SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: ShapeDecoration(
                  color: Color(0xFFF7F7F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    AssetsDetailsCardColumWidget(
                      dateLabel: 'عربون الدخول',
                      date: formatNumber(homeCubit.auctionOrigin!.entryDeposit)
                          .toString(),
                      showCurrancyLogo: true,
                      icon: AppAssets.app_imagesBillCheck,
                    ),
                  ],
                ),
              ),
              KisGuest
                  ? enrollmentFirstWidget(
                      padding: 16,
                    )
                  : EnrollMentCallToAction(),
              KisGuest
                  ? SizedBox(
                      height: 16,
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

class EnrollMentCallToAction extends StatelessWidget {
  const EnrollMentCallToAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          EnrollmentWalletWidget(),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 54,
            width: double.infinity,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
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
                        side: BorderSide(
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
                      style: AppStyles.styleBold18(context).copyWith(
                        color: AppColors.typographySubTitle(context),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (homeCubit.agencyId == null &&
                          homeCubit.shareAs == AppStrings.enrollShareAsAgent) {
                        FloatingSnackBar.show(
                          context,
                          'يجب اختيار وكالة اولا او المشاركة كأصيل',
                        );
                        return;
                      } else {
                        homeCubit.type = AppStrings.enrolltypeOnline;
                        homeCubit.originId = homeCubit.auctionOrigin!.id;
                        homeCubit.auctionId = homeCubit.auctionData!.id;
                        homeCubit.auctionEnrollment();
                      }
                    },
                    child: BlocConsumer<HomeCubit, HomeState>(
                      listenWhen: (previous, current) =>
                          previous.auctionEnrollmentRequestState !=
                          current.auctionEnrollmentRequestState,
                      listener: (context, state) {
                        if (state.auctionEnrollmentRequestState ==
                            RequestState.loaded) {
                          context.pop();

                          FloatingSnackBar.show(
                            context,
                            state.auctionEnrollmentMsg ?? 'تم',
                            isError: false,
                          );
                        } else if (state.auctionEnrollmentRequestState ==
                            RequestState.error) {
                          FloatingSnackBar.show(
                            context,
                            state.auctionEnrollmentError?.message ??
                                'هناك شئ ما خطأ حاول مجددا',
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.auctionEnrollmentRequestState ==
                            RequestState.loading) {
                          return Lottie.asset(
                            AppAnimationAssets.loading,
                          );
                        } else {
                          return Text(
                            'تأكيد',
                            style: AppStyles.styleMedium16(context).copyWith(
                              color: AppColors.white(context),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EnrollmentWalletWidget extends StatelessWidget {
  const EnrollmentWalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.getWalletRequestState == RequestState.error) {
          return ErrorAppWidget(
            text: state.getWalletError?.message ?? 'حدث خطأ',
            onTap: () {
              context.read<HomeCubit>().getWallet();
            },
          );
        } else {
          return Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ((state.getWalletModel?.data.balance ?? 0) <
                      homeCubit.auctionOrigin!.entryDeposit)
                  ? AppColors.error(context).withOpacity(0.05)
                  : Color(0xFF2E9C95).withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.app_imagesWalletMoneyenrooleSheet,
                      color: ((state.getWalletModel?.data.balance ?? 0) <
                              homeCubit.auctionOrigin!.entryDeposit)
                          ? AppColors.error(context)
                          : Color(0xFF2E9C95),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رصيد المحفظة',
                          textAlign: TextAlign.start,
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: AppColors.typographyBody(context),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.getWalletModel?.data.balance
                                      .toStringAsFixed(2) ??
                                  "0",
                              textAlign: TextAlign.start,
                              style: AppStyles.styleBold16(context).copyWith(
                                color: ((state.getWalletModel?.data.balance ??
                                            0) <
                                        homeCubit.auctionOrigin!.entryDeposit)
                                    ? AppColors.error(context)
                                    : Color(0xFF2E9C95),
                              ),
                            ),
                            SizedBox(width: 2),
                            CurrancyLogoWidget(
                              maxHeight: 20,
                              maxWidth: 20,
                              color:
                                  ((state.getWalletModel?.data.balance ?? 0) <
                                          homeCubit.auctionOrigin!.entryDeposit)
                                      ? AppColors.error(context)
                                      : Color(0xFF2E9C95),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: ((state.getWalletModel?.data.balance ?? 0) <
                          homeCubit.auctionOrigin!.entryDeposit)
                      ? 16
                      : 0,
                ),
                ((state.getWalletModel?.data.balance ?? 0) <
                        homeCubit.auctionOrigin!.entryDeposit)
                    ? SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            addBalanceSheetBottomSheet(context);
                          },
                          child: Text(
                            'شحن المحفظة',
                            style: AppStyles.styleMedium16(context).copyWith(
                              color: AppColors.white(context),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          );
        }
      },
    );
  }
}

class SelectSharAsRadioButton extends StatefulWidget {
  const SelectSharAsRadioButton({super.key});

  @override
  State<SelectSharAsRadioButton> createState() =>
      _SelectSharAsRadioButtonState();
}

class _SelectSharAsRadioButtonState extends State<SelectSharAsRadioButton> {
  String? _selectedValue = AppStrings.enrollShareAsGenuine;

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      context.read<HomeCubit>().shareAs = _selectedValue!;
      print(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppStrings.enrollShareAsAgent == _selectedValue ? 150 : 80,
      // width: 300,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: RadioListTile(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primary(context),
                    title: Text(
                      'أصيل',
                      style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.typographySubTitle(context)),
                    ),
                    value: AppStrings.enrollShareAsGenuine,
                    groupValue: _selectedValue,
                    onChanged: _handleRadioValueChange,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: RadioListTile(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primary(context),
                    title: Text(
                      'وكيل ',
                      style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.typographySubTitle(context)),
                    ),
                    value: AppStrings.enrollShareAsAgent,
                    groupValue: _selectedValue,
                    onChanged: _handleRadioValueChange,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppStrings.enrollShareAsAgent == _selectedValue ? 8 : 0,
          ),
          AppStrings.enrollShareAsAgent == _selectedValue
              ? ActiveAgenciesDropdownButtonFormFieldWidget()
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class ActiveAgenciesDropdownButtonFormFieldWidget extends StatefulWidget {
  const ActiveAgenciesDropdownButtonFormFieldWidget({
    super.key,
  });

  @override
  State<ActiveAgenciesDropdownButtonFormFieldWidget> createState() =>
      _ActiveAgenciesDropdownButtonFormFieldWidgetState();
}

class _ActiveAgenciesDropdownButtonFormFieldWidgetState
    extends State<ActiveAgenciesDropdownButtonFormFieldWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          value: selectedValue,
          menuMaxHeight: 600,
          dropdownColor: AppColors.white(context),
          style: AppStyles.styleBold16(context).copyWith(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          items: profileCubit.agencies.isEmpty
              ? [
                  DropdownMenuItem<String>(
                    value: '',
                    enabled: false,
                    onTap: null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'لا يوجد لديك وكالات مقبولة',
                        style: AppStyles.styleBold16(context).copyWith(
                            color: AppColors.typographyHeading(context)),
                      ),
                    ),
                  )
                ]
              : profileCubit.agencies
                  .map((agency) => DropdownMenuItem<String>(
                        value: agency.id,
                        onTap: () {
                          homeCubit.agencyId = agency.id;
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            agency.agencyName,
                            style: AppStyles.styleBold16(context).copyWith(
                                color: AppColors.typographyHeading(context)),
                          ),
                        ),
                      ))
                  .toList(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            filled: true,
            fillColor: AppColors.white(context), // Background color of the
            // make is like label text so it will be like a label at the top of the dropdown
            labelText: 'اختر الوكالة',
            labelStyle: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.typographyBody(context),
            ),

            hintStyle: AppStyles.styleBold16(context).copyWith(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16), // Custom shape
              borderSide: BorderSide(
                color: AppColors.inputBorder(context), // Default border color
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color:
                    AppColors.inputBorder(context), // Border color when enabled
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color:
                    AppColors.inputBorder(context), // Border color when focused
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red, // Border color when there's an error
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red, // Border color when focused with an error
                width: 1.5,
              ),
            ),
          ),
          // hint: Text(
          //   'اختر الوكالة',
          //   textAlign: TextAlign.center,
          //   style: AppStyles.styleBold16(context),
          // ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.grey500(context),
          ),
          // : InkWell(
          //     onTap: () {
          //       setState(() {
          //         selectedValue = null;
          //       });
          //       pagesCubit.category = null;

          //       pagesCubit.getQuestions();
          //     },
          //     child: SizedBox(
          //       child: SvgPicture.asset(
          //         Assets.imagesCloseIcon,
          //       ),
          //     ),
          //   ),
        );
      },
    );
  }
}
