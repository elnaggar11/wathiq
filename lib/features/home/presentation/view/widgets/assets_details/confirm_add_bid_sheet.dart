import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/images.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';

Future<void> confirmAddBidSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return confirmAddBidSheetBottomSheetBodyWidget();
    },
  );
}

class confirmAddBidSheetBottomSheetBodyWidget extends StatefulWidget {
  const confirmAddBidSheetBottomSheetBodyWidget({
    super.key,
  });

  @override
  State<confirmAddBidSheetBottomSheetBodyWidget> createState() =>
      _confirmAddBidSheetBottomSheetBodyWidgetState();
}

class _confirmAddBidSheetBottomSheetBodyWidgetState
    extends State<confirmAddBidSheetBottomSheetBodyWidget>
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
    HomeCubit homeCubit = context.read<HomeCubit>();
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleBold18(context).copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child:
                            SvgPicture.asset(AppAssets.app_imagesCloseSquare)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 77,
                      minWidth: 90,
                    ),
                    child: SvgPicture.asset(
                      Assets.imagesLawIcon,
                      fit: BoxFit.contain,
                      color: AppColors.buttonsPrimary(context),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'تأكيد مزايدة',
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold22(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'هل انت متأكد من المزايدة بمبلغ',
                    textAlign: TextAlign.center,
                    style: AppStyles.styleSemiBold14(context).copyWith(
                      color: AppColors.typographySubTitle(context),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white(context),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.separatingBorder(context),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${formatNumber(homeCubit.state.total)}',
                          textAlign: TextAlign.center,
                          style: AppStyles.styleBold20(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainColor(context),
                          ),
                        ),
                        SizedBox(width: 2),
                        CurrancyLogoWidget(
                          color: AppColors.mainColor(context),
                        ),
                        Text(
                          '/ الاجمالي ',
                          textAlign: TextAlign.center,
                          style: AppStyles.styleBold20(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  AddAuctionButtonWidget(),
                  SizedBox(height: 24),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddAuctionButtonWidget extends StatelessWidget {
  const AddAuctionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

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
                if (homeCubit.boardAuctionData.isEmpty) {
                  homeCubit.addAuctionBid();
                  return;
                }
                if (homeCubit.state.topBid ==
                    homeCubit.boardAuctionData.first.bidAmount) {
                  FloatingSnackBar.show(
                    context,
                    'يجب ان تقوم بزيادة السعر اولا',
                  );
                  return;
                } else {
                  homeCubit.addAuctionBid();
                }
              },
              child: BlocConsumer<HomeCubit, HomeState>(
                listenWhen: (previous, current) =>
                    previous.addAuctionBidRequestState !=
                    current.addAuctionBidRequestState,
                listener: (context, state) {
                  if (state.addAuctionBidRequestState == RequestState.loaded) {
                    context.pop();
                    FloatingSnackBar.show(
                      context,
                      state.addAuctionBidMsg ?? 'تم',
                      isError: false,
                    );
                  } else if (state.addAuctionBidRequestState ==
                      RequestState.error) {
                    FloatingSnackBar.show(
                      context,
                      state.addAuctionBidError?.message ??
                          'هناك شئ ما خطأ حاول مجددا',
                    );
                  }
                },
                builder: (context, state) {
                  if (state.addAuctionBidRequestState == RequestState.loading) {
                    return Lottie.asset(
                      AppAnimationAssets.loading,
                    );
                  } else {
                    return Text(
                      'تأكيد',
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
