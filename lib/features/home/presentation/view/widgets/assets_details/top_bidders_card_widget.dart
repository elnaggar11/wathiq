import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/images.dart';

import '../../../../../../core/functions/calculate_defrent_betwen_times.dart';
import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../../data/models/enrolle/auction_board_model.dart';

class TopBiddersCardWidget extends StatelessWidget {
  const TopBiddersCardWidget({
    super.key,
    required this.index,
    required this.boardAuctionData,
  });
  final int index;
  final List<BiderAuctionData> boardAuctionData;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: index != 0 ? AppColors.white(context) : Color(0x0C22A06B),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: index != 0
                  ? AppColors.inputBorder(context)
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              index == 0
                  ? AppAssets.app_imagesSquareDoublAltArrowUp
                  : AppAssets.app_imagesLawIcon,
              color: index == 0
                  ? AppColors.color2(context)
                  : AppColors.typographyHeading(context),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    boardAuctionData[index].user.name.split(' ').first +
                        ' - ' +
                        boardAuctionData[index].participantNumber,
                    style: AppStyles.styleBold14(context).copyWith(
                      color: index == 0
                          ? AppColors.typographyHeading(context)
                          : AppColors.typographyBodyWhite(context),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 105),
                      child: Text(
                        formatNumber(boardAuctionData[index].bidAmount),
                        style: AppStyles.styleBold14(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    CurrancyLogoWidget(
                      maxHeight: 20,
                      maxWidth: 20,
                      color: AppColors.typographyHeading(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: const Color(0x33D7D8DB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 70),
                child: Text(
                  calculateTimeDifference(boardAuctionData[index].bidAt),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppStyles.styleBold12(context).copyWith(
                    color: AppColors.typographyBody(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
