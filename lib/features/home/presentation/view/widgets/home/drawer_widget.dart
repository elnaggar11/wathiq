import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import '../../../../../../app/app.dart';
import '../../../../../../app/injector.dart';
import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/storage/i_app_local_storage.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../layout/presentation/view/screens/layout_screen.dart';
import '../../../view_model/home/home_cubit.dart';
import '../../screens/assets_details_screen.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
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
      {
        'text': 'المزادات المحفوظة',
        'image': AppAssets.app_imagesFavoriteAuction,
        'onTap': () {
          context.navigateTo(Routes.savedMazadeScreen);
        },
      },
      if (!KisGuest)
        {
          'text': 'وكلاء البيع',
          'image': AppAssets.app_imagesAddSales,
          'onTap': () {
            context.navigateTo(Routes.SalesAgentIntroScreen);
          },
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
        'text': 'الشروط و الاحكام',
        'image': AppAssets.app_imagesDocument,
        'onTap': () {
          context.navigateTo(Routes.policyScreen);
        },
      },
      {
        'text': 'أضف عقارك',
        'image': AppAssets.app_imagesAddReal,
        'onTap': () {
          context.navigateTo(Routes.AddRealStateScreen);
        },
      },
      {
        'text': 'إدارة أملاكك',
        'image': AppAssets.app_imagesProretuMana,
        'onTap': () {
          context.navigateTo(Routes.ProperityManagment);
        },
      }
    ];

    return Drawer(
      backgroundColor: AppColors.white(context),
      shape: LinearBorder(),
      width: 0.8.sw,
      child: Column(
        children: [
          SizedBox(height: 12),
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
                SizedBox(height: 30),
                DrawerDividerWidget(),
                SizedBox(height: 16),
                KisGuest == true
                    ? SizedBox.shrink()
                    : GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop(); // يغلق Drawer
                          await Future.delayed(Duration(
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
                                            ? RoundedRectangleBorder()
                                            : CircleBorder(),
                                      ),
                                    ),
                              SizedBox(width: 8),
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
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   userName?.split(' ').first ?? 'مستخدم',
                                  //   style: AppStyles.styleMedium14(context)
                                  //       .copyWith(
                                  //     color: AppColors.typographyBody(
                                  //       context,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(height: 8),
                                  // Row(
                                  //   children: [
                                  //     SvgPicture.asset(Assets.imagesDrawerWalet),
                                  //     SizedBox(width: 8),
                                  //     Text(
                                  //       '500,000 ر.س',
                                  //       style: AppStyles.styleBold18(context)
                                  //           .copyWith(
                                  //         fontWeight: FontWeight.w800,
                                  //         color: AppColors.primary(
                                  //           context,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),

          // SizedBox(height: 16),
          // Container(
          //   width: 279,
          //   padding: const EdgeInsets.all(16),
          //   decoration: ShapeDecoration(
          //     color: Colors.white /* Neutral-White */,
          //     shape: RoundedRectangleBorder(
          //       side: BorderSide(
          //         width: 1,
          //         color: const Color(0xFFE5E5E5) /* Grayscale-200 */,
          //       ),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          //   child: OutlinedButton(
          //     onPressed: () {
          //       // context.navigateTo(Routes.add);
          //     },
          //     style: OutlinedButton.styleFrom(
          //       side: BorderSide(color: AppColors.primary(context)),
          //       backgroundColor: KisGuest
          //           ? AppColors.white(context)
          //           : AppColors.primary(context),
          //       overlayColor: AppColors.primary(context),
          //       foregroundColor: AppColors.primary(context),
          //       surfaceTintColor: AppColors.primary(context),
          //       fixedSize: Size(double.infinity, 52),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           'اضف عقارك',
          //           style: AppStyles.styleBold16(context).copyWith(
          //             color: KisGuest
          //                 ? AppColors.primary(context)
          //                 : AppColors.white(context),
          //           ),
          //         ),
          //         SizedBox(width: 8),
          //         Container(
          //           padding: EdgeInsets.all(4),
          //           decoration: ShapeDecoration(
          //             color: const Color(
          //                 0xFFFAFAFA) /* [-Tokens-]-_Background-primary */,
          //             shape: RoundedRectangleBorder(
          //               side: BorderSide(
          //                 width: 1.50,
          //                 color: const Color(
          //                     0xFF023936) /* [-Tokens-]-Main-primary */,
          //               ),
          //               borderRadius: BorderRadius.circular(32),
          //             ),
          //           ),
          //           child: SvgPicture.asset(Assets.imagesShareAndroid),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                return ListTileWidget(
                  isLast: index == drawerList.length - 1,
                  image: drawerList[index]['image'],
                  text: drawerList[index]['text'],
                  onTap: drawerList[index]['onTap'],
                );
              },
            ),
          ),

          SizedBox(height: 16),
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
              constraints: BoxConstraints(
                maxHeight: 42,
                maxWidth: 42,
              ),
              child: SvgPicture.asset(
                AppAssets.app_imagesMonotoneadd,
              ),
            ),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: DrawerDividerWidget(),
          ),
      ],
    );
  }
}
