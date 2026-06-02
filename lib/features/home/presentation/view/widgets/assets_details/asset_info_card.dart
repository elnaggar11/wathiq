import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/images.dart';
import '../../../view_model/home/home_cubit.dart';

class AssetsDetailsWidget extends StatefulWidget {
  final int index;
  const AssetsDetailsWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _AssetsDetailsWidgetState createState() => _AssetsDetailsWidgetState();
}

class _AssetsDetailsWidgetState extends State<AssetsDetailsWidget>
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
    HomeCubit homeCubit = context.read<HomeCubit>();

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
          padding: EdgeInsetsDirectional.only(
              top: 14, bottom: 14, start: 20, end: 16),
          decoration: ShapeDecoration(
            color: AppColors.white(context),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: _isExpanded
                    ? const Color(0xFF2D9C95)
                    : AppColors.iconsSecondary(context),
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
                      homeCubit.auctionOrigin!.details[widget.index].title ??
                          'تفاصيل الاصل ',
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
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
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: Color(0xFFF9F9F8),
                        borderRadius: BorderRadius.circular(12)),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeCubit.auctionOrigin!.details[widget.index]
                          .auctionDetails.length,
                      itemBuilder: (context, index) {
                        final detail = homeCubit.auctionOrigin!
                            .details[widget.index].auctionDetails[index];

                        return Column(
                          children: [
                            Container(
                              height: 56,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Row(
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 135,
                                    ),
                                    child: Text(
                                      (detail.title ?? '') + ' :  ',
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.styleMedium16(context)
                                          .copyWith(
                                        color: AppColors.typographySubTitle(
                                            context),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 140,
                                      child: Text(
                                        (detail.description.toString() +
                                                (widget.index == 1
                                                    ? ' متر'
                                                    : ''))
                                            .toString(),
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppStyles.styleBold16(context)
                                            .copyWith(
                                          color: AppColors.typographyHeading(
                                              context),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index !=
                                homeCubit.auctionOrigin!.details[widget.index]
                                        .auctionDetails.length -
                                    1)
                              Divider(
                                height: 0,
                                color: AppColors.separatingBorder(context),
                              ),
                          ],
                        );
                      },
                    ),
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
