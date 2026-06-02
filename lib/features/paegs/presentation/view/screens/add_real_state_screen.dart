import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/enums.dart';
import '../../../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../../../core/widgets/show_success_bottom_sheet.dart';
import '../../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../view_model/pages_cubit.dart';

class AddRealStateScreen extends StatefulWidget {
  const AddRealStateScreen({super.key});

  @override
  State<AddRealStateScreen> createState() => _AddRealStateScreenState();
}

class _AddRealStateScreenState extends State<AddRealStateScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.primary(context),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
      ),
    );
    PagesCubit cubit = context.read<PagesCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(title: 'أضف عقارك'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.addRealFormKey,
              child: Column(
                children: [
                  SizedBox(height: 32),
                  TextFormFieldWithTitleWidget(
                    controller: cubit.realStateNameController,
                    label: 'الإسم بالكامل',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال الإسم ';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 24),
                  TextFormFieldWithTitleWidget(
                    controller: cubit.realStatephoneNumberController,
                    label: 'رقم الجوال',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال رقم الجوال';
                      }
                      if (!RegExp(r'^5\d{8}$').hasMatch(value)) {
                        return 'يجب أن يبدأ رقم الجوال ب 5 ويتكون من 9 أرقام';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    suffixIconSize: 70,
                    suffix: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 1.w,
                          color: AppColors.separatingBorder(context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 0.w,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            height: 24.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              '966+',
                              style: AppStyles.styleBold16(context).copyWith(
                                color: AppColors.typographyHeading(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormFieldWithTitleWidget(
                    controller: cubit.areaController,
                    label: 'المساحة',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال المساحة';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 95,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormFieldWithTitleWidget(
                            controller: cubit.cityController,
                            label: 'المدينة',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء ادخال المدينة';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: TextFormFieldWithTitleWidget(
                            controller: cubit.neighborhoodController,
                            label: 'الحي',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء ادخال الحي';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2),
                  TextFormFieldWithTitleWidget(
                    controller: cubit.descriptionController,
                    label: 'وصف العقار',
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال وصف العقار';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        'هل العقار مقيم تقييم معتمد؟',
                        style: AppStyles.styleSemiBold16(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SelectRealEstateStatusRadioButton(),
                  SizedBox(height: 24),
                  AddRealStateButtonWidget(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddRealStateButtonWidget extends StatelessWidget {
  const AddRealStateButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PagesCubit cubit = context.read<PagesCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.addRealState();
      },
      child: BlocConsumer<PagesCubit, PagesState>(
        listenWhen: (previous, current) =>
            previous.addRealStateRequestState !=
            current.addRealStateRequestState,
        listener: (context, state) {
          if (state.addRealStateRequestState == RequestState.loaded) {
            showSuccessBottomSheet(
              context: context,
              title: 'تم إرسال الطلب بنجاح ',
              subTitle: 'سيتم التواصل معك قريبا جداً.........',
            );
          } else if (state.addRealStateRequestState == RequestState.error) {
            mySnackBar(
              state.addRealStateError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.addRealStateRequestState == RequestState.loading) {
            return SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: AppColors.white(context),
              ),
            );
          } else {
            return Text(
              'إرسال',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}

class SelectRealEstateStatusRadioButton extends StatefulWidget {
  const SelectRealEstateStatusRadioButton({super.key});

  @override
  State<SelectRealEstateStatusRadioButton> createState() =>
      _SelectRealEstateStatusRadioButtonState();
}

class _SelectRealEstateStatusRadioButtonState
    extends State<SelectRealEstateStatusRadioButton> {
  String? _selectedValue = 'نعم';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      if (_selectedValue == 'نعم') {
        context.read<PagesCubit>().certifiedNotifier = true;
      } else {
        context.read<PagesCubit>().certifiedNotifier = false;
      }

      print(_selectedValue); // consider removing in production
    });
  }

  @override
  Widget build(BuildContext context) {
    final pagesCubit = context.read<PagesCubit>();

    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.primary(context),
            title: Text(
              'نعم',
              style: AppStyles.styleSemiBold16(context)
                  .copyWith(color: AppColors.typographySubTitle(context)),
            ),
            value: 'نعم',
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.primary(context),
            title: Text(
              'لا',
              style: AppStyles.styleSemiBold16(context)
                  .copyWith(color: AppColors.typographySubTitle(context)),
            ),
            value: 'لا',
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
          ),
        ),
      ],
    );
  }
}
