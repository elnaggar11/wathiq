import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/empty_widget.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/functions/format_number.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';
import 'package:wathiq/features/profile/presentation/view/screens/agencies_screen.dart';
import 'package:wathiq/features/wallet/presentation/view/widgets/add_balance_sheet.dart';
import 'package:wathiq/features/wallet/presentation/view/widgets/cards_widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: const Color(0xffF9F2DD),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    super.initState();
    WalletCubit walletCubit = context.read<WalletCubit>();
    walletCubit.winner = false;
    walletCubit.loss = false;
    if (!KisGuest) {
      walletCubit.getWallet();
      walletCubit.getUserInvoices();
      walletCubit.getWithdraw();
      walletCubit.getHeldFunds();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: const Color(0xffF9F2DD),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    WalletCubit walletCubit = context.read<WalletCubit>();
    return KisGuest == true
        ? const GuestWidget()
        : DefaultTabController(
            length: 3,
            child: Scaffold(
                body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const SliverToBoxAdapter(
                    child: IntroWalletWidget(),
                  ),
                  const SliverToBoxAdapter(
                    child: WalletTabBarWidget(
                      tapsName: [
                        'شحن المحفظة',
                        'طلبات السحب',
                        'المبالغ المحجوزة في المزادات',
                      ],
                    ),
                  ),
                ];
              },
              body: Container(
                color: Colors.white,
                child: const TabBarView(
                  children: [
                    InvoicesListWidget(),
                    WithdrawListWidget(),
                    HeldFundsListWidget(),
                  ],
                ),
              ),
            )),
          );
  }
}

class WithdrawListWidget extends StatelessWidget {
  const WithdrawListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
      switch (state.getWithdrawRequestState) {
        case RequestState.loading:
        case RequestState.ideal:
          return const LoadingWalletShimmer();
        case RequestState.error:
          return ErrorAppWidget(
            text: state.getWithdrawError.toString(),
            onTap: () {
              context.read<WalletCubit>().getWithdraw();
            },
          );
        case RequestState.loaded:
          return state.getWithdrawModel?.data.isEmpty ?? true
              ? const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: EmptyWidget(
                      title: 'لا توجد معاملات',
                      subTitle: 'لم تقم بأي معاملات.',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ListView.builder(
                    itemCount: state.getWithdrawModel?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      return WithdrawCardWidget(
                        withdraw: state.getWithdrawModel!,
                        index: index,
                      );
                    },
                  ),
                );
      }
    });
  }
}

// create LoadingWalletShimmer
class LoadingWalletShimmer extends StatelessWidget {
  const LoadingWalletShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // make is list view builder
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }
}

// handel like WithdrawBodyWidget
class InvoicesListWidget extends StatelessWidget {
  const InvoicesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
      switch (state.getUserInvoicesRequestState) {
        case RequestState.loading:
        case RequestState.ideal:
          return const LoadingWalletShimmer();
        case RequestState.error:
          return ErrorAppWidget(
            text: state.getUserInvoicesError.toString(),
            onTap: () {
              context.read<WalletCubit>().getUserInvoices();
            },
          );
        case RequestState.loaded:
          return state.getUserInvoicesModel?.data.isEmpty ?? true
              ? const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: EmptyWidget(
                      title: 'لا توجد معاملات',
                      subTitle: 'لم تقم بأي معاملات.',
                      imagePath: 'assets/app_images/empty_wallet.svg',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ListView.builder(
                    itemCount: state.getUserInvoicesModel?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      return InvoiceCardWidget(
                        invoice: state.getUserInvoicesModel!,
                        index: index,
                      );
                    },
                  ),
                );
      }
    });
  }
}

// handel like InvoicesBodyWidget
class HeldFundsListWidget extends StatelessWidget {
  const HeldFundsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
      switch (state.getHeldFundsRequestState) {
        case RequestState.loading:
        case RequestState.ideal:
          return const LoadingWalletShimmer();
        case RequestState.error:
          return ErrorAppWidget(
            text: state.getHeldFundsError.toString(),
            onTap: () {
              context.read<WalletCubit>().getHeldFunds();
            },
          );
        case RequestState.loaded:
          return state.getHeldFundsModel?.data.isEmpty ?? true
              ? const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: EmptyWidget(
                      title: 'لا توجد معاملات',
                      subTitle: 'لم تقم بأي معاملات.',
                      imagePath: 'assets/app_images/empty_wallet.svg',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ListView.builder(
                    itemCount: state.getHeldFundsModel?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      return HeldFundsCardWidget(
                        heldFunds: state.getHeldFundsModel!,
                        index: index,
                      );
                    },
                  ),
                );
      }
    });
  }
}

class WalletTabBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const WalletTabBarWidget({
    super.key,
    required this.tapsName,
  });

  final List<String> tapsName;

  @override
  Size get preferredSize => Size.fromHeight(40.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
            child: Text(
              'سجل المعاملات',
              style: AppStyles.styleBold16(context).copyWith(
                color: AppColors.typographyHeading(context),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppColors.primary(context),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.primary(context),
            unselectedLabelColor: AppColors.iconsTertiary(context),
            labelStyle: AppStyles.styleBold14(context),
            unselectedLabelStyle: AppStyles.styleMedium14(context),
            tabs: tapsName.map((name) => Tab(text: name)).toList(),
          ),
        ],
      ),
    );
  }
}

class IntroWalletWidget extends StatelessWidget {
  const IntroWalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9F2DD),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const BalanceWidget(),
          Text(
            'الرصيد المتاح',
            style: AppStyles.styleMedium14(context).copyWith(
              color: AppColors.color2(context),
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            color: AppColors.borderPrimary(context).withOpacity(0.5),
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 16),
          const PinddingMonyWidget(),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: WalletButtonWidget(
                  text: 'سحب رصيد',
                  icon: AppAssets.app_imagesWithdrawButtonIcon,
                  color: const Color(0xFF20365F), // Dark blue
                  onTap: () {
                    context.navigateTo(Routes.WithdrawScreen);
                  },
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: WalletButtonWidget(
                  text: 'شحن رصيد',
                  icon: AppAssets.app_imagesAddButtonMoneyIcon,
                  color: const Color(0xFF38A169), // Green
                  onTap: () {
                    addBalanceSheetBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class WalletButtonWidget extends StatelessWidget {
  const WalletButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.color,
  });
  final String text, icon;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 32, maxWidth: 32),
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: AppStyles.styleBold16(context).copyWith(
                color: AppColors.white(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return Text(
              formatNumber(state.getWalletModel?.data.balance ?? 0.0)
                  .toString(),
              style: AppStyles.styleBold32(context).copyWith(
                color: AppColors.typographyHeading(context),
              ),
            );
          },
        ),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
          child: SvgPicture.asset(
            Assets.imagesCurrencyIcon,
            color: AppColors.typographyHeading(context),
          ),
        ),
      ],
    );
  }
}

class WalletRefreshWidget extends StatefulWidget {
  @override
  _WalletRefreshWidgetState createState() => _WalletRefreshWidgetState();
}

class _WalletRefreshWidgetState extends State<WalletRefreshWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(); // Start rotating
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state.getWalletRequestState == RequestState.loading) {
          return RotationTransition(
            turns: _controller,
            child: InkWell(
              onTap: () {
                context.read<WalletCubit>().getWallet();
              },
              child: SvgPicture.asset(
                AppAssets.app_imagesRefresh,
                width: 24, // Optional: adjust size
                height: 24,
                color: AppColors.typographyHeading(context),
              ),
            ),
          );
        }

        // Show normal static icon when not loading
        return InkWell(
          onTap: () {
            context.read<WalletCubit>().getWallet();
          },
          child: SvgPicture.asset(
            AppAssets.app_imagesRefresh,
            width: 24,
            height: 24,
            color: AppColors.typographyHeading(context),
          ),
        );
      },
    );
  }
}

class PinddingMonyWidget extends StatelessWidget {
  const PinddingMonyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'المبالغ المحجوزة في المزادات',
          style: AppStyles.styleMedium14(context).copyWith(
            color: AppColors.iconsTertiary(context),
          ),
        ),
        const SizedBox(width: 8),
        BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return Row(
              children: [
                Text(
                  formatNumber(state.getWalletModel?.heldFunds ?? 0.0),
                  style: AppStyles.styleBold16(context).copyWith(
                    color: AppColors.typographyHeading(context),
                  ),
                ),
                const SizedBox(width: 2),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 14, maxWidth: 14),
                  child: SvgPicture.asset(
                    Assets.imagesCurrencyIcon,
                    color: AppColors.typographyHeading(context),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
