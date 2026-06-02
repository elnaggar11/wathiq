import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:media_scanner/media_scanner.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../widgets/my_snackbar.dart';

class PdfService {
  static Future<void> generateAndDownloadInvoice({
    required String title,
    String? invoiceNo,
    String? billNo,
    required String amount,
    required String date,
    required String time,
    required String referenceNumber,
    String? status,
    String? details,
    required BuildContext context,
  }) async {
    // طلب صلاحية التخزين
    if (!await Permission.manageExternalStorage.request().isGranted) {
      FloatingSnackBar.show(
        context,
        "تم رفض صلاحية التخزين",
        isError: true,
      );
      return;
    }

    try {
      // تحميل الخط العربي
      final arabicFont =
          await rootBundle.load("assets/fonts/LamaSans-Regular.ttf");
      final ttf = pw.Font.ttf(arabicFont);

      // إنشاء مستند PDF
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: ttf,
          ),
          build: (pw.Context context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(height: 40),
                  pw.Text(
                    'فاتورة وثيق المزادات',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  _buildInvoiceItem(ttf, 'العنوان', title),
                  _buildInvoiceItem(ttf, 'المبلغ', amount),
                  _buildInvoiceItem(ttf, 'التاريخ', date),
                  _buildInvoiceItem(ttf, 'الوقت', time),
                  _buildInvoiceItem(ttf, 'الرقم المرجعي', referenceNumber),
                  if (status != null) _buildInvoiceItem(ttf, 'الحالة', status),
                  if (details != null)
                    _buildInvoiceItem(ttf, 'التفاصيل', details),
                  if (invoiceNo != null)
                    _buildInvoiceItem(ttf, 'رقم الفاتورة', invoiceNo),
                  if (billNo != null)
                    _buildInvoiceItem(ttf, ' رقم السند/الإيصال	', billNo),
                ],
              ),
            );
          },
        ),
      );

      // حفظ الملف في مجلد التنزيلات
      String fileName = "invoice_${DateTime.now().millisecondsSinceEpoch}.pdf";
      String filePath = "/storage/emulated/0/Download/$fileName";

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // مسح الملف في معرض الملفات
      await MediaScanner.loadMedia(path: filePath);

      // فتح الملف بعد التنزيل
      final result = await OpenFile.open(filePath);

      if (result.type == ResultType.done) {
        FloatingSnackBar.show(
          context,
          "تم حفظ الفاتورة بنجاح",
          isError: false,
        );
      } else {
        FloatingSnackBar.show(
          context,
          "فشل في فتح الملف: ${result.message}",
          isError: true,
        );
      }
    } catch (e) {
      FloatingSnackBar.show(
        context,
        "فشل في إنشاء الفاتورة: $e",
        isError: true,
      );
    }
  }

  static pw.Widget _buildInvoiceItem(pw.Font font, String label, String value) {
    return pw.Container(
      width: double.infinity,
      padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
        ),
      ),
      child: pw.Text(
        '$label: $value',
        style: pw.TextStyle(
          font: font,
          fontSize: 18,
        ),
      ),
    );
  }
}
