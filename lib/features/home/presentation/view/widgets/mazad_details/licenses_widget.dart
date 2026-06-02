import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/images.dart';

import '../../../../../../core/functions/url_luncher.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/mazad_title_and_location_widget.dart';

class LicensesWidget extends StatelessWidget {
  const LicensesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white(context),
      ),
      child: Column(
        children: [
          RealEstateOrganizationWidget(),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.inputBorder(context),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AuctionBrochureChiledWidget(),
          ),
        ],
      ),
    );
  }
}

class RealEstateOrganizationWidget extends StatelessWidget {
  const RealEstateOrganizationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            homeCubit.auctionData!.logos.length > 0
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 56,
                      maxHeight: 56,
                    ),
                    child: CachedNetworkImageWidegt(
                      imageUrl: homeCubit.auctionData!.logos[0].logo ?? '',
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(
              width: 12,
            ),
            homeCubit.auctionData!.logos.length > 1
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 56,
                      maxHeight: 56,
                    ),
                    child: CachedNetworkImageWidegt(
                      imageUrl: homeCubit.auctionData!.logos[1].logo ?? '',
                    ),
                  )
                : SizedBox.shrink(),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 155,
                maxHeight: 43,
              ),
              child: SvgPicture.asset(
                AppAssets.app_imagesInfath,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'وكيل البيع',
          style: AppStyles.styleMedium12(context).copyWith(
            color: AppColors.typographyHeading(context),
          ),
        ),
        SizedBox(height: 4),
        Text(
          homeCubit.auctionData?.provider.companyName ?? 'وثيق للمزادات',
          style: AppStyles.styleMedium16(context).copyWith(
            color: AppColors.typographyHeading(context),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValTextColumWidget(
              title: 'رخصة فال للمزادات العقارية',
              desc: homeCubit.auctionData?.provider.valAuctionsLicenseNumber ??
                  '',
            ),
            ValTextColumWidget(
              title: 'رقم الموافقة لإقامة المزاد',
              desc: homeCubit.auctionData?.auctionApprovalNumber ?? '',
            ),
          ],
        ),
        SizedBox(height: 16),
        WhatsAppAndCallButtonWidget(),
      ],
    );
  }
}

class AuctionBrochureChiledWidget extends StatelessWidget {
  const AuctionBrochureChiledWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().auctionBrochure(context);
      },
      child: Row(
        children: [
          SizedBox(
            child: SvgPicture.asset(
              AppAssets.app_imagesPdfIconw,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'برشور المزاد',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.typographyBody(context),
            ),
          ),
          Spacer(),
          BlocConsumer<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                previous.auctionBrochureRequestState !=
                current.auctionBrochureRequestState,
            listener: (context, state) {
              if (state.auctionBrochureRequestState == RequestState.loaded) {
                FloatingSnackBar.show(
                  context,
                  'تم تحميل البروشور بنجاح',
                  isError: false,
                );
              } else if (state.auctionBrochureRequestState ==
                  RequestState.error) {
                mySnackBar(
                  state.auctionBrochureError?.message ??
                      'هناك شئ ما خطأ حاول مجددا',
                  context,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              if (state.auctionBrochureRequestState == RequestState.loading) {
                return Container(
                  child: CustomCircularProgressIndicatorWidget(),
                );
              } else {
                return Container(
                  child: SvgPicture.asset(AppAssets.app_imagesSVG),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class ValTextColumWidget extends StatelessWidget {
  const ValTextColumWidget({
    super.key,
    required this.title,
    required this.desc,
  });
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.styleMedium14(context),
        ),
        SizedBox(height: 8),
        Text(
          desc,
          style: AppStyles.styleBold14(context).copyWith(
            color: AppColors.typographyHeading(context),
          ),
        ),
      ],
    );
  }
}

class WhatsAppAndCallButtonWidget extends StatelessWidget {
  const WhatsAppAndCallButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    final key = homeCubit.auctionData?.provider.companyPhoneNumber?.key ??
        homeCubit.auctionData?.provider.auctionPhoneNumber?.key;

    final number = homeCubit.auctionData?.provider.companyPhoneNumber?.number ??
        homeCubit.auctionData?.provider.auctionPhoneNumber?.number;

    String? whatsappNumber =
        (key != null || number != null) ? '${key ?? ''}${number ?? ''}' : null;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              if (whatsappNumber != null) {
                openLink('https://wa.me/${whatsappNumber}');
                print(
                    homeCubit.auctionData?.provider.auctionPhoneNumber?.number);
              } else {
                FloatingSnackBar.show(context, 'عذرا لا يوجد رقم حاليا');
              }
            },
            label: Text(
              'مراسلة عبر الواتساب',
              style: AppStyles.styleSemiBold14(context)
                  .copyWith(color: AppColors.typographyHeadingWhite(context)),
            ),
            icon: SvgPicture.asset(
              AppAssets.app_imagesWhatsappinfathCard,
              color: AppColors.typographyHeadingWhite(context),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              side: BorderSide(
                color: Color(0xFF549D78),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: Color(0xFF549D78),
              backgroundColor: Color(0xFF549D78),
            ),
          ),
        ),
        SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            if (whatsappNumber != null) {
              callPhoneNumber(whatsappNumber);
            } else {
              FloatingSnackBar.show(context, 'عذرا لا يوجد رقم حاليا');
            }
          },
          child: Container(
            width: 48,
            height: 48,
            padding: EdgeInsets.all(12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFF549D78),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: SvgPicture.asset(
              AppAssets.app_imagesCall,
              color: Color(0xFF549D78),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
