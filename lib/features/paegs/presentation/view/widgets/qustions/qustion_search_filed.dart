import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';

class QustionSearchFiled extends StatelessWidget
    implements PreferredSizeWidget {
  const QustionSearchFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 16, left: 16),
      child: TextFormFieldWithTitleWidget(
        controller: pagesCubit.questionsSearchController,
        onChanged: (p0) {
          pagesCubit.getQuestions();
        },

        label: 'البحث عن الأسئلة',
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '';
          }
          return null;
        },
        // errorWidget: ShowErrorUnderTFFWidget(
        //   title: cubit.state.loginRequestState == RequestState.error &&
        //           cubit.state.loginError!.data != null &&
        //           cubit.state.loginError!.data!.containsKey('password')
        //       ? (cubit.state.registerError!.data!['password'] as List)
        //           .map((e) => e.toString())
        //           .join(', ')
        //       : '',
        //   condition: cubit.state.loginRequestState == RequestState.error &&
        //       cubit.state.loginError!.data != null &&
        //       cubit.state.loginError!.data!.containsKey('password'),
        // ),
        prefix: Padding(
          padding: const EdgeInsetsDirectional.only(end: 8, start: 16),
          child: SizedBox(
            width: 20,
            height: 20,
            child: InkWell(
              child: SvgPicture.asset(
                Assets.imagesMagnifer,
                fit: BoxFit.contain,
                color: AppColors.iconsPrimary(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(54);
}
