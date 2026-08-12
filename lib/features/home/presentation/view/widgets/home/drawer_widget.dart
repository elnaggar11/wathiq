import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/app/app.dart';
import 'package:wathiq/app/injector.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/features/layout/presentation/view/screens/layout_screen.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/screens/assets_details_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final String? userName =
      serviceLocator<IAppLocalStorage>().getValue(AppStrings.userName);

  final String? userImage =
      serviceLocator<IAppLocalStorage>().getValue(AppStrings.userImage);

  @override
  Widget build(BuildContext context) {
    final List drawerList = [
      {
        'text': 'قائمة المزادات',
        'image': AppAssets.app_imagesGavelLawBlackIcon,
        'onTap': () async {
          HomeCubit homeCubit = context.read<HomeCubit>();
          await context.navigateTo(Routes.mazadatMenuScreen).then((_) {
            KtapIndex = 1;
            homeCubit.auctionsStatus = homeCubit.LastHomeAuctionsStatus;
            homeCubit.auctionFilterSearch.text = '';
            homeCubit.filterAuctiontype = null;
            homeCubit.getAuctions();
          });
        },
      },
      if (!KisGuest)
        {
          'image': AppAssets.app_imagesHeart,
          'onTap': () {
            context.navigateTo(Routes.savedMazadeScreen);
          },
          'text': 'المفضلة',
        },
      {
        'text': 'تواصل معنا',
        'image': AppAssets.app_imagesContactUsIcon,
        'onTap': () {
          context.navigateTo(Routes.contactUsScreen);
        },
      },
      {
        'text': 'الأسئلة الشائعة',
        'image': AppAssets.app_imagesQuestionCircle,
        'onTap': () {
          context.navigateTo(Routes.qustionScreen);
        },
      },
      {
        'text': 'كن شريكا لنا',
        'image': AppAssets.app_imagesAgencies,
        'onTap': () {
          context.navigateTo(Routes.SalesAgentIntroScreen);
        },
      },
      if (!KisGuest)
        {
          'text': 'أضف عقارك',
          'image': AppAssets.app_imagesAddReal,
          'onTap': () {
            context.navigateTo(Routes.AddRealStateScreen);
          },
        },
      if (!KisGuest)
        {
          'text': 'إدارة أملاكك',
          'image': AppAssets.app_imagesProretuMana,
          'onTap': () {
            context.navigateTo(Routes.ProperityManagment);
          },
        },
    ];

    return Drawer(
      backgroundColor: AppColors.white(context),
      shape: const LinearBorder(),
      width: 0.8.sw,
      child: Column(
        children: [
          const SizedBox(height: 12),
          // ── Header Section ──
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo with fade-down entrance
                SvgPicture.asset(
                  AppAssets.app_imagesHorizintalLogo,
                  height: 36,
                  width: 150,
                  fit: BoxFit.contain,
                )
                    .animate()
                    .fadeIn(
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    )
                    .slideY(
                      begin: -0.3,
                      end: 0,
                      duration: 500.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 30),
                // Divider with scale-X expansion
                const DrawerDividerWidget()
                    .animate()
                    .scaleX(
                      begin: 0,
                      end: 1,
                      duration: 400.ms,
                      delay: 150.ms,
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.centerRight,
                    ),
                const SizedBox(height: 16),
                // Profile card with slide-up + fade
                KisGuest == true
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop(); // يغلق Drawer
                          await Future.delayed(const Duration(
                              milliseconds: 100)); // انتظر حتى يُغلق drawer
                          KcurrentIndex = 3;
                          context.navigateToWithReplacementAndClearStack(
                              Routes.layoutScreen);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(
                                0xFFF5F5F5) /* Background-bg-gentle */,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              userImage == null
                                  ? SizedBox(
                                      width: 36,
                                      height: 36,
                                      child: Image.asset(
                                          AppAssets.app_imagesAppLogoWathiq),
                                    )
                                  : Container(
                                      width: 36,
                                      height: 36,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          onError: (exception, stackTrace) =>
                                              SvgPicture.asset(
                                                  Assets.imagesDrawerlogo),
                                          image: CachedNetworkImageProvider(
                                            userImage!,
                                            errorListener: (p0) =>
                                                SvgPicture.asset(
                                                    Assets.imagesDrawerlogo),
                                          ),
                                          fit: userImage == null
                                              ? BoxFit.contain
                                              : BoxFit.cover,
                                        ),
                                        shape: userImage == null
                                            ? const RoundedRectangleBorder()
                                            : const CircleBorder(),
                                      ),
                                    ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'حياك الله ضيفنا.',
                                      style: AppStyles.styleBold14(context)
                                          .copyWith(
                                        color: AppColors.typographyHeading(
                                            context),
                                      ),
                                    ),
                                    Text(
                                      userName ?? 'مستخدم',
                                      style: AppStyles.styleRegular14(context)
                                          .copyWith(
                                        color: AppColors.typographySubTitle(
                                            context),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                        .animate()
                        .fadeIn(
                          duration: 450.ms,
                          delay: 200.ms,
                          curve: Curves.easeOut,
                        )
                        .slideY(
                          begin: 0.15,
                          end: 0,
                          duration: 450.ms,
                          delay: 200.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                          duration: 450.ms,
                          delay: 200.ms,
                          curve: Curves.easeOutCubic,
                        ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // ── Menu Items List ──
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                // Stagger delay: 350ms base + 70ms per item
                final staggerDelay = 350 + (70 * index);
                return ListTileWidget(
                  isLast: index == drawerList.length - 1,
                  image: drawerList[index]['image'],
                  text: drawerList[index]['text'],
                  onTap: drawerList[index]['onTap'],
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: staggerDelay),
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    )
                    .slideX(
                      begin: 0.25,
                      end: 0,
                      delay: Duration(milliseconds: staggerDelay),
                      duration: 450.ms,
                      curve: Curves.easeOutQuart,
                    );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class DrawerDividerWidget extends StatelessWidget {
  const DrawerDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.borderPrimary(context),
      height: 1,
    );
  }
}

class ListTileWidget extends StatefulWidget {
  const ListTileWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
    required this.isLast,
  });
  final String text;
  final String image;
  final Function() onTap;
  final bool isLast;

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tapController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) {
    _tapController.forward();
  }

  void _handleTapUp(TapUpDetails _) {
    _tapController.reverse();
  }

  void _handleTapCancel() {
    _tapController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6, top: 6),
              child: ListTile(
                // put image at right side
                trailing: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 42,
                    maxWidth: 42,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.app_imagesMonotoneadd,
                  ),
                ),
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 42,
                    maxWidth: 42,
                  ),
                  child: SvgPicture.asset(
                    widget.image,
                    fit: BoxFit.contain,
                    color: AppColors.typographyHeading(context),
                  ),
                ),
                title: Text(
                  widget.text,
                  textAlign: TextAlign.start,
                  style: AppStyles.styleSemiBold18(context).copyWith(
                    color: AppColors.typographyHeading(context),
                    height: 1.33,
                  ),
                ),
              ),
            ),
            if (!widget.isLast)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: DrawerDividerWidget(),
              ),
          ],
        ),
      ),
    );
  }
}

