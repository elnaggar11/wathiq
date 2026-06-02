import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/my_snackbar.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    super.key,
    required this.agencyId,
  });
  final String agencyId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          context.read<ProfileCubit>().agencyId = agencyId;
          context.read<ProfileCubit>().deleteAgencies();
        },
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              previous.deleteAgenciesRequestState !=
              current.deleteAgenciesRequestState,
          listener: (context, state) {
            if (state.deleteAgenciesRequestState == RequestState.loaded) {
              context.pop();
              mySnackBar(
                state.deleteAccountMsg ?? 'تم حذف الوكالة',
                context,
                isError: false,
              );
              context.read<ProfileCubit>().getAgencies();
            } else if (state.deleteAgenciesRequestState == RequestState.error) {
              mySnackBar(
                state.deleteAccountError?.message ??
                    'هناك شئ ما خطأ حاول مجددا',
                context,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            if (state.deleteAgenciesRequestState == RequestState.loading) {
              return Lottie.asset(
                AppAnimationAssets.loading,
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.imagesDelete,
                    color: AppColors.white(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'حذف', // Format DateTime
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.white(context),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomSwitchButton extends StatefulWidget {
  @override
  _CustomSwitchButtonState createState() => _CustomSwitchButtonState();

  CustomSwitchButton(
      {super.key, required this.isActive, required this.agencyId});
  bool isActive;
  final String agencyId;
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  late bool isSwich;
  @override
  void initState() {
    isSwich = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          previous.activeAgenciesRequestState !=
          current.activeAgenciesRequestState,
      listener: (context, state) {
        if (state.activeAgenciesRequestState == RequestState.loaded) {
          mySnackBar(
            state.activeAgenciesMsg ?? 'تم بنجاح',
            context,
            isError: false,
          );
        } else if (state.activeAgenciesRequestState == RequestState.error) {
          mySnackBar(
            state.activeAgenciesError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
          setState(() {
            isSwich = !isSwich;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSwich = !isSwich;
          });
          profileCubit.agencyId = widget.agencyId;
          profileCubit.activeAgencies();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 44,
          height: 24,
          padding: EdgeInsets.only(left: isSwich ? 20 : 0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: isSwich ? AppColors.secondColor(context) : Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                !isSwich ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2, color: AppColors.secondColor(context)),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
