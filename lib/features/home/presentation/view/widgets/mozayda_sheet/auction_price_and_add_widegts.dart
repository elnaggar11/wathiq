import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/call_to_action_add_mozayda_widget.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/images.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../view_model/home/home_cubit.dart';
import '../assets_details/logout_auction_sheet.dart';

class AuctionPriceWidegt extends StatelessWidget {
  const AuctionPriceWidegt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        dynamic price = homeCubit.boardAuctionData.isEmpty
            ? homeCubit.auctionOrigin!.openingPrice
            : homeCubit.boardAuctionData.first.bidAmount;
        dynamic propertyPrice = price;
        dynamic transactionFee = price * 0.05;
        dynamic commission = price * 0.025;
        dynamic commissionTax = commission * 0.25;

        dynamic total = price + transactionFee + commission + commissionTax;
        return Column(
          children: [
            homeCubit.auctionOrigin != null &&
                    homeCubit.auctionOrigin!.details.length > 1 &&
                    homeCubit
                        .auctionOrigin!.details[1].auctionDetails.isNotEmpty &&
                    int.tryParse(homeCubit.auctionOrigin!.details[1]
                                .auctionDetails[0].description ??
                            '') !=
                        null
                ? PriceingRowTextWidget(
                    title: 'سعر المتر',
                    price:
                        '${formatNumber(propertyPrice / int.parse(homeCubit.auctionOrigin!.details[1].auctionDetails[0].description!))}',
                  )
                : SizedBox.shrink(),
            SizedBox(height: 8),
            PriceingRowTextWidget(
              titleIcon: AppAssets.app_imagesSale,
              title: 'مبلغ السعي',
              price: '${formatNumber(commission)}',
            ),
            SizedBox(height: 8),
            PriceingRowTextWidget(
              titleIcon: AppAssets.app_imagesWadOfMoney,
              title: 'ضريبة السعي',
              price: '${formatNumber(commissionTax)}',
            ),
            SizedBox(height: 8),
            PriceingRowTextWidget(
              titleIcon: AppAssets.app_imagesAqartax,
              title: 'التصرفات العقارية',
              price: '${formatNumber(transactionFee)}',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الإجمالي',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleMedium14(context).copyWith(
                        color: AppColors.typographyBody(context),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${formatNumber(total)}',
                          textAlign: TextAlign.start,
                          style: AppStyles.styleBold20(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                        SizedBox(width: 2),
                        CurrancyLogoWidget(
                          color: AppColors.typographyHeading(context),
                          maxHeight: 20,
                          maxWidth: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'فرق السوم',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleMedium14(context).copyWith(
                        color: AppColors.typographyBody(context),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatNumber(
                              homeCubit.auctionOrigin!.garlicDifference),
                          textAlign: TextAlign.start,
                          style: AppStyles.styleMedium16(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                        SizedBox(width: 2),
                        CurrancyLogoWidget(
                          color: AppColors.typographyHeading(context),
                          maxHeight: 20,
                          maxWidth: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class PriceingWidget extends StatelessWidget {
  const PriceingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              homeCubit.auctionOrigin != null &&
                      homeCubit.auctionOrigin!.details.length > 1 &&
                      homeCubit.auctionOrigin!.details[1].auctionDetails
                          .isNotEmpty &&
                      int.tryParse(homeCubit.auctionOrigin!.details[1]
                                  .auctionDetails[0].description ??
                              '') !=
                          null
                  ? PriceingRowTextWidget(
                      title: 'سعر المتر',
                      price:
                          '${formatNumber(state.propertyPrice / int.parse(homeCubit.auctionOrigin!.details[1].auctionDetails[0].description!))}',
                    )
                  : SizedBox.shrink(),
              CalculatorDividerWidget(),
              PriceingRowTextWidget(
                title: 'السعي',
                price: '${formatNumber(state.commission)}',
              ),
              CalculatorDividerWidget(),
              PriceingRowTextWidget(
                title: 'ضريبة السعي',
                price: '${formatNumber(state.commissionTax)}',
              ),
              CalculatorDividerWidget(),
              PriceingRowTextWidget(
                title: 'التصرفات العقارية',
                price: '${formatNumber(state.transactionFee)}',
              ),
              CalculatorDividerWidget(),
              Container(
                width: double.infinity,
                height: 72,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0x33D7D8DB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.app_imagesLawIconCalculator),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الإجمالي',
                          textAlign: TextAlign.start,
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: AppColors.typographyBody(context),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${formatNumber(state.total)}',
                              textAlign: TextAlign.start,
                              style: AppStyles.styleBold20(context).copyWith(
                                color: AppColors.typographyHeading(context),
                              ),
                            ),
                            SizedBox(width: 2),
                            CurrancyLogoWidget(
                              color: AppColors.typographyHeading(context),
                              maxHeight: 20,
                              maxWidth: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class CalculatorDividerWidget extends StatelessWidget {
  const CalculatorDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.borderPrimary(context),
      height: 24,
      thickness: 1,
    );
  }
}

class PriceingRowTextWidget extends StatelessWidget {
  PriceingRowTextWidget({
    super.key,
    required this.title,
    required this.price,
    this.titleStyle,
    this.priceStyle,
    this.titleIcon,
  });
  final String title, price;
  final String? titleIcon;
  TextStyle? titleStyle, priceStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            titleIcon != null
                ? SizedBox(
                    child: SvgPicture.asset(
                      titleIcon!,
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(width: titleIcon != null ? 8 : 0),
            Text(
              title,
              textAlign: TextAlign.start,
              style: titleStyle ??
                  AppStyles.styleMedium14(context).copyWith(
                    color: AppColors.typographyBody(context),
                  ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              price,
              textAlign: TextAlign.start,
              style: priceStyle ??
                  AppStyles.styleMedium16(context).copyWith(
                    color: AppColors.typographyHeading(context),
                  ),
            ),
            SizedBox(width: 2),
            CurrancyLogoWidget(
              color: priceStyle != null
                  ? priceStyle!.color
                  : AppColors.typographyHeading(context),
              maxHeight: 20,
              maxWidth: 20,
            ),
          ],
        ),
      ],
    );
  }
}

class AddMozaydaWidget extends StatelessWidget {
  const AddMozaydaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: ShapeDecoration(
                color: const Color(0x0C0C3F82),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          homeCubit.decreaseBid();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: (state.topBid >
                                    ((homeCubit.boardAuctionData.isEmpty
                                            ? homeCubit
                                                .auctionOrigin!.openingPrice
                                            : homeCubit.boardAuctionData.first
                                                .bidAmount) +
                                        homeCubit
                                            .auctionOrigin!.garlicDifference))
                                ? const Color(0xFFE3E8EF)
                                : const Color(0xFFE3E8EF).withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            margin: EdgeInsets.all(1),
                            decoration: ShapeDecoration(
                              shape: CircleBorder(
                                  side: BorderSide(
                                width: 1.2,
                                color: (state.topBid >
                                        ((homeCubit.boardAuctionData.isEmpty
                                                ? homeCubit
                                                    .auctionOrigin!.openingPrice
                                                : homeCubit.boardAuctionData
                                                    .first.bidAmount) +
                                            homeCubit.auctionOrigin!
                                                .garlicDifference))
                                    ? AppColors.primary(context)
                                    : AppColors.decremntButton(context),
                              )),
                            ),
                            child: SvgPicture.asset(
                              AppAssets.app_imagesMinus,
                              color: (state.topBid >
                                      ((homeCubit.boardAuctionData.isEmpty
                                              ? homeCubit
                                                  .auctionOrigin!.openingPrice
                                              : homeCubit.boardAuctionData.first
                                                  .bidAmount) +
                                          homeCubit
                                              .auctionOrigin!.garlicDifference))
                                  ? AppColors.primary(context)
                                  : AppColors.decremntButton(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        width: 130,
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white /* Input-BG */,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              color: const Color(0xFFE6E6E6) /* Input-Border */,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                formatNumber(state.topBid),
                                textAlign: TextAlign.start,
                                style:
                                    AppStyles.styleSemiBold24(context).copyWith(
                                  color: AppColors.typographyHeading(context),
                                ),
                              ),
                              SizedBox(width: 2),
                              CurrancyLogoWidget(
                                color: AppColors.typographyHeading(context),
                                maxHeight: 22,
                                maxWidth: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          homeCubit.increaseBid();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color:
                                const Color(0xFFE3E8EF) /* Background-Heavy */,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: SvgPicture.asset(
                            AppAssets.app_imagesAddCircle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  CallToActionAddMozaydaWidget(),
                ],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                LogOutFromAuctionSheetBottomSheet(context);
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0x19E34935),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.app_imagesLogioutMAuction,
                      color: AppColors.danger(context),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'مغادرة المزاد',
                      style: AppStyles.styleBold14(context).copyWith(
                        color: AppColors.danger(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
