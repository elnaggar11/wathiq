import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/core/functions/format_number.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

Future<void> addBalanceSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent, // important to allow rounded corners

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddBalanceSheetBottomSheetBodyWidget(),
      );
    },
  );
}

class AddBalanceSheetBottomSheetBodyWidget extends StatefulWidget {
  const AddBalanceSheetBottomSheetBodyWidget({
    super.key,
  });

  @override
  State<AddBalanceSheetBottomSheetBodyWidget> createState() =>
      _AddBalanceSheetBottomSheetBodyWidgetState();
}

class _AddBalanceSheetBottomSheetBodyWidgetState
    extends State<AddBalanceSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WalletCubit walletCubit = context.read<WalletCubit>();
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 4,
              // bottom: MediaQuery.of(context).viewInsets.bottom +
              // 8, // important to avoid keyboard hiding content
            ),
            child: Form(
              key: walletCubit.addBalanceKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'شحن رصيد',
                        textAlign: TextAlign.start,
                        style: AppStyles.styleSemiBold16(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: SvgPicture.asset(
                                AppAssets.app_imagesCloseSquare)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldWithTitleWidget(
                        controller: walletCubit.balanceController,
                        label: 'مبلغ الشحن',
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value == '0') {
                            return 'برجاء ادخال مبلغ الشحن ';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          walletCubit.balanceController
                              .text = formatNumber(parseFormattedNumber(
                                  walletCubit.balanceController.text.trim()))
                              .toString();
                        },
                        keyboardType: TextInputType.number,
                        suffix: Padding(
                          padding:
                              EdgeInsetsDirectional.only(end: 20, start: 8.w),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: InkWell(
                              child: SvgPicture.asset(
                                Assets.imagesCurrencyIcon,
                                fit: BoxFit.contain,
                                color: AppColors.typographyHeading(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      const AddBalanceButtonWidget(),
                      const SizedBox(height: 24),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddBalanceButtonWidget extends StatelessWidget {
  const AddBalanceButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WalletCubit walletCubit = context.read<WalletCubit>();

    return SizedBox(
      height: 54,
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
                style: AppStyles.styleBold18(context).copyWith(
                  color: AppColors.typographySubTitle(context),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                walletCubit.addWalletBalance();
              },
              child: BlocConsumer<WalletCubit, WalletState>(
                listenWhen: (previous, current) =>
                    previous.addWalletBalanceRequestState !=
                    current.addWalletBalanceRequestState,
                listener: (context, state) {
                  if (state.addWalletBalanceRequestState ==
                      RequestState.loaded) {
                    context.pop();
                    FloatingSnackBar.show(
                      context,
                      state.addWalletBalanceMsg ?? 'تم',
                      isError: false,
                    );
                  } else if (state.addWalletBalanceRequestState ==
                      RequestState.error) {
                    FloatingSnackBar.show(
                      context,
                      state.addWalletBalanceError?.message ??
                          'هناك شئ ما خطأ حاول مجددا',
                    );
                  }
                },
                builder: (context, state) {
                  if (state.addWalletBalanceRequestState ==
                      RequestState.loading) {
                    return Lottie.asset(
                      AppAnimationAssets.loading,
                    );
                  } else {
                    return Text(
                      'شحن',
                      style: AppStyles.styleBold18(context).copyWith(
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
    );
  }
}
