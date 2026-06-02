import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/home/home_cubit.dart';

class AssetTitleAndLocationWidget extends StatelessWidget {
  const AssetTitleAndLocationWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    print(index);

    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(top: 8, bottom: 0, right: 16, left: 16),
          decoration: ShapeDecoration(
            color: const Color(0x33E0E0E0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: AppStyles.styleBold16(context).copyWith(
                fontSize: 32,
                color: AppColors.typographyHeading(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        SizedBox(
          width: 230,
          child: Text(
            homeCubit.originList[index].title ?? 'اسم الاصل',
            maxLines: 2,
            style: AppStyles.styleBold18(context).copyWith(
                color: AppColors.typographyHeading(context),
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}
