import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';

class PickedAgencyAttachmentWidget extends StatefulWidget {
  const PickedAgencyAttachmentWidget({
    super.key,
  });

  @override
  State<PickedAgencyAttachmentWidget> createState() =>
      _PickedAgencyAttachmentWidgetState();
}

class _PickedAgencyAttachmentWidgetState
    extends State<PickedAgencyAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            profileCubit.pickAgencyAttachment().then((val) {
              setState(() {});
            });
          },
          child: TextFormFieldWithTitleWidget(
            validator: (value) {
              if (profileCubit.agencyAttachment == null) {
                return 'إرفاق الوكالة مطلوب';
              }
              return null;
            },
            label: profileCubit.agencyAttachment == null
                ? 'إرفاق الوكالة'
                : profileCubit.agencyAttachment!.path.split('/').last,
            hintStyle: AppStyles.styleBold16(context),
            filled: true,
            fillColor: AppColors.backgroundPrimary(context),
            enabled: false,
            keyboardType: TextInputType.number,
            prefix: Container(
              margin: EdgeInsetsDirectional.only(
                  top: 8, bottom: 8, start: 8, end: 8),
              padding: EdgeInsets.all(6),
              child: SvgPicture.asset(
                AppAssets.app_imagesDocumentUpload,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
