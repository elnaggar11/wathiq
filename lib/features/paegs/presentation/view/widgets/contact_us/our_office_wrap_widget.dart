import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/images.dart';

import '../../../../../../core/functions/url_luncher.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../data/models/social_model.dart';

class OurOfficeWrap extends StatelessWidget {
  final List<Office> offices;

  const OurOfficeWrap({super.key, required this.offices});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: offices
          .map(
            (office) => GestureDetector(
              onTap: () async {
                // You can use launchUrl from url_launcher package to open the link
                // launchUrl(Uri.parse(office.link ?? ''));
                await openLink(office.link);
              },
              child: Row(
                children: [
                  Text(
                    office.name ?? '',
                    style: AppStyles.styleMedium16(context)
                        .copyWith(color: AppColors.primary(context)),
                  ),
                  SizedBox(width: 4),
                  SvgPicture.asset(AppAssets.app_imagesOurofficeIcon),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
