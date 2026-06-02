import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/paegs/data/models/notification_model.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/functions/calculate_defrent_betwen_times.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/empty_widget.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PagesCubit>().getNotifications();
    context.read<PagesCubit>().newNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'الاشعارات',
          actions: KisGuest == true
              ? []
              : [
                  InkWell(
                    onTap: () {
                      showNotificationSettingBottomSheet(context);
                    },
                    child: SvgPicture.asset(
                      AppAssets.app_imagesSetting,
                    ),
                  ),
                  const SizedBox(width: 16)
                ],
        ),
        body: KisGuest == true
            ? const GuestWidget()
            : BlocBuilder<PagesCubit, PagesState>(
                builder: (context, state) {
                  switch (state.getNotificationsRequestState) {
                    case RequestState.ideal:
                    case RequestState.loading:
                      return const ShimmerNotificationList();
                    case RequestState.error:
                      return ErrorAppWidget(
                        text: state.notificationsError?.message ?? 'حدث خطا',
                        onTap: () {
                          context.read<PagesCubit>().getNotifications();
                          context.read<PagesCubit>().newNotifications();
                        },
                      );
                    case RequestState.loaded:
                      return context.read<PagesCubit>().notifications.isEmpty
                          ? const Center(
                              child: EmptyWidget(title: 'لا يوجد اشعارات '))
                          : ListView.builder(
                              itemCount: context
                                  .read<PagesCubit>()
                                  .notifications
                                  .length,
                              itemBuilder: (context, index) {
                                return NotificationCard(
                                  notification: context
                                      .read<PagesCubit>()
                                      .notifications[index],
                                  isLastItem: index ==
                                      context
                                              .read<PagesCubit>()
                                              .notifications
                                              .length -
                                          1,
                                );
                              },
                            );
                    case null:
                      return const SizedBox();
                  }
                },
                // builder: (context, state) {

                // },
              ),
      ),
    );
  }
}

Future<void> showNotificationSettingBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                // Container(
                //   padding: EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     color: AppColors.backgroundPrimary(context),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Row(
                //     children: [
                //       SvgPicture.asset(
                //         Assets.imagesReadNotification,
                //       ),
                //       SizedBox(width: 8),
                //       Text(
                //         'حدد الكل كمقروء', // Format DateTime
                //         style: AppStyles.styleRegular14(context).copyWith(
                //           color: AppColors.typographySubTitle(context),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    context.read<PagesCubit>().deleteNotifications();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundPrimary(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        BlocConsumer<PagesCubit, PagesState>(
                          listenWhen: (previous, current) =>
                              previous.deleteNotificationsRequestState !=
                              current.deleteNotificationsRequestState,
                          listener: (context, state) {
                            if (state.deleteNotificationsRequestState ==
                                RequestState.loaded) {
                              FloatingSnackBar.show(
                                context,
                                state.deleteNotificationsMessage ?? 'تم',
                                isError: false,
                              );
                              Navigator.of(context).pop();
                              print('context.pop()');
                            }
                            if (state.deleteNotificationsRequestState ==
                                RequestState.error) {
                              FloatingSnackBar.show(
                                context,
                                state.deleteNotificationsError?.message ??
                                    'حدث شئ ما خطأ',
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state.deleteNotificationsRequestState ==
                                RequestState.loading) {
                              return SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  color: AppColors.danger(context),
                                ),
                              );
                            } else {
                              return SvgPicture.asset(
                                Assets.imagesDelete,
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'حذف الكل',
                          style: AppStyles.styleSemiBold16(context).copyWith(
                            color: AppColors.danger(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final bool isLastItem;

  const NotificationCard(
      {Key? key, required this.notification, required this.isLastItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: 16, left: 16, top: 24, bottom: isLastItem ? 24 : 0),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: Color(
                          0xFFEEEEEE) /* Stroke-Border-Full-Stroke-Light */,
                    ),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
                child: SvgPicture.asset(
                  AppAssets.app_imagesNotificationcardIcon,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 220,
                    child: Text(
                      notification.title ?? 'No Title',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.typographyHeading(context)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 220,
                    child: Text(
                      notification.message ?? 'NO Desc',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: AppStyles.styleMedium16(context).copyWith(
                          color: AppColors.typographySubTitle(context)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    calculateTimeDifference(
                        notification.createdAt ?? ''), // Format DateTime
                    style: AppStyles.styleMedium12(context),
                  ),
                ],
              ),
              const Spacer(),
              const Column(
                children: [
                  // SvgPicture.asset(
                  //   Assets.imagesReadNotification,
                  //   color: AppColors.backgroundTertiary(context),
                  // ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class ShimmerNotificationList extends StatelessWidget {
  const ShimmerNotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: 5, // Simulating 5 shimmer items
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => _buildShimmerCard(context),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildShimmerCircle(40), // Icon placeholder
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(
                        height: 16, width: 200), // Title placeholder
                    const SizedBox(height: 8),
                    _buildShimmerBox(
                        height: 12, width: 150), // Date placeholder
                  ],
                ),
                const Spacer(),
                _buildShimmerCircle(24), // Read icon placeholder
              ],
            ),
            const SizedBox(height: 12),
            _buildShimmerBox(
                height: 14, width: double.infinity), // Message placeholder
            const SizedBox(height: 6),
            _buildShimmerBox(
                height: 14, width: 250), // Shorter message placeholder
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildShimmerCircle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
