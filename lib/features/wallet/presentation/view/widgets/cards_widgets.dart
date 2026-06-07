import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/functions/format_number.dart';
import 'package:wathiq/features/wallet/data/model/held_model.dart';
import 'package:wathiq/features/wallet/data/model/invoice_model.dart';
import 'package:wathiq/features/wallet/data/model/withdraw_model.dart';
import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

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
          color: const Color(0xffF9F9F9), // Light background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  formatNumber(heldFunds.data[index].amount),
                  style: AppStyles.styleBold16(context).copyWith(
                    color: AppColors.typographyHeading(context),
                  ),
                ),
                const SizedBox(width: 4),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 17, maxWidth: 16),
                  child: SvgPicture.asset(
                    Assets.imagesCurrencyIcon,
                    color: AppColors.typographyHeading(context),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حجز مبلغ للسوم على "${heldFunds.data[index].enrollment.auction.title}"',
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.styleBold14(context).copyWith(
                      color: AppColors.typographyHeading(context),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    DateFormat('dd, MMMM, yyyy EEEE hh:mm a', 'ar').format(
                      heldFunds.data[index].createdAt.toLocal(),
                    ),
                    textAlign: TextAlign.end,
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: AppColors.iconsTertiary(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SvgPicture.asset(AppAssets.app_imagesHeldFundes),
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
          color: const Color(0xffF9F9F9), // Light background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: withdraw.data[index].status == 'pending'
                        ? const Color(0xFFF0F2F5) // Grey
                        : withdraw.data[index].status == 'inProgress'
                            ? const Color(0x19BD7611) // Light Orange
                            : withdraw.data[index].status == 'rejected'
                                ? const Color(0x19D32F2F) // Light Red
                                : const Color(0x190E8340), // Light Green
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)), // Capsule
                  ),
                  child: Text(
                    withdraw.data[index].status == 'pending'
                        ? 'تم إرسال الطلب'
                        : withdraw.data[index].status == 'inProgress'
                            ? 'تحت الإجراء'
                            : withdraw.data[index].status == 'rejected'
                                ? 'مرفوضة'
                                : 'عملية ناجحة',
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: withdraw.data[index].status == 'pending'
                          ? const Color(0xFF707A89) // Grey Text
                          : withdraw.data[index].status == 'inProgress'
                              ? const Color(0xFFBD7611)
                              : withdraw.data[index].status == 'rejected'
                                  ? const Color(0xFFD32F2F)
                                  : const Color(0xFF0E8340),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      formatNumber(withdraw.data[index].amount),
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                    const SizedBox(width: 4),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 17, maxWidth: 16),
                      child: SvgPicture.asset(
                        Assets.imagesCurrencyIcon,
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'سحب رصيد',
                    textAlign: TextAlign.end,
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    DateFormat('dd, MMMM, yyyy EEEE hh:mm a', 'ar').format(
                      withdraw.data[index].createdAt.toLocal(),
                    ),
                    textAlign: TextAlign.end,
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: AppColors.iconsTertiary(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SvgPicture.asset(
                AppAssets.app_imagesWithdr,
                color: const Color(0xFFE54A4A), // Red icon
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
          color: const Color(0xffF9F9F9), // Light background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: invoice.data[index].status == 'Pending'
                        ? const Color(0xFFF0F2F5)
                        : invoice.data[index].status == 'Confirmed'
                            ? const Color(0x190E8340) // Light Green
                            : invoice.data[index].status == 'Failed'
                                ? const Color(0x19D32F2F) // Light Red
                                : const Color(0x190E8340),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    invoice.data[index].status == 'Pending'
                        ? 'معلقة'
                        : invoice.data[index].status == 'Confirmed'
                            ? 'عملية ناجحة'
                            : invoice.data[index].status == 'Failed'
                                ? 'مرفوضة'
                                : 'عملية ناجحة',
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: invoice.data[index].status == 'Pending'
                          ? const Color(0xFF707A89)
                          : invoice.data[index].status == 'Confirmed'
                              ? const Color(0xFF0E8340) // Green
                              : invoice.data[index].status == 'Failed'
                                  ? const Color(0xFFD32F2F) // Red
                                  : const Color(0xFF0E8340),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      formatNumber(invoice.data[index].totalAmount),
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                    const SizedBox(width: 4),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 17, maxWidth: 16),
                      child: SvgPicture.asset(
                        Assets.imagesCurrencyIcon,
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'شحن رصيد',
                    textAlign: TextAlign.end,
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    DateFormat('dd, MMMM, yyyy EEEE hh:mm a', 'ar').format(
                      invoice.data[index].issueDate.toLocal(),
                    ),
                    textAlign: TextAlign.end,
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: AppColors.iconsTertiary(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SvgPicture.asset(
                AppAssets.app_imagesAddmony,
                color: const Color(0xFF38A169), // Green icon
              ),
            ),
          ],
        ),
      ),
    );
  }
}
