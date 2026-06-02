import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_status_timer_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_title_and_location_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/show_more_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/timer_home_widget.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/functions/get_auction_status_and_type.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/images.dart';
import '../../../../data/models/auctions_model/auctions_model.dart';
import '../../../view_model/home/home_cubit.dart';
import '../mazad_details/auction_assets_num_and_day.dart';
import 'auctions_favorite_button.dart';

class MazadCardWidget extends StatefulWidget {
  const MazadCardWidget({
    super.key,
    required this.index,
    required this.auctionsModel,
    this.isFromFav = false,
  });
  final AuctionsModel auctionsModel;
  final int index;
  final bool isFromFav;

  @override
  State<MazadCardWidget> createState() => _MazadCardWidgetState();
}

class _MazadCardWidgetState extends State<MazadCardWidget> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().auctionData =
            widget.auctionsModel.data[widget.index];
        context.read<HomeCubit>().originList =
            widget.auctionsModel.data[widget.index].auctionOrigins;
        getKTapIndex(context);

        context.navigateTo(Routes.mazadDetailsScreen);
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
          top: widget.index == 0 ? 24 : 0,
          bottom: 24,
        ),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x07000000),
              blurRadius: 40,
              offset: Offset(8, 8),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 213,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.auctionsModel.data[widget.index].cover ?? '',
                        errorListener: (error) => Icon(Icons.error),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 213,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.001),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 213,
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 8, left: 15, right: 6, bottom: 8),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: AppColors.color2(
                                  context) /* Surface-action-primary-hover */,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: Text(
                              widget.auctionsModel.data[widget.index].type ==
                                      'online'
                                  ? 'مزاد الكتروني'
                                  : widget.auctionsModel.data[widget.index]
                                              .type ==
                                          'hybrid'
                                      ? 'مزاد هجين'
                                      : 'مزاد حضوري',
                              style: AppStyles.styleBold16(context).copyWith(
                                color: AppColors.white(context),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Spacer(),
                          MazadIconWidget(
                            image: AppAssets.app_imagesShareAndroidW,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          KisGuest
                              ? SizedBox.shrink()
                              : AuctionsFavoriteButton(
                                  homeCubit: homeCubit,
                                  auctionData:
                                      widget.auctionsModel.data[widget.index],
                                  isFromFav: widget.isFromFav,
                                ),
                          SizedBox(width: 8),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          SvgPicture.asset(
                            AppAssets.app_imagesLocationDot,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SizedBox(
                            width: 170,
                            child: Text(
                              widget.auctionsModel.data[widget.index].location
                                      .title ??
                                  "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: AppStyles.styleBold16(context).copyWith(
                                color:
                                    AppColors.typographyHeadingWhite(context),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            MazadTitleAndLocationWidget(
              auctionData: widget.auctionsModel.data[widget.index],
            ),
            SizedBox(height: 16),
            // getKTapIndex(context,
            //             widget.auctionsModel.data[widget.index].status) ==
            //         3
            //     ? SvgPicture.asset(
            //         Assets.imagesMazadEnd,
            //       )
            //     : getKTapIndex(context,
            //                 widget.auctionsModel.data[widget.index].status) ==
            //             2
            //         ? comingMazadTimeWidget(
            //             text1: 'تاريخ بدأ المزاد',
            //             subText1: formatDateFunction(widget
            //                 .auctionsModel.data[widget.index].startDate
            //                 .toString()),
            //             text2: 'وقت بدأ المزاد',
            //             subText2: formatTimeFunction(widget
            //                 .auctionsModel.data[widget.index].startDate
            //                 .toString()),
            //             showCurrancyLogo: false,
            //           )
            //         :
            // MazadStatusTimerWidget(
            //   auctionData: widget.auctionsModel.data[widget.index],
            // ),
            AuctionAssetsNumAndDay(
              NumOfAssets: widget
                  .auctionsModel.data[widget.index].auctionOrigins.length
                  .toString(),
              numOfDayes: widget.auctionsModel.data[widget.index].numberOfDays
                  .toString(),
              padding: 0,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: widget.auctionsModel.data[widget.index].status ==
                            AppStrings.auctionsOnGoing
                        ? Color(0xFFEEF5F1)
                        : widget.auctionsModel.data[widget.index].status ==
                                AppStrings.auctionsInProgress
                            ? Color(0xFFF2F2F2)
                            : Color(0xFFF8F0EE),
                  ),
                  child: getKTapIndex(context,
                              widget.auctionsModel.data[widget.index].status) ==
                          3
                      ? CompletedAuctionStutesWidget()
                      : FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getAuctionTimerText(
                                      widget.auctionsModel.data[widget.index]
                                          .status,
                                    ),
                                    style:
                                        AppStyles.styleBold16(context).copyWith(
                                      color:
                                          AppColors.typographyHeading(context),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              TimerHomeWidget(
                                  auctionData:
                                      widget.auctionsModel.data[widget.index])
                            ],
                          ),
                        ),
                )
              ],
            ),
            SizedBox(height: 16),
            ShowMoreWidget(
              auctionOriginsNum:
                  widget.auctionsModel.data[widget.index].auctionOrigins.length,
              auctionData: widget.auctionsModel.data[widget.index],
            ),
          ],
        ),
      ),
    );
  }
}
