// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sirtz/core/utils/media_query_values.dart';

// import '../../../../../core/utils/app_assets.dart';
// import '../../view_model/layout_cubit.dart';

// class HomeBottomNavBarWidget extends StatefulWidget {
//   const HomeBottomNavBarWidget({super.key});

//   @override
//   State<HomeBottomNavBarWidget> createState() => _HomeBottomNavBarWidgetState();
// }

// class _HomeBottomNavBarWidgetState extends State<HomeBottomNavBarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadiusDirectional.only(
//         topEnd: Radius.circular(20.r),
//         topStart: Radius.circular(20.r),
//       ),
//       color: Theme.of(context).canvasColor,
//       clipBehavior: Clip.antiAlias,
//       elevation: 50,
//       child: SizedBox(
//         height: 60.h,
//         // decoration: const BoxDecoration(

//         //   color: Theme.of(context).canvasColor,
//         //   borderRadius: BorderRadiusDirectional.only(
//         //     topEnd: Radius.circular(20.r),
//         //     topStart: Radius.circular(20.r),
//         //   ),
//         // ),
//         child: BlocBuilder<LayoutCubit, LayoutState>(
//           // buildWhen: (previous, current) {
//           //   if (previous is ChangeBottomNavBar &&
//           //       current is ChangeBottomNavBar) {
//           //     return previous.currentIndex != current.currentIndex;
//           //   }
//           //   return false;
//           // },
//           builder: (context, state) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Column(
//                   children: [
//                     BottomNavBarGradientItemWidget(
//                       show: context.read<LayoutCubit>().currentIndex == 0,
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       enableFeedback: false,
//                       onPressed: () {
//                         context.read<LayoutCubit>().changeCurrentIndex(0);
//                         // setState(() {
//                         //   currentIndex = 0;
//                         // });
//                       },
//                       icon: SvgPicture.asset(
//                         AppSvgAssets.homeIcon,
//                         color: context.read<LayoutCubit>().currentIndex == 0
//                             ? context.theme.primaryColor
//                             : context.theme.hintColor.withOpacity(.5),
//                         height: 26.h,
//                         width: 26.w,
//                       ),
//                     ),
//                     const Spacer(flex: 2),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     BottomNavBarGradientItemWidget(
//                       show: context.read<LayoutCubit>().currentIndex == 1,
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       enableFeedback: false,
//                       onPressed: () {
//                         context.read<LayoutCubit>().changeCurrentIndex(1);
//                         // context.navigateTo(Routes.notificationRoute);
//                       },
//                       icon: SvgPicture.asset(
//                         AppSvgAssets.notification,
//                         color: context.read<LayoutCubit>().currentIndex == 1
//                             ? context.theme.primaryColor
//                             : context.theme.hintColor.withOpacity(.5),
//                         height: 30.h,
//                         width: 30.w,
//                       ),
//                     ),
//                     const Spacer(flex: 2),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     BottomNavBarGradientItemWidget(
//                       show: context.read<LayoutCubit>().currentIndex == 2,
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       enableFeedback: false,
//                       onPressed: () {
//                         context.read<LayoutCubit>().changeCurrentIndex(2);
//                         // context.navigateTo(Routes.profileRoute);
//                       },
//                       icon: SvgPicture.asset(
//                         AppSvgAssets.chatSolid,
//                         // color: Colors.white,
//                         color: context.read<LayoutCubit>().currentIndex == 2
//                             ? context.theme.primaryColor
//                             : context.theme.hintColor.withOpacity(.5),
//                         height: 30.h,
//                         width: 30.w,
//                       ),
//                     ),
//                     const Spacer(flex: 2),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// ///

// class BottomNavBarGradientItemWidget extends StatelessWidget {
//   const BottomNavBarGradientItemWidget({super.key, required this.show});
//   final bool show;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedCrossFade(
//       firstChild: Column(
//         children: [
//           Container(
//             width: 1.sw / 9,
//             height: 4.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16.r),
//               gradient: const RadialGradient(
//                 center: Alignment(-0, 0.50),
//                 radius: 10,
//                 colors: [
//                   Color(0xFF01729A),
//                   Color(0x0001729A),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       secondChild: const SizedBox.shrink(),
//       crossFadeState:
//           show ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//       duration: const Duration(milliseconds: 250),
//     );
//   }
// }
