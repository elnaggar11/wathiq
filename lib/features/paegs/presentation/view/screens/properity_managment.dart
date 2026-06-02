import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../core/utils/enums.dart';
import '../../../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../../../core/widgets/show_success_bottom_sheet.dart';
import '../../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../view_model/pages_cubit.dart';

class ProperityManagmentScreen extends StatefulWidget {
  const ProperityManagmentScreen({super.key});

  @override
  State<ProperityManagmentScreen> createState() =>
      _ProperityManagmentScreenState();
}

class _ProperityManagmentScreenState extends State<ProperityManagmentScreen> {
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
        appBar: CoustomAppBarWidget(title: 'إدارة أملاكك'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.properityFormKey,
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'ادخل تفاصيل الأملاك',
                        style: AppStyles.styleBold20(context).copyWith(
                            color: AppColors.typographyHeading(context)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomDropdownField(
                    label: 'المنطقة',
                    items: [
                      'البنك الأهلي السعودي',
                      'مصرف الراجحي',
                      'بنك الرياض',
                      // ...etc
                    ],
                    onChanged: (value) {
                      // handle change
                      print('Selected: $value');
                    },
                    onItemTap: (item) {
                      // optional: do something as soon as user taps the item
                      print('Tapped item: $item');
                    },
                  ),
                  SizedBox(height: 2),
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomDropdownField(
                            label: 'المدينة',
                            items: [
                              'البنك الأهلي السعودي',
                              'مصرف الراجحي',
                              'بنك الرياض',
                              // ...etc
                            ],
                            onChanged: (value) {
                              // handle change
                              print('Selected: $value');
                            },
                            onItemTap: (item) {
                              // optional: do something as soon as user taps the item
                              print('Tapped item: $item');
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: CustomDropdownField(
                            label: 'الحي',
                            items: [
                              'البنك الأهلي السعودي',
                              'مصرف الراجحي',
                              'بنك الرياض',
                              // ...etc
                            ],
                            onChanged: (value) {
                              // handle change
                              print('Selected: $value');
                            },
                            onItemTap: (item) {
                              // optional: do something as soon as user taps the item
                              print('Tapped item: $item');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2),
                  CustomDropdownField(
                    label: 'نوع العقار',
                    items: [
                      'البنك الأهلي السعودي',
                      'مصرف الراجحي',
                      'بنك الرياض',
                      // ...etc
                    ],
                    onChanged: (value) {
                      // handle change
                      print('Selected: $value');
                    },
                    onItemTap: (item) {
                      // optional: do something as soon as user taps the item
                      print('Tapped item: $item');
                    },
                  ),
                  SizedBox(height: 24),
                  CustomDropdownField(
                    label: 'فئة العقار',
                    items: [
                      'البنك الأهلي السعودي',
                      'مصرف الراجحي',
                      'بنك الرياض',
                      // ...etc
                    ],
                    onChanged: (value) {
                      // handle change
                      print('Selected: $value');
                    },
                    onItemTap: (item) {
                      // optional: do something as soon as user taps the item
                      print('Tapped item: $item');
                    },
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
                  AddProperityManagmentButtonWidget(),
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

class AddProperityManagmentButtonWidget extends StatelessWidget {
  const AddProperityManagmentButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PagesCubit cubit = context.read<PagesCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.properityManagment();
      },
      child: BlocConsumer<PagesCubit, PagesState>(
        listenWhen: (previous, current) =>
            previous.properityManagmentRequestState !=
            current.properityManagmentRequestState,
        listener: (context, state) {
          if (state.properityManagmentRequestState == RequestState.loaded) {
            showSuccessBottomSheet(
              context: context,
              title: 'تم إرسال الطلب بنجاح ',
              subTitle: 'سيتم التواصل معك قريبا جداً.........',
            );
          } else if (state.properityManagmentRequestState ==
              RequestState.error) {
            mySnackBar(
              state.properityManagmentError?.message ??
                  'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.properityManagmentRequestState == RequestState.loading) {
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

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.filled = false,
    this.initialValue,
    this.onChanged,
    this.onItemTap,
  });

  /// The label shown above the dropdown
  final String label;

  /// List of options
  final List<String> items;

  /// Whether to fill the background
  final bool filled;

  /// Initial selected value
  final String? initialValue;

  /// Called when value is changed
  final ValueChanged<String?>? onChanged;

  /// Called when a particular option is tapped (before onChanged)
  final ValueChanged<String>? onItemTap;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: selectedValue,
      menuMaxHeight: 600,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged?.call(value);
      },
      items: widget.items.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          onTap: () {
            widget.onItemTap?.call(option);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              option,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: AppStyles.styleRegular16(context)
              .copyWith(color: AppColors.typographyBody(context)),
        ),
        filled: widget.filled,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.backgroundTertiary(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary(context), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error(context)),
        ),
      ),
      iconSize: 20,
      icon: selectedValue == null
          ? Icon(
              Icons.arrow_drop_down,
              color: AppColors.typographyBody(context),
              size: 20,
            )
          : InkWell(
              onTap: () {
                setState(() {
                  selectedValue = null;
                });
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  Assets.imagesCloseIcon,
                  color: AppColors.typographyBody(context),
                ),
              ),
            ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى اختيار ${widget.label}';
        }
        return null;
      },
    );
  }
}
