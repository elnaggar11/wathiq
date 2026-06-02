import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/delete_and_swich_buttons.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

class DeleteAgencyWidget extends StatelessWidget {
  const DeleteAgencyWidget({
    super.key,
    required this.agencyId,
  });
  final String agencyId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDeleteAgencyBottomSheet(context, agencyId);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.app_imagesDelete,
          ),
        ],
      ),
    );
  }
}

Future<void> showDeleteAgencyBottomSheet(
    BuildContext context, String agencyId) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.imagesDeleteAccount,
                ),
                const SizedBox(height: 16),
                Text('حذف الوكالة', // Format DateTime
                    style: AppStyles.stylBold24(context)),
                const SizedBox(height: 16),
                Text(
                    'هل أنت متأكد أنك تريد حذف الوكالة نهائيا؟', // Format DateTime
                    style: AppStyles.styleSemiBold18(context).copyWith(
                      color: AppColors.typographySubTitle(context),
                    )),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.pop();
                          },
                          label: Text(
                            'إلغاء',
                            style: AppStyles.styleBold16(context).copyWith(
                                color: AppColors.iconsTertiary(context)),
                          ),
                          icon: SvgPicture.asset(
                            Assets.imagesClose,
                          ),
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 46),
                              side: BorderSide(
                                color: AppColors.iconsTertiary(context),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              foregroundColor: AppColors.iconsTertiary(context),
                              backgroundColor: AppColors.white(context)),
                        ),
                      ),
                      const SizedBox(width: 24),
                      DeleteButtonWidget(
                        agencyId: agencyId,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
