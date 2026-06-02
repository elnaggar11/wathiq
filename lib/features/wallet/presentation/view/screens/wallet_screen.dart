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

import '../../../../../app/app.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../../../../profile/presentation/view/screens/agencies_screen.dart';
import '../widgets/add_balance_sheet.dart';
import '../widgets/cards_widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xffF9F2DD),
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
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xffF9F2DD),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    WalletCubit walletCubit = context.read<WalletCubit>();
    return KisGuest == true
        ? GuestWidget()
        : DefaultTabController(
            length: 3,
            child: Scaffold(
                body: // Instead of SliverList and SliverToBoxAdapter
// just use a Column inside a normal SingleChildScrollView or directly in a widget if no scroll is needed

                    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntroWalletWidget(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'سجل المعاملات',
                        style: AppStyles.styleBold18(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      // Uncomment if needed:
                      // GestureDetector(
                      //   onTap: () {
                      //     context.navigateTo(Routes.TrunsactionHistoryScreen);
                      //   },
                      //   child: Text(
                      //     'عرض الكل',
                      //     style: AppStyles.styleBold14(context).copyWith(
                      //       color: AppColors.buttonsPrimary(context),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AgenciesCardWidegt(
                  onTap: () {
                    walletCubit.getUserInvoices();
                    context.navigateTo(Routes.InvoicesBodyScreen);
                  },
                  boxColor: const Color(0x0C1D6E4F),
                  icon: AppAssets.app_imagesAddmony,
                  title: 'شحن المحفظة',
                ),
                const SizedBox(height: 16),
                AgenciesCardWidegt(
                  onTap: () {
                    walletCubit.getWithdraw();
                    context.navigateTo(Routes.WithdrawBodyScreen);
                  },
                  boxColor: const Color(0x0C1D6E4F),
                  icon: AppAssets.app_imagesWithdr,
                  title: 'طلبات السحب',
                ),
                const SizedBox(height: 16),
                AgenciesCardWidegt(
                  onTap: () {
                    walletCubit.getHeldFunds();
                    context.navigateTo(Routes.HeldFundsBodyScreen);
                  },
                  boxColor: const Color(0x0C1D6E4F),
                  icon: AppAssets.app_imagesHeldFundsRowIcon,
                  title: 'المبالغ المحجوزة في المزادت',
                ),
                const SizedBox(height: 16),
              ],
            )),
          );
  }
}

class WithdrawBodyScreen extends StatelessWidget {
  const WithdrawBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    // handel using BlocBuilder and use getWithdrawModel and ErrorAppWidget and Loading shimmer
    // convert if to switch case
    return SafeArea(
        child: Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'طلبات السحب',
      ),
      body: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
        switch (state.getWithdrawRequestState) {
          case RequestState.loading:
          case RequestState.ideal:
            return LoadingWalletShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              text: state.getWithdrawError.toString(),
              onTap: () {
                context.read<WalletCubit>().getWithdraw();
              },
            );
          case RequestState.loaded:
            return state.getWithdrawModel?.data.isEmpty ?? true
                ? EmptyWidget(title: 'لا يوجد مسحوبات')
                : Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: state.getWithdrawModel?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          return WithdrawCardWidget(
                            withdraw: state.getWithdrawModel!,
                            index: index,
                          );
                        },
                      ),
                    ),
                  );
        }
      }),
    ));
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
      padding: EdgeInsets.all(16),
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
class InvoicesBodyScreen extends StatelessWidget {
  const InvoicesBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'شحن المحفظة',
        ),
        body: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
          switch (state.getUserInvoicesRequestState) {
            case RequestState.loading:
            case RequestState.ideal:
              return LoadingWalletShimmer();
            case RequestState.error:
              return ErrorAppWidget(
                text: state.getUserInvoicesError.toString(),
                onTap: () {
                  context.read<WalletCubit>().getUserInvoices();
                },
              );
            case RequestState.loaded:
              return state.getUserInvoicesModel?.data.isEmpty ?? true
                  ? EmptyWidget(title: 'لا يوجد فواتير')
                  : Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Expanded(
                        child: ListView.builder(
                          itemCount:
                              state.getUserInvoicesModel?.data.length ?? 0,
                          itemBuilder: (context, index) {
                            return InvoiceCardWidget(
                              invoice: state.getUserInvoicesModel!,
                              index: index,
                            );
                          },
                        ),
                      ),
                    );
          }
        }),
      ),
    );
  }
}

// handel like InvoicesBodyWidget
class HeldFundsBodyScreen extends StatelessWidget {
  const HeldFundsBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    return SafeArea(
        child: Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'المبالغ المحجوزة في المزادت',
      ),
      body: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
        switch (state.getHeldFundsRequestState) {
          case RequestState.loading:
          case RequestState.ideal:
            return LoadingWalletShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              text: state.getHeldFundsError.toString(),
              onTap: () {
                context.read<WalletCubit>().getHeldFunds();
              },
            );
          case RequestState.loaded:
            return state.getHeldFundsModel?.data.isEmpty ?? true
                ? EmptyWidget(title: 'لا يوجد مبالغ محجوزة')
                : Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: state.getHeldFundsModel?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          return HeldFundsCardWidget(
                            heldFunds: state.getHeldFundsModel!,
                            index: index,
                          );
                        },
                      ),
                    ),
                  );
        }
      }),
    ));
  }
}

class WalletTabBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const WalletTabBarWidget({
    super.key,
    required TabController tabController,
    required this.tapsName,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<String> tapsName;

  @override
  State<WalletTabBarWidget> createState() => _WalletTabBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}

class _WalletTabBarWidgetState extends State<WalletTabBarWidget> {
  @override
  @override
  void initState() {
    super.initState();
    widget._tabController.addListener(() {
      if (!widget._tabController.indexIsChanging) {
        return;
      }

      setState(() {});

      // if (widget._tabController.index == 0) {
      //   KtapIndex = 1;
      //   context.read<WalletCubit>().auctionsStatus = AppStrings.auctionsOnGoing;
      // } else if (widget._tabController.index == 1) {
      //   KtapIndex = 2;
      //   context.read<HomeCubit>().auctionsStatus =
      //       AppStrings.auctionsInProgress;
      // } else {
      //   KtapIndex = 3;
      //   context.read<HomeCubit>().auctionsStatus = AppStrings.auctionsCompleted;
      // }

      // context.read<HomeCubit>().getAuctions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundPrimary(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        margin: EdgeInsetsDirectional.only(start: 16, end: 16, top: 20),
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary(context),
          border: Border.all(
            width: 1,
            color: AppColors.inputBorder(context),
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: TabBar(
          controller: widget._tabController,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return Colors.transparent;
            },
          ),
          onTap: (value) {
            // setState(() {}); // Update tab selection
          },
          unselectedLabelColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.all(0),
          tabs: List<Widget>.generate(
            widget.tapsName.length,
            (index) => SizedBox(
              height: 40,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: widget._tabController.index == index
                      ? AppColors.buttonsPrimary(context)
                      : AppColors.backgroundPrimary(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.tapsName[index],
                      textAlign: TextAlign.center,
                      style: AppStyles.styleMedium14(context).copyWith(
                        color: widget._tabController.index == index
                            ? AppColors.white(context)
                            : AppColors.typographyHeading(context),
                      ),
                    ),
                    SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
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
    return Stack(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          color: Color(0xFFF9F2DD),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              BalanceWidget(),
              SizedBox(height: 8),
              Text(
                'الرصيد المتاح',
                style: AppStyles.styleMedium14(context).copyWith(
                  color: AppColors.color2(context),
                ),
              ),
              SizedBox(height: 16),
              Divider(
                color: AppColors.borderPrimary(context),
                height: 0,
                thickness: 2,
              ),
              SizedBox(height: 16),
              PinddingMonyWidget(),
              SizedBox(height: 32),
              Row(
                children: [
                  Flexible(
                    child: WalletButtonWidget(
                      text: 'شحن رصيد',
                      icon: AppAssets.app_imagesAddButtonMoneyIcon,
                      color: AppColors.color2(context),
                      onTap: () {
                        addBalanceSheetBottomSheet(context);
                      },
                    ),
                  ),
                  12.horizontalSpace,
                  Flexible(
                    child: WalletButtonWidget(
                      text: 'سحب رصيد',
                      icon: AppAssets.app_imagesWithdrawButtonIcon,
                      color: AppColors.primary(context),
                      onTap: () {
                        context.navigateTo(Routes.WithdrawScreen);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
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
            side: BorderSide(
              width: 0,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 32, maxWidth: 32),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(
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

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({
    super.key,
  });

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 250),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    formatNumber(state.getWalletModel?.data.balance ?? 0.0)
                        .toString(),
                    style: AppStyles.styleSemiBold24(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 0),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 25, maxWidth: 25),
          child: SvgPicture.asset(
            Assets.imagesCurrencyIcon,
            color: AppColors.typographyHeading(context),
          ),
        ),
        WalletRefreshWidget(),
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
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'المبالغ المحجوزة في المزادت' + '  ',
            style: AppStyles.styleMedium14(context).copyWith(
              color: AppColors.typographyBodyWhite(context),
            ),
          ),
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              return Text(
                formatNumber(state.getWalletModel?.heldFunds ?? 0.0),
                style: AppStyles.styleBold16(context).copyWith(
                  color: AppColors.typographyHeading(context),
                ),
              );
            },
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
            child: SvgPicture.asset(
              Assets.imagesCurrencyIcon,
              color: AppColors.typographyHeading(context),
            ),
          ),
        ],
      ),
    );
  }
}
