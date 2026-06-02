import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';

import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/core/widgets/show_success_bottom_sheet.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/build_step_one.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/build_step_three.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/build_step_two.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final PagesCubit pagesCubit;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentPage,
    required this.onPrevious,
    required this.onNext,
    required this.pagesCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
          // color: AppColors.white(context),
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0x19101828),
          //     blurRadius: 26.50,
          //     offset: Offset(0, -1),
          //     spreadRadius: -1,
          //   )
          // ],
          ),
      child: Row(
        children: [
          currentPage == 0
              ? const SizedBox.shrink()
              : Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: onPrevious,
                    child: Text(
                      'السابق',
                      style: AppStyles.styleSemiBold16(context).copyWith(
                          color: AppColors.typographySubTitle(context)),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      side: BorderSide(
                        color: AppColors.separatingBorder1(context),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: AppColors.separatingBorder1(context),
                      backgroundColor: AppColors.white(context),
                    ),
                  ),
                ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: onNext,
              child: BlocConsumer<PagesCubit, PagesState>(
                listenWhen: (previous, current) =>
                    previous.createSalesAgentRequestState !=
                    current.createSalesAgentRequestState,
                listener: (context, state) {
                  if (state.createSalesAgentRequestState ==
                      RequestState.loaded) {
                    showSuccessBottomSheet(
                      context: context,
                      title: 'تم إرسال الطلب بنجاح ',
                      subTitle: 'سيتم التواصل معك قريبا جداً.........',
                    );
                  } else if (state.createSalesAgentRequestState ==
                      RequestState.error) {
                    mySnackBar(
                      state.createSalesAgentError?.message ??
                          'هناك شئ ما خطأ حاول مجددا',
                      context,
                      isError: true,
                    );
                  }
                },
                builder: (context, state) {
                  if (state.createSalesAgentRequestState ==
                      RequestState.loading) {
                    return Lottie.asset(
                      AppAnimationAssets.loading,
                    );
                  } else {
                    return Text(
                      currentPage == 2 ? 'تأكيد' : 'التالي',
                      style: AppStyles.styleBold18(context)
                          .copyWith(color: AppColors.white(context)),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddSalesAgentScreen extends StatefulWidget {
  const AddSalesAgentScreen({super.key});

  @override
  State<AddSalesAgentScreen> createState() => _AddSalesAgentScreenState();
}

class _AddSalesAgentScreenState extends State<AddSalesAgentScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late PagesCubit pagesCubit;
  @override
  void initState() {
    pagesCubit = context.read<PagesCubit>();
    super.initState();
  }

  void _onNext() {
    if (_currentPage == 0 &&
        !pagesCubit.companyDataFormKey.currentState!.validate()) return;
    if (_currentPage == 1 &&
        !pagesCubit.bankDateFormKey.currentState!.validate()) return;
    if (_currentPage == 2 &&
        !pagesCubit.UserDataFormKey.currentState!.validate()) return;
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
      });
      _pageController.jumpToPage(
        _currentPage,
      );
    }
  }

  void _onPrevious() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.jumpToPage(
        _currentPage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primarySurface(context),
        // bottomNavigationBar: CustomBottomNavigationBar(
        //   currentPage: _currentPage,
        //   onPrevious: _onPrevious,
        //   onNext: () {
        //     if (_currentPage == 2) {
        //       pagesCubit.createSalesAgent();
        //     } else {
        //       _onNext();
        //     }
        //   },
        //   pagesCubit: pagesCubit,
        // ),
        appBar: CoustomAppBarWidget(title: 'وكيل بيع'),
        body: BlocBuilder<PagesCubit, PagesState>(
          builder: (context, state) {
            return PageView.builder(
              allowImplicitScrolling: false,
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return ListView(
                      children: [
                        const BuildStepOneWidget(),
                        CustomBottomNavigationBar(
                          currentPage: _currentPage,
                          onPrevious: _onPrevious,
                          onNext: () {
                            if (_currentPage == 2) {
                              pagesCubit.createSalesAgent();
                            } else {
                              if (pagesCubit.commercialRegStartDateController
                                      .text.isNotEmpty &&
                                  pagesCubit.commercialRegEndDateController.text
                                      .isNotEmpty) {
                                DateTime startDate = DateTime.parse(pagesCubit
                                    .commercialRegStartDateController.text);
                                DateTime endDate = DateTime.parse(pagesCubit
                                    .commercialRegEndDateController.text);

                                if (!endDate.isAfter(startDate)) {
                                  FloatingSnackBar.show(context,
                                      'يجب أن يكون تاريخ الانتهاء بعد تاريخ الإصدار');
                                }
                              }

                              _onNext();
                            }
                          },
                          pagesCubit: pagesCubit,
                        ),
                      ],
                    );
                  case 1:
                    return ListView(
                      children: [
                        const BuildStepTwoWidget(),
                        Padding(
                          padding: EdgeInsets.only(top: 220.h),
                          child: CustomBottomNavigationBar(
                            currentPage: _currentPage,
                            onPrevious: _onPrevious,
                            onNext: () {
                              if (_currentPage == 2) {
                                pagesCubit.createSalesAgent();
                              } else {
                                _onNext();
                              }
                            },
                            pagesCubit: pagesCubit,
                          ),
                        ),
                      ],
                    );
                  case 2:
                    return ListView(
                      children: [
                        const BuildStepThreeWidget(),
                        CustomBottomNavigationBar(
                          currentPage: _currentPage,
                          onPrevious: _onPrevious,
                          onNext: () {
                            if (_currentPage == 2) {
                              pagesCubit.createSalesAgent();
                            } else {
                              _onNext();
                            }
                          },
                          pagesCubit: pagesCubit,
                        ),
                      ],
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
