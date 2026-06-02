import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';

import '../../../../../../core/functions/url_luncher.dart';

class ContactUsCardWidget extends StatelessWidget {
  ContactUsCardWidget({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.linkedin,
    this.twitter,
    this.youtube,
    this.instagram,
    this.subText,
    this.subtextIcon,
  });
  final String? text, icon, subtextIcon;
  final Function()? onTap;
  final String? linkedin, twitter, youtube, instagram, subText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SvgPicture.asset(icon!),
                ),
          SizedBox(width: icon == null ? 0 : 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              instagram == null ? SizedBox(height: 8) : SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    text ?? "",
                    textAlign: TextAlign.start,
                    style: AppStyles.styleBold16(context),
                  ),
                ],
              ),
              SizedBox(height: 4),
              subText != null
                  ? Row(
                      children: [
                        Text(
                          subText ?? '',
                          textAlign: TextAlign.center,
                          style: AppStyles.styleMedium16(context)
                              .copyWith(color: AppColors.primary(context)),
                        ),
                        SizedBox(
                          width: subtextIcon != null ? 4 : 0,
                        ),
                        subtextIcon != null
                            ? SvgPicture.asset(subtextIcon!)
                            : SizedBox.shrink()
                      ],
                    )
                  : SizedBox.shrink(),
              subText != null ? SizedBox(height: 12) : SizedBox.shrink(),
              Row(
                children: [
                  instagram != null
                      ? InkWell(
                          onTap: () async {
                            await openLink(instagram);
                          },
                          child: SvgPicture.asset(
                            AppAssets.app_imagesInsta,
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(width: 12),
                  youtube != null
                      ? InkWell(
                          onTap: () {
                            openLink(youtube);
                          },
                          child: SvgPicture.asset(
                            AppAssets.app_imagesYoutube,
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(width: 12),
                  linkedin != null
                      ? InkWell(
                          onTap: () {
                            openLink(linkedin);
                          },
                          child: SvgPicture.asset(
                            AppAssets.app_imagesLinkedin,
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(width: 12),
                  twitter != null
                      ? InkWell(
                          onTap: () {
                            openLink(twitter);
                          },
                          child: SvgPicture.asset(
                            AppAssets.app_imagesX,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
