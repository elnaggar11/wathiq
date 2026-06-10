import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/empty_widget.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/paegs/data/models/categories_model.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/qustions/question_answer_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/qustions/qustion_search_filed.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/qustions/shimmer_question_answer_list.dart';
import 'package:animate_do/animate_do.dart';

class QustionScreen extends StatefulWidget {
  const QustionScreen({super.key});

  @override
  State<QustionScreen> createState() => _QustionScreenState();
}

class _QustionScreenState extends State<QustionScreen> {
  @override
  void initState() {
    context.read<PagesCubit>()
      ..getQuestions()
      ..getQestionsCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primarySurface(context),
        appBar: CoustomAppBarWidget(
          title: ' الأسئلة الشائعة',
          bottom: const QustionSearchFiled(),
          hight: 117,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  child: BlocBuilder<PagesCubit, PagesState>(
                    buildWhen: (previous, current) =>
                      previous.qestionsCategoriesRequestState !=
                      current.qestionsCategoriesRequestState,
                  builder: (context, state) {
                    switch (state.qestionsCategoriesRequestState) {
                      case RequestState.ideal:
                      case RequestState.loading:
                        return const SizedBox();
                      case RequestState.loaded:
                        return HorizontalCategorySelector(
                          qestionsCategoriesModel:
                              state.qestionsCategoriesModel!,
                        );
                      case RequestState.error:
                        return ErrorAppWidget(
                          text: state.qestionsCategoriesError?.message ??
                              'حدث شئ ما خطأ',
                          onTap: () {
                            pagesCubit.getQestionsCategories();
                          },
                        );
                    }
                  },
                ),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 400),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<PagesCubit, PagesState>(
                    builder: (context, state) {
                      switch (state.qestionsRequestState) {
                        case RequestState.ideal:
                        case RequestState.loading:
                          return const ShimmerQuestionAnswerList();
                        case RequestState.error:
                          return const SizedBox.shrink();
                        case RequestState.loaded:
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.qestionsModel!.data.isEmpty
                                        ? ''
                                        : pagesCubit.category == null
                                            ? 'جميع الأسئلة'
                                            : pagesCubit.category?.name ??
                                                'الاسئلة',
                                    textAlign: TextAlign.start,
                                    style: AppStyles.styleSemiBold20(context)
                                        .copyWith(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              state.qestionsModel!.data.isEmpty
                                  ? const EmptyWidget(
                                      title: 'لم يتم العثور على البحث',
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          state.qestionsModel!.data.length,
                                      itemBuilder: (context, index) {
                                        return QuestionAnswerWidget(
                                          questionsModel: state.qestionsModel!,
                                          index: index,
                                        );
                                      },
                                    ),
                            ],
                          );
                      }
                    },
                  ),
                  ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalCategorySelector extends StatefulWidget {
  const HorizontalCategorySelector({
    super.key,
    required this.qestionsCategoriesModel,
  });

  final QestionsCategoriesModel qestionsCategoriesModel;

  @override
  State<HorizontalCategorySelector> createState() =>
      _HorizontalCategorySelectorState();
}

class _HorizontalCategorySelectorState
    extends State<HorizontalCategorySelector> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.qestionsCategoriesModel.data.length,
        itemBuilder: (context, index) {
          final category = widget.qestionsCategoriesModel.data[index];
          final isSelected = selectedValue == category.id;

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedValue = null;
                  pagesCubit.category = null;
                } else {
                  selectedValue = category.id;
                  pagesCubit.category = category;
                }
                pagesCubit.getQuestions();
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFFE1ECF9)
                    : AppColors.white(context) /* colours-Blue-Ocean-lighter */,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: AppStyles.styleMedium16(context).copyWith(
                    color: isSelected
                        ? AppColors.primary(context)
                        : AppColors.typographyHeading(context),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
