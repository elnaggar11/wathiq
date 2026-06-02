import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/delete_agency_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/delete_and_swich_buttons.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/profile/profile_cubit.dart';

class InActiveAgenciesRowWidget extends StatelessWidget {
  const InActiveAgenciesRowWidget({
    super.key,
    required this.dateTime,
  });
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return Row(
      children: [
        Text(
          'تاريخ ارسال الطلب :',
          style: AppStyles.styleBold12(context).copyWith(
            color: AppColors.typographySubTitle(context),
          ),
        ),
        SizedBox(width: 4),
        Text(
          DateFormat("yyyy-MM-dd").format(dateTime),
          style: AppStyles.styleSemiBold12(context).copyWith(
            color: AppColors.typographySubTitle(context),
          ),
        ),
      ],
    );
  }
}

class ActiveAgenciesRowWidget extends StatelessWidget {
  const ActiveAgenciesRowWidget({
    super.key,
    required this.isActive,
    required this.agencyId,
  });
  final bool isActive;
  final String agencyId;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomSwitchButton(
          isActive: isActive,
          agencyId: agencyId,
        ),
        Spacer(),
        DeleteAgencyWidget(
          agencyId: agencyId,
        ),
      ],
    );
  }
}
