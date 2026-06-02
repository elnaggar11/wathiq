import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:open_file/open_file.dart' as file;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../error/failure.dart';
import '../widgets/my_snackbar.dart';

Future<void> openLink(String? url) async {
  if (url == null) return;

  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> callPhoneNumber(String? phoneNumber) async {
  if (phoneNumber == null) return;

  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not call $phoneNumber';
  }
}

Future<void> openEmail({required String? email}) async {
  if (email == null) return;
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    // query: [
    //   if (subject != null) 'subject=${Uri.encodeComponent(subject)}',
    //   if (body != null) 'body=${Uri.encodeComponent(body)}',
    // ].join('&'),
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not open email client for $email';
  }
}

String getFileNameFromUrl(String url) {
  return url.split('/').last;
}

Future<Either<Failure, String>> downloadFile(
  String url,
  BuildContext context,
) async {
  if (url.isEmpty) {
    return Left(AppFailure(message: "الرابط فارغ"));
  }

  // ✅ اطلب صلاحية التخزين
  if (!await Permission.manageExternalStorage.request().isGranted) {
    return Left(AppFailure(message: "تم رفض صلاحية التخزين"));
  }

  Dio dio = Dio();

  try {
    String fileName = getFileNameFromUrl(url);
    String filePath = "/storage/emulated/0/Download/$fileName";

    await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          double progress = (received / total) * 100;
          debugPrint("Download Progress: ${progress.toStringAsFixed(2)}%");
          FloatingSnackBar.show(
            context,
            "جاري التحميل",
            progress: progress,
            isError: false,
          );
        }
      },
    );

    // ✅ media scan عشان الملف يظهر في تطبيق الملفات
    await MediaScanner.loadMedia(path: filePath);

    // ✅ افتح الملف بعد التنزيل
    final result = await file.OpenFile.open(filePath);

    if (result.type == file.ResultType.done) {
      return Right("تم فتح الملف: $filePath");
    } else {
      return Left(AppFailure(message: "فشل في فتح الملف: ${result.message}"));
    }
  } catch (e) {
    return Left(AppFailure(message: "فشل التحميل: $e"));
  }
}
