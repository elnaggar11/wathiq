import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

import '../../../../data/models/auctions_model/auctions_model.dart';

class MazadTitleAndLocationWidget extends StatelessWidget {
  const MazadTitleAndLocationWidget({
    super.key,
    required this.auctionData,
  });
  final AuctionData auctionData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              auctionData.title ?? 'عنوان المزاد',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppStyles.styleBold18(context).copyWith(
                color: AppColors.typographyHeading(context),
                fontWeight: FontWeight.w800,
                height: 1.24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CachedNetworkImageWidegt extends StatelessWidget {
  const CachedNetworkImageWidegt({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) => CustomCircularProgressIndicatorWidget(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

class CustomCircularProgressIndicatorWidget extends StatelessWidget {
  const CustomCircularProgressIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        color: AppColors.primary(context),
      ),
    );
  }
}
