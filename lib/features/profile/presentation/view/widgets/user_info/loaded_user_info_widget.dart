import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/profile/data/models/profile_model.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/user_info/show_delete_account_bottom_sheet.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/sign_up/complete_sign_up_mobile_layout_widget.dart';

class LoadedUserInfoWidget extends StatelessWidget {
  const LoadedUserInfoWidget({
    super.key,
    required this.profileModel,
  });
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 30),
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            onError: (exception, stackTrace) =>
                                Icons.error_outline_outlined,
                            image: profileCubit.imageFile == null
                                ? CachedNetworkImageProvider(
                                    profileModel.data.profileImage ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4n4D5jth4fm4GE7ut7lWW-04lnDO2OkD-sg&s',
                                  )
                                : FileImage(
                                    profileCubit.imageFile!,
                                  ),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(360),
                            side: const BorderSide(
                              width: 6,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFFD6D9E1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (profileCubit.imageFile == null) {
                            profileCubit.pickProfileImage();
                          }
                          if (profileCubit.imageFile != null) {
                            profileCubit.deletePickedImage();
                          }
                        },
                        child: Text(
                          profileCubit.imageFile == null ? 'تعديل' : 'حذف',
                          style: AppStyles.styleBold14(context).copyWith(
                            color: AppColors.primary(context),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              Divider(
                height: 0,
                thickness: 1,
                color: AppColors.borderPrimary(context),
              ),
              const SizedBox(height: 24),
              TextFormFieldWithTitleWidget(
                // controller: cubit.loginUserIDController,
                label: 'الإسم الأول',
                controller: profileCubit.firstNameController,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 20,
                      maxHeight: 20,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.app_imagesPerson,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                fillColor: AppColors.primaryOP5(context),
                enabled: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormFieldWithTitleWidget(
                // controller: cubit.loginUserIDController,
                label: 'الإسم الثاني',
                controller: profileCubit.SecondNameController,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 20,
                      maxHeight: 20,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.app_imagesPerson,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                fillColor: AppColors.primaryOP5(context),
                enabled: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormFieldWithTitleWidget(
                label: 'الإسم الثالث',
                controller: profileCubit.thirdNameController,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 20,
                      maxHeight: 20,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.app_imagesPerson,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                fillColor: AppColors.primaryOP5(context),
                enabled: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormFieldWithTitleWidget(
                // controller: cubit.loginUserIDController,
                label: 'الإسم الاخير',
                controller: profileCubit.lastNameController,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 20,
                      maxHeight: 20,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.app_imagesPerson,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                fillColor: AppColors.primaryOP5(context),
                enabled: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormFieldWithTitleWidget(
                // controller: cubit.loginUserIDController,
                label: 'رقم الهوية الوطنة / الاقامة',
                controller: profileCubit.identityNumberController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                fillColor: AppColors.primaryOP5(context),
                enabled: false,
                keyboardType: TextInputType.number,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 20,
                      maxHeight: 20,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.app_imagesNationalId,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocListener<ProfileCubit, ProfileState>(
                listenWhen: (previous, current) =>
                    previous.askEditPhoneRequestState !=
                    current.askEditPhoneRequestState,
                listener: (context, state) {
                  if (state.askEditPhoneRequestState == RequestState.loaded) {
                    context.navigateToWithArguments(Routes.oTPScreen, {
                      'nextRoute': Routes.changePhoneNumberScreen,
                      'totalSteps': 3,
                      'currentStep': 1,
                      'width': 95.0,
                    });
                    mySnackBar(
                      state.askEditPhoneMsg ?? 'هناك شئ ما خطأ حاول مجددا',
                      context,
                      isError: false,
                    );
                    context.read<AuthCubit>().identityNumberController.text =
                        profileModel.data.identityNumber;
                  } else if (state.askEditPhoneRequestState ==
                      RequestState.error) {
                    mySnackBar(
                      state.askEditPhoneError?.message ??
                          'هناك شئ ما خطأ حاول مجددا',
                      context,
                      isError: true,
                    );
                  }
                },
                child: InkWell(
                  onTap: () {
                    profileCubit.askEditPhone();
                  },
                  child: IgnorePointer(
                    ignoring: true,
                    child: TextFormFieldWithTitleWidget(
                      label: 'رقم الجوال',
                      controller: profileCubit.phoneController,
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                        child: Text(
                          'تغير الرقم',
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: AppColors.primary(context),
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary(context),
                            decorationThickness: 1,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(9),
                      ],
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 20,
                            maxHeight: 20,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.app_imagesPhone,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CitiesDropdownButtonFormFieldWidget(
                selectedValue: profileModel.data.country.name,
              ),
              const SizedBox(height: 20),
              BlocListener<ProfileCubit, ProfileState>(
                listenWhen: (previous, current) =>
                    previous.askAddEmailRequestState !=
                    current.askAddEmailRequestState,
                listener: (context, state) {
                  if (state.askAddEmailRequestState == RequestState.loaded) {
                    context.navigateToWithArguments(Routes.oTPScreen, {
                      'nextRoute': Routes.changeEmailScreen,
                      'totalSteps': 3,
                      'currentStep': 1,
                      'width': 95.0,
                    });
                    mySnackBar(
                      state.askAddEmailMsg ?? 'تم ',
                      context,
                      isError: false,
                    );
                    context.read<AuthCubit>().identityNumberController.text =
                        profileModel.data.identityNumber;
                  } else if (state.askAddEmailRequestState ==
                      RequestState.error) {
                    mySnackBar(
                      state.askAddEmailError?.message ??
                          'هناك شئ ما خطأ حاول مجددا',
                      context,
                      isError: true,
                    );
                  }
                },
                child: InkWell(
                  onTap: () {
                    profileCubit.askAddEmail();
                  },
                  child: IgnorePointer(
                    ignoring: true,
                    child: TextFormFieldWithTitleWidget(
                      label: 'البريد الاليكتروني ',
                      controller: profileCubit.emailController,
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى ادخال الرقم ';
                        }
                        if (value.isEmpty) {
                          return 'يرجى ادخال الرقم ';
                        }
                        return null;
                      },
                      enabled: true,
                      keyboardType: TextInputType.emailAddress,
                      prefix: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 20,
                            maxHeight: 20,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.app_imagesSealesEgentEmailIcn,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                        child: Text(
                          profileModel.data.email == null
                              ? 'ادخل البريد'
                              : 'تغير البريد',
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: AppColors.primary(context),
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary(context),
                            decorationThickness: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              profileModel.data.email == null
                  ? Row(
                      children: [
                        Text(
                          'يرجى ادخال البريد الالكتروني',
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: AppColors.danger(context),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 44),
              InkWell(
                onTap: () {
                  showDeleteAccountBottomSheet(context);
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0x19EB5757),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFE9EBEC)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.imagesTrashBinTrash,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'حذف الحساب ',
                        style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.danger(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
