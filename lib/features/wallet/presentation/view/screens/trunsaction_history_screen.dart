import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/screens/wallet.dart';

import '../../../../../core/utils/app_images.dart';
import '../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../home/presentation/view_model/home/home_cubit.dart';
import '../../view_model/wallet/wallet_cubit.dart';
import '../widgets/cards_widgets.dart';

class TrunsactionHistoryScreen extends StatefulWidget {
  const TrunsactionHistoryScreen({super.key});

  @override
  State<TrunsactionHistoryScreen> createState() =>
      _TrunsactionHistoryScreenState();
}

class _TrunsactionHistoryScreenState extends State<TrunsactionHistoryScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: IntroTrunsactonScreenWidget()),
          ],
          body: WalletBodyWidget(),
        ),
      ),
    );
  }
}

class WalletBodyWidget extends StatelessWidget {
  const WalletBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return HeldFundsCardWidget(
          heldFunds: context.read<WalletCubit>().state.getHeldFundsModel!,
          index: index,
        );
      },
    );
  }
}

class IntroTrunsactonScreenWidget extends StatelessWidget {
  const IntroTrunsactonScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.imagesActiveMazad,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
                      child: SvgPicture.asset(Assets.imagesArrowLeftLong),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'سجل المعاملات',
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.white(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextFormFieldWithTitleWidget(
                hint: 'ابحث عن معاملة',
                // controller: homeCubit.originSearch,
                onChanged: (value) {
                  // homeCubit.searchAuctionOrigins(value);
                },
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 16, end: 8.w),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: InkWell(
                      child: SvgPicture.asset(
                        Assets.imagesMagnifer,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                suffix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 16, end: 8.w),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: InkWell(
                      child: SvgPicture.asset(
                        Assets.imagesActiveMazad,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
