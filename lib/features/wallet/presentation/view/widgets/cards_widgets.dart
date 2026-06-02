import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../data/model/held_model.dart';
import '../../../data/model/invoice_model.dart';
import '../../../data/model/withdraw_model.dart';
import '../../view_model/wallet/wallet_cubit.dart';

class HeldFundsCardWidget extends StatelessWidget {
  const HeldFundsCardWidget({
    super.key,
    required this.heldFunds,
    required this.index,
  });
  final HeldModel heldFunds;
  final int index;

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<WalletCubit>();
    return GestureDetector(
      onTap: () {
        walletCubit.heldFunds = heldFunds.data[index];
        context.navigateTo(Routes.HeldFundsDetailsScreen);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: ShapeDecoration(
          color: Color(0xffF8F8F8) /* [-Tokens-]-_Background-secondary */,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              color:
                  const Color(0xFFEBEEF3) /* [-Tokens-]-_Separating-Border */,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.app_imagesHeldFundes),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 210,
                      child: Text(
                        'حجز عربون ' +
                            heldFunds.data[index].enrollment.auction.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.styleBold14(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          formatNumber(heldFunds.data[index].amount),
                          style: AppStyles.styleBold14(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 17, maxWidth: 16),
                          child: SvgPicture.asset(
                            Assets.imagesCurrencyIcon,
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  DateFormat('dd, MMMM, yyyy').format(
                    heldFunds.data[index].createdAt.toLocal(),
                  ),
                  style: AppStyles.styleMedium14(context).copyWith(
                    color: AppColors.typographyHeading(context),
                  ),
                ),
                // SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'الرصيد بعد المعاملة:',
                    //   style: AppStyles.styleMedium14(context).copyWith(
                    //     color: AppColors.typographySubTitle(context),
                    //   ),
                    // ),
                    // Text(
                    //   ' 556,138.5 ',
                    //   style: AppStyles.styleBold14(context).copyWith(
                    //     color: AppColors.typographyHeading(context),
                    //   ),
                    // ),
                    // ConstrainedBox(
                    //   constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
                    //   child: SvgPicture.asset(
                    //     Assets.imagesCurrencyIcon,
                    //     color: AppColors.typographyHeading(context),
                    //   ),
                    // ),
                    // Spacer(),
                    // Text(
                    //   'الإيصال',
                    //   style: AppStyles.styleBold14(context).copyWith(
                    //     color: AppColors.typographyHeading(context),
                    //   ),
                    // ),
                    // SizedBox(width: 6),
                    // ConstrainedBox(
                    //   constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
                    //   child: Image.asset(
                    //     Assets.imagesFile,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class InvoiceCardWidget extends StatelessWidget {
//   const InvoiceCardWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.navigateTo(Routes.TransactionDetailsScreen);
//       },
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//         margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
//         decoration: ShapeDecoration(
//           color: Color(0xffF8F8F8) /* [-Tokens-]-_Background-secondary */,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               width: 0,
//               color:
//                   const Color(0xFFEBEEF3) /* [-Tokens-]-_Separating-Border */,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'سحب رصيد',
//                   style: AppStyles.styleBold14(context).copyWith(
//                     color: AppColors.typographyHeading(context),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '-1,200.00 ',
//                       style: AppStyles.styleBold14(context).copyWith(
//                         color: AppColors.danger(context),
//                       ),
//                     ),
//                     ConstrainedBox(
//                       constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
//                       child: SvgPicture.asset(
//                         Assets.imagesCurrencyIcon,
//                         color: AppColors.danger(context),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 6),
//             Text(
//               '16, سبتمبر ,2024',
//               style: AppStyles.styleMedium14(context).copyWith(
//                 color: AppColors.iconsTertiary(context),
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'الرصيد بعد المعاملة:',
//                   style: AppStyles.styleMedium14(context).copyWith(
//                     color: AppColors.typographySubTitle(context),
//                   ),
//                 ),
//                 Text(
//                   ' 556,138.5 ',
//                   style: AppStyles.styleBold14(context).copyWith(
//                     color: AppColors.typographyHeading(context),
//                   ),
//                 ),
//                 ConstrainedBox(
//                   constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
//                   child: SvgPicture.asset(
//                     Assets.imagesCurrencyIcon,
//                     color: AppColors.typographyHeading(context),
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   'الإيصال',
//                   style: AppStyles.styleBold14(context).copyWith(
//                     color: AppColors.typographyHeading(context),
//                   ),
//                 ),
//                 SizedBox(width: 6),
//                 ConstrainedBox(
//                   constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
//                   child: Image.asset(
//                     Assets.imagesFile,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// handel withdraw card
class WithdrawCardWidget extends StatelessWidget {
  const WithdrawCardWidget({
    super.key,
    required this.withdraw,
    required this.index,
  });
  final WithdrawModel withdraw;
  final int index;

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<WalletCubit>();
    return GestureDetector(
      onTap: () {
        walletCubit.withdrawRequest = withdraw.data[index];
        context.navigateTo(Routes.WithdrawDetailsScreen);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: ShapeDecoration(
          color: Color(0xffF8F8F8) /* [-Tokens-]-_Background-secondary */,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              color:
                  const Color(0xFFEBEEF3) /* [-Tokens-]-_Separating-Border */,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: SvgPicture.asset(AppAssets.app_imagesWithdr),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سحب رصيد',
                        style: AppStyles.styleBold14(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          // colors for contaner but with opacity 0.05 =>  pending = #202726  inProgress = #BD7611  rejected = #D32F2F  approved = #0E8340
                          color: withdraw.data[index].status == 'pending'
                              ? const Color(0x0C202726)
                              : withdraw.data[index].status == 'inProgress'
                                  ? const Color(0x0CBD7611)
                                  : withdraw.data[index].status == 'rejected'
                                      ? const Color(0x0CD32F2F)
                                      : const Color(0x0C0E8340),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          withdraw.data[index].status == 'pending'
                              ? 'تم إرسال الطلب'
                              : withdraw.data[index].status == 'inProgress'
                                  ? 'قيد التنفيذ'
                                  : withdraw.data[index].status == 'rejected'
                                      ? 'عملية مرفوضة'
                                      : 'تم التحويل',
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: withdraw.data[index].status == 'pending'
                                ? const Color(0xFF202726)
                                : withdraw.data[index].status == 'inProgress'
                                    ? const Color(0xFFBD7611)
                                    : withdraw.data[index].status == 'rejected'
                                        ? const Color(0xFFD32F2F)
                                        : const Color(0xFF0E8340),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat(' dd, MMMM, yyyy ').format(
                              withdraw.data[index].createdAt.toLocal(),
                            ),
                            style: AppStyles.styleMedium14(context).copyWith(
                              color: AppColors.iconsTertiary(context),
                            ),
                          ),
                          Text(
                            DateFormat(' hh:mm a ').format(
                              withdraw.data[index].createdAt.toLocal(),
                            ),
                            style: AppStyles.styleMedium14(context).copyWith(
                              color: AppColors.iconsTertiary(context),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            ' - ' + formatNumber(withdraw.data[index].amount),
                            style: AppStyles.styleBold14(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxHeight: 17, maxWidth: 16),
                            child: SvgPicture.asset(
                              Assets.imagesCurrencyIcon,
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(height: 16),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'الرصيد بعد المعاملة:',
                  //       style: AppStyles.styleMedium14(context).copyWith(
                  //         color: AppColors.typographySubTitle(context),
                  //       ),
                  //     ),
                  //     Text(
                  //       ' 556,138.5 ',
                  //       style: AppStyles.styleBold14(context).copyWith(
                  //         color: AppColors.typographyHeading(context),
                  //       ),
                  //     ),
                  //     ConstrainedBox(
                  //       constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
                  //       child: SvgPicture.asset(
                  //         Assets.imagesCurrencyIcon,
                  //         color: AppColors.typographyHeading(context),
                  //       ),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       'الإيصال',
                  //       style: AppStyles.styleBold14(context).copyWith(
                  //         color: AppColors.typographyHeading(context),
                  //       ),
                  //     ),
                  //     SizedBox(width: 6),
                  //     ConstrainedBox(
                  //       constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
                  //       child: Image.asset(
                  //         Assets.imagesFile,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceCardWidget extends StatelessWidget {
  const InvoiceCardWidget({
    super.key,
    required this.invoice,
    required this.index,
  });
  final InvoiceModel invoice;
  final int index;

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<WalletCubit>();
    return GestureDetector(
      onTap: () {
        walletCubit.invoiceRequest = invoice.data[index];
        context.navigateTo(Routes.InvoiceDetailsScreen);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: ShapeDecoration(
          color: Color(0xffF8F8F8) /* [-Tokens-]-_Background-secondary */,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              color:
                  const Color(0xFFEBEEF3) /* [-Tokens-]-_Separating-Border */,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: SvgPicture.asset(AppAssets.app_imagesAddmony),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'شحن رصيد',
                        style: AppStyles.styleBold14(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: invoice.data[index].status == 'Pending'
                              ? const Color(0x0C202726)
                              : invoice.data[index].status == 'Confirmed'
                                  ? const Color(0x0CBD7611)
                                  : invoice.data[index].status == 'Failed'
                                      ? const Color(0x0CD32F2F)
                                      : const Color(0x0C0E8340),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          invoice.data[index].status == 'Pending'
                              ? 'معلقة'
                              : invoice.data[index].status == 'Confirmed'
                                  ? 'تم التصديق علي الفاتورة'
                                  : invoice.data[index].status == 'Failed'
                                      ? 'فشلت العملية'
                                      : 'عملية ناجحة',
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: invoice.data[index].status == 'Pending'
                                ? const Color(0xFF202726)
                                : invoice.data[index].status == 'Confirmed'
                                    ? const Color(0xFFBD7611)
                                    : invoice.data[index].status == 'Failed'
                                        ? const Color(0xFFD32F2F)
                                        : const Color(0xFF0E8340),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat(' dd, MMMM, yyyy ').format(
                              invoice.data[index].issueDate.toLocal(),
                            ),
                            style: AppStyles.styleMedium14(context).copyWith(
                              color: AppColors.iconsTertiary(context),
                            ),
                          ),
                          Text(
                            DateFormat(' hh:mm a ').format(
                              invoice.data[index].issueDate.toLocal(),
                            ),
                            style: AppStyles.styleMedium14(context).copyWith(
                              color: AppColors.iconsTertiary(context),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            formatNumber(invoice.data[index].totalAmount),
                            style: AppStyles.styleBold14(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxHeight: 17, maxWidth: 16),
                            child: SvgPicture.asset(
                              Assets.imagesCurrencyIcon,
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(height: 16),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'الرصيد بعد المعاملة:',
                  //       style: AppStyles.styleMedium14(context).copyWith(
                  //         color: AppColors.typographySubTitle(context),
                  //       ),
                  //     ),
                  //     Text(
                  //       ' 556,138.5 ',
                  //       style: AppStyles.styleBold14(context).copyWith(
                  //         color: AppColors.typographyHeading(context),
                  //       ),
                  //     ),
                  //     ConstrainedBox(
                  //       constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
                  //       child: SvgPicture.asset(
                  //         Assets.imagesCurrencyIcon,
                  //         color: AppColors.typographyHeading(context),
                  //       ),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       'الإيصال',
                  //       style: AppStyles.styleBold14(context).copyWith(
                  //         color: AppColors.typographyHeading(context),
                  //       ),
                  //     ),
                  //     SizedBox(width: 6),
                  //     ConstrainedBox(
                  //       constraints: BoxConstraints(maxHeight: 17, maxWidth: 16),
                  //       child: Image.asset(
                  //         Assets.imagesFile,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
