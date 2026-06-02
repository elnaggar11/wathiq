import 'package:flutter/material.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/auction_price_and_add_widegts.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget>
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
      color: AppColors.backgroundPrimary(context),
      shadowColor: Colors.transparent,
      child: InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: _toggleExpansion,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: ShapeDecoration(
                color: AppColors.primarySurface(context),
                shape: RoundedRectangleBorder(
                  // if expanded remove border ridies from buttom and remove border from buttom
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                    bottom: Radius.circular(_isExpanded ? 2 : 12),
                  ),

                  side: BorderSide(
                    width: 1,
                    color: AppColors.borderPrimary(context),
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الحاسبة',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Color(0xFF727A90),
                  ),
                ],
              ),
            ),
            SizeTransition(
              sizeFactor: _expandAnimation,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: PriceingWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
