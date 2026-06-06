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
    ];

    return Drawer(
      backgroundColor: AppColors.white(context),
      shape: const LinearBorder(),
      width: 0.8.sw,
      child: Column(
        children: [
          const SizedBox(height: 12),
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppAssets.app_imagesHorizintalLogo,
                  height: 36,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),
                const DrawerDividerWidget(),
                const SizedBox(height: 16),
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    userName ?? 'مستخدم',
                                    style:
                                        AppStyles.styleBold14(context).copyWith(
                                      color: AppColors.typographyHeading(
                                        context,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                return ListTileWidget(
                  isLast: index == drawerList.length - 1,
                  image: drawerList[index]['image'],
                  text: drawerList[index]['text'],
                  onTap: drawerList[index]['onTap'],
                )
                    .animate()
                    .slideX(
                      begin: 0.5,
                      end: 0,
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOutCubic,
                    )
                    .fadeIn(
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 100),
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

class ListTileWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
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
                image,
                fit: BoxFit.contain,
                color: AppColors.typographyHeading(context),
              ),
            ),
            title: Text(
              text,
              textAlign: TextAlign.start,
              style: AppStyles.styleSemiBold18(context).copyWith(
                color: AppColors.typographyHeading(context),
                height: 1.33,
              ),
            ),
            onTap: onTap,
          ),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: DrawerDividerWidget(),
          ),
      ],
    );
  }
}
