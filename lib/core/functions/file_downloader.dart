import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../error/failure.dart';

// Define Failure classes

class FileDownloader {
  static Future<Either<Failure, String>> downloadFile(String url) async {
    try {
      if (url.isEmpty) {
        return Left(AppFailure(message: "لا يوجد رابط للتحميل"));
      }

      Uri uri = Uri.parse(url);
      String fileName = uri.pathSegments.last;

      // Request storage permission for Android
      if (Platform.isAndroid) {
        await Permission.storage.request();
        if (await Permission.storage.isDenied) {
          var status = await Permission.storage.request();

          if (status.isPermanentlyDenied) {
            return Left(AppFailure(
                message:
                    "تم رفض إذن التخزين بشكل دائم، يرجى تمكينه من الإعدادات"));
          }

          if (status.isDenied) {
            return Left(AppFailure(message: "تم رفض إذن التخزين"));
          }
        }

        // For Android 11+ (API 30+), request MANAGE_EXTERNAL_STORAGE
        if (Platform.isAndroid &&
            (await Permission.manageExternalStorage.isDenied)) {
          var manageStatus = await Permission.manageExternalStorage.request();

          if (manageStatus.isPermanentlyDenied) {
            return Left(AppFailure(
                message: "يجب تمكين إذن التخزين الموسع من الإعدادات"));
          }

          if (manageStatus.isDenied) {
            return Left(AppFailure(message: "تم رفض إذن التخزين الموسع"));
          }
        }
      }

      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}/$fileName";

      Dio dio = Dio();
      await dio.download(url, filePath);

      return Right('تم التحميل بنجاح ');
    } catch (e) {
      return Left(ServerFailure(message: "Error downloading file: $e"));
    }
  }
}
