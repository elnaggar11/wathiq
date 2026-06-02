import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/images.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/paegs/data/models/question_model.dart';

class QuestionAnswerWidget extends StatefulWidget {
  final QuestionsModel questionsModel;
  final int index;
  const QuestionAnswerWidget({
    Key? key,
    required this.questionsModel,
    required this.index,
  }) : super(key: key);

  @override
  _QuestionAnswerWidgetState createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.backgroundPrimary(context),
      shadowColor: Colors.transparent,
      child: InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: _toggleExpansion,
        child: Container(
          padding: const EdgeInsetsDirectional.only(
              top: 14, bottom: 14, start: 20, end: 16),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: _isExpanded
                    ? const Color(0xFF2D9C95)
                    : AppColors.borderPrimary(context) /* Borders-secondary */,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 240,
                    child: Text(
                      widget.questionsModel.data[widget.index].question,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.typographyHeading(context)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: _isExpanded
                          ? const Color(0x0C199767)
                          : AppColors.primarySurface(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: SvgPicture.asset(
                      _isExpanded
                          ? AppAssets.app_imagesMinus
                          : AppAssets.app_imagesPlus,
                    ),
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Html(
                    data: widget.questionsModel.data[widget.index].answer,
                    style: {
                      'body': Style(
                        fontFamily: 'Lama Sans',
                        lineHeight: const LineHeight(1.7),
                        color: AppColors.typographyBody(context),
                      ),
                    },
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
