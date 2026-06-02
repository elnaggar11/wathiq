import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';

import 'package:wathiq/core/functions/format_number.dart';
import 'package:wathiq/core/services/pdf_service.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'تفاصيل المعاملة',
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حجز مبلغ للسوم على " أرض سكنية رقم 344 - 2435 "',
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '556,138.5+',
                        style: AppStyles.styleBold32(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 30, maxWidth: 30),
                        child: SvgPicture.asset(
                          Assets.imagesCurrencyIcon,
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white /* Background-Background-secondary */,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const TransactionDetailsCardWidget(
                          title: 'تاريخ المعاملة',
                          desc: '16, سبتمبر ,2024',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        const TransactionDetailsCardWidget(
                          title: 'الرقم المرجعي',
                          desc: '1tf324452356665',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        const TransactionDetailsCardWidget(
                          title: 'الرصيد بعد المعاملة',
                          desc: '556,138.5',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        const TransactionDetailsCardWidget(
                          title: 'تفاصيل المعاملة',
                          desc:
                              'حجز مبلغ للسوم على " أرض سكنية رقم 344 - 2435 ',
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HeldFundsDetailsScreen extends StatelessWidget {
  const HeldFundsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<WalletCubit>();
    final heldFunds = walletCubit.heldFunds;
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'تفاصيل المعاملة',
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حجز عربون على ' +
                        (heldFunds?.enrollment.auction.title ?? ''),
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        formatNumber(heldFunds?.amount ?? 0),
                        style: AppStyles.styleBold32(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 30, maxWidth: 30),
                        child: SvgPicture.asset(
                          Assets.imagesCurrencyIcon,
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white /* Background-Background-secondary */,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TransactionDetailsCardWidget(
                          title: 'تاريخ المعاملة',
                          desc:
                              DateFormat('dd, MMMM, yyyy').format(heldFunds?.createdAt.toLocal() ?? DateTime.now()),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'وقت المعاملة',
                          desc:
                              DateFormat('hh:mm a').format(heldFunds?.createdAt.toLocal() ?? DateTime.now()),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'الرقم المرجعي',
                          desc:
                              heldFunds?.enrollment.auction.id.toString() ?? '',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        // TransactionDetailsCardWidget(
                        //   title: 'الرصيد بعد المعاملة',
                        //   desc: formatNumber(heldFunds?.amount ?? 0),
                        // ),
                        // Divider(
                        //   thickness: 1,
                        //   color: AppColors.backgroundPrimary(context),
                        // ),
                        TransactionDetailsCardWidget(
                          title: 'تفاصيل المعاملة',
                          desc: 'حجز عربون على ' +
                              (heldFunds?.enrollment.auction.title ?? ''),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ElevatedButton(
                onPressed: () async {
                  if (heldFunds == null) return;
                  FloatingSnackBar.show(
                    context,
                    'جاري طباعة الفاتورة',
                    isError: false,
                  );
                  await PdfService.generateAndDownloadInvoice(
                    title: 'حجز عربون على ' +
                        (heldFunds.enrollment.auction.title ?? ''),
                    amount: formatNumber(heldFunds.amount ?? 0),
                    date: DateFormat('dd, MMMM, yyyy').format(
                        heldFunds.createdAt.toLocal() ?? DateTime.now()),
                    time: DateFormat('hh:mm a').format(
                        heldFunds.createdAt.toLocal() ?? DateTime.now()),
                    referenceNumber: heldFunds.id.toString() ?? '',
                    status: 'حجز عربون على ' +
                        (heldFunds.enrollment.auction.title ?? ''),
                    details: 'حجز عربون على ' +
                        (heldFunds.enrollment.auction.title ?? ''),
                    context: context,
                  );
                },
                child: Text(
                  'طباعة الفاتورة',
                  style: AppStyles.styleBold16(context).copyWith(
                    color: AppColors.white(context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WithdrawDetailsScreen extends StatelessWidget {
  const WithdrawDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<WalletCubit>();
    final withdrawRequest = walletCubit.withdrawRequest;
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'تفاصيل المعاملة',
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'طلب سحب رصيد',
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        formatNumber(withdrawRequest?.amount ?? 0),
                        style: AppStyles.styleBold32(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 30, maxWidth: 30),
                        child: SvgPicture.asset(
                          Assets.imagesCurrencyIcon,
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white /* Background-Background-secondary */,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TransactionDetailsCardWidget(
                          title: 'تاريخ المعاملة',
                          desc:
                              DateFormat('dd, MMMM, yyyy').format(withdrawRequest?.createdAt.toLocal() ?? DateTime.now()),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'وقت المعاملة',
                          desc:
                              DateFormat('hh:mm a').format(withdrawRequest?.createdAt.toLocal() ?? DateTime.now()),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'الرقم المرجعي',
                          desc: withdrawRequest?.id.toString() ?? '',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        // TransactionDetailsCardWidget(
                        //   title: 'الرصيد بعد المعاملة',
                        //   desc: '556,138.5',
                        // ),
                        // Divider(
                        //   thickness: 1,
                        //   color: AppColors.backgroundPrimary(context),
                        // ),
                        TransactionDetailsCardWidget(
                          title: 'تفاصيل المعاملة',
                          desc: 'طلب سحب رصيد' +
                              'بواسطة ' +
                              (withdrawRequest?.name ?? ''),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'حالة الطلب',
                          desc: (withdrawRequest?.status == 'pending'
                              ? 'قيد المعالجة'
                              : withdrawRequest?.status == 'inProgress'
                                  ? 'قيد التنفيذ'
                                  : withdrawRequest?.status == 'rejected'
                                      ? 'عملية مرفوضة'
                                      : 'تم التحويل'),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ElevatedButton(
                onPressed: () async {
                  if (withdrawRequest == null) return;
                  FloatingSnackBar.show(
                    context,
                    'جاري طباعة الفاتورة',
                    isError: false,
                  );
                  await PdfService.generateAndDownloadInvoice(
                    title: 'طلب سحب رصيد',
                    amount: formatNumber(withdrawRequest.amount ?? 0),
                    date: DateFormat('dd, MMMM, yyyy').format(
                        withdrawRequest.createdAt.toLocal() ?? DateTime.now()),
                    time: DateFormat('hh:mm a').format(
                        withdrawRequest.createdAt.toLocal() ?? DateTime.now()),
                    referenceNumber: withdrawRequest.id.toString() ?? '',
                    status: withdrawRequest.status == 'pending'
                        ? 'قيد المعالجة'
                        : withdrawRequest.status == 'inProgress'
                            ? 'قيد التنفيذ'
                            : withdrawRequest.status == 'rejected'
                                ? 'عملية مرفوضة'
                                : 'تم التحويل',
                    details:
                        'طلب سحب رصيد بواسطة ${withdrawRequest.name ?? ''}',
                    context: context,
                  );
                },
                child: Text(
                  'طباعة الفاتورة',
                  style: AppStyles.styleBold16(context).copyWith(
                    color: AppColors.white(context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<WalletCubit>();
    final invoiceRequest = walletCubit.invoiceRequest;
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'تفاصيل المعاملة',
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'طلب شحن رصيد',
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        formatNumber(invoiceRequest?.totalAmount ?? 0),
                        style: AppStyles.styleBold32(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 30, maxWidth: 30),
                        child: SvgPicture.asset(
                          Assets.imagesCurrencyIcon,
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white /* Background-Background-secondary */,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TransactionDetailsCardWidget(
                          title: 'تاريخ المعاملة',
                          desc:
                              DateFormat('dd, MMMM, yyyy').format(invoiceRequest?.issueDate.toLocal() ?? DateTime.now()),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'وقت المعاملة',
                          desc:
                              DateFormat('hh:mm a').format(invoiceRequest?.issueDate.toLocal() ?? DateTime.now()),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'الرقم المرجعي',
                          desc: invoiceRequest?.id.toString() ?? '',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'رقم الفاتورة',
                          desc: invoiceRequest?.invoiceNo.toString() ?? '',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        TransactionDetailsCardWidget(
                          title: 'رقم السند/الإيصال	',
                          desc: invoiceRequest?.billNo.toString() ?? '',
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.backgroundPrimary(context),
                        ),
                        // TransactionDetailsCardWidget(
                        //   title: 'الرصيد بعد المعاملة',
                        //   desc: '556,138.5',
                        // ),
                        // Divider(
                        //   thickness: 1,
                        //   color: AppColors.backgroundPrimary(context),
                        // ),

                        TransactionDetailsCardWidget(
                          title: 'حالة الطلب',
                          desc: (invoiceRequest?.status == 'Pending'
                              ? 'معلقة'
                              : invoiceRequest?.status == 'Confirmed'
                                  ? 'تم التصديق علي الفاتورة'
                                  : invoiceRequest?.status == 'Failed'
                                      ? 'فشلت العملية'
                                      : 'عملية ناجحة'),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ElevatedButton(
                onPressed: () async {
                  if (invoiceRequest == null) return;
                  FloatingSnackBar.show(
                    context,
                    'جاري طباعة الفاتورة',
                    isError: false,
                  );
                  await PdfService.generateAndDownloadInvoice(
                    title: 'طلب شحن رصيد',
                    amount: formatNumber(invoiceRequest.totalAmount ?? 0),
                    date: DateFormat('dd, MMMM, yyyy').format(
                        invoiceRequest.issueDate.toLocal() ?? DateTime.now()),
                    time: DateFormat('hh:mm a').format(
                        invoiceRequest.issueDate.toLocal() ?? DateTime.now()),
                    referenceNumber: invoiceRequest.id.toString() ?? '',
                    status: invoiceRequest.status == 'Pending'
                        ? 'معلقة'
                        : invoiceRequest.status == 'Confirmed'
                            ? 'تم التصديق علي الفاتورة'
                            : invoiceRequest.status == 'Failed'
                                ? 'فشلت العملية'
                                : 'عملية ناجحة',
                    details: 'طلب شحن رصيد',
                    invoiceNo: invoiceRequest.invoiceNo.toString() ?? '',
                    billNo: invoiceRequest.billNo.toString() ?? '',
                    context: context,
                  );
                },
                child: Text(
                  'طباعة الفاتورة',
                  style: AppStyles.styleBold16(context).copyWith(
                    color: AppColors.white(context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionDetailsCardWidget extends StatelessWidget {
  const TransactionDetailsCardWidget({
    super.key,
    required this.title,
    required this.desc,
  });
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.styleBold14(context).copyWith(
              color: AppColors.typographySubTitle(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.typographyHeading(context),
            ),
          ),
        ],
      ),
    );
  }
}

class IntroTrunsactonDetailsScreenWidget extends StatelessWidget {
  const IntroTrunsactonDetailsScreenWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.app_imagesActiveSvg,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
                      child: SvgPicture.asset(Assets.imagesArrowLeftLong),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.white(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
