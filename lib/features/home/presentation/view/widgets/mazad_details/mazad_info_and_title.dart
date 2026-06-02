import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';

import '../../../../../../core/functions/url_luncher.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/home/home_cubit.dart';

class MazadInfoAndTitle extends StatelessWidget {
  const MazadInfoAndTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 180,
                child: Text(
                  homeCubit.auctionData?.provider.companyName ?? 'الشركة',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: AppStyles.styleBold20(context)
                      .copyWith(color: AppColors.typographyHeading(context)),
                ),
              ),
              Spacer(),
              homeCubit.auctionData!.logos.length > 0
                  ? MazadCompanyLogoWidget(
                      imageURl: homeCubit.auctionData!.logos[0].logo ?? '',
                    )
                  : SizedBox.shrink(),
              SizedBox(width: 16),
              homeCubit.auctionData!.logos.length > 1
                  ? MazadCompanyLogoWidget(
                      imageURl: homeCubit.auctionData!.logos[1].logo ?? '',
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 16),
          WhatsAppButtonWidget(),
        ],
      ),
    );
  }
}

class WhatsAppButtonWidget extends StatelessWidget {
  const WhatsAppButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return OutlinedButton.icon(
      onPressed: () {
        String? whatsappNumber =
            (homeCubit.auctionData?.provider.companyPhoneNumber?.key ?? '') +
                (homeCubit.auctionData?.provider.companyPhoneNumber?.number ??
                    '');

        openLink('https://wa.me/${whatsappNumber}');
      },
      label: Text(
        (homeCubit.auctionData?.provider.companyPhoneNumber?.key ?? '') +
            (homeCubit.auctionData?.provider.companyPhoneNumber?.number ?? ''),
        style: AppStyles.styleSemiBold14(context)
            .copyWith(color: AppColors.success(context)),
      ),
      icon: SvgPicture.asset(
        Assets.imagesWhatsapp,
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 40),
        side: BorderSide(
          color: AppColors.success(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        foregroundColor: AppColors.success(context),
        backgroundColor: AppColors.success(context).withOpacity(0.05),
      ),
    );
  }
}

class MazadCompanyLogoWidget extends StatelessWidget {
  const MazadCompanyLogoWidget({
    super.key,
    required this.imageURl,
  });
  final String imageURl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: CachedNetworkImageProvider(
            imageURl,
          ),
        ),
      ),
    );
  }
}
