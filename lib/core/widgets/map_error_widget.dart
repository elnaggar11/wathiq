import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

enum MapErrorType {
  noLocation, // لا يوجد موقع متاح
  apiKeyError, // مشكلة في مفتاح API
  networkError, // مشكلة في الشبكة
  permissionError, // مشكلة في الصلاحيات
  generalError, // خطأ عام
}

class MapErrorWidget extends StatelessWidget {
  const MapErrorWidget({
    super.key,
    required this.errorType,
    this.errorMessage,
    this.onRetry,
    this.onOpenSettings,
  });

  final MapErrorType errorType;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimary(context),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildErrorIcon(context),
              SizedBox(height: 24),
              _buildErrorTitle(context),
              SizedBox(height: 8),
              _buildErrorDescription(context),
              SizedBox(height: 32),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorIcon(BuildContext context) {
    IconData iconData;
    double iconSize = 64;

    switch (errorType) {
      case MapErrorType.noLocation:
        iconData = Icons.location_off;
        break;
      case MapErrorType.apiKeyError:
        iconData = Icons.key_off;
        break;
      case MapErrorType.networkError:
        iconData = Icons.wifi_off;
        break;
      case MapErrorType.permissionError:
        iconData = Icons.location_disabled;
        break;
      case MapErrorType.generalError:
        iconData = Icons.error_outline;
        break;
    }

    return Icon(
      iconData,
      size: iconSize,
      color: AppColors.typographySubTitle(context),
    );
  }

  Widget _buildErrorTitle(BuildContext context) {
    String title;

    switch (errorType) {
      case MapErrorType.noLocation:
        title = 'لا يوجد موقع متاح';
        break;
      case MapErrorType.apiKeyError:
        title = 'مشكلة في مفتاح الخرائط';
        break;
      case MapErrorType.networkError:
        title = 'مشكلة في الاتصال بالإنترنت';
        break;
      case MapErrorType.permissionError:
        title = 'مشكلة في صلاحيات الموقع';
        break;
      case MapErrorType.generalError:
        title = 'حدث خطأ في تحميل الخريطة';
        break;
    }

    return Text(
      title,
      textAlign: TextAlign.center,
      style: AppStyles.styleBold18(context).copyWith(
        color: AppColors.typographyHeading(context),
      ),
    );
  }

  Widget _buildErrorDescription(BuildContext context) {
    String description;

    switch (errorType) {
      case MapErrorType.noLocation:
        description =
            'لم يتم تحديد موقع لهذا الأصل. يرجى التواصل مع إدارة المزاد للحصول على معلومات الموقع.';
        break;
      case MapErrorType.apiKeyError:
        description =
            'حدث خطأ في مفتاح خرائط جوجل. يرجى إعادة المحاولة أو التواصل مع الدعم الفني.';
        break;
      case MapErrorType.networkError:
        description = 'تأكد من اتصالك بالإنترنت وأعد المحاولة لتحميل الخريطة.';
        break;
      case MapErrorType.permissionError:
        description =
            'يحتاج التطبيق إلى صلاحيات الموقع لعرض موقعك الحالي على الخريطة.';
        break;
      case MapErrorType.generalError:
        description = errorMessage ??
            'حدث خطأ غير متوقع في تحميل الخريطة. يرجى إعادة المحاولة.';
        break;
    }

    return Text(
      description,
      textAlign: TextAlign.center,
      style: AppStyles.styleMedium14(context).copyWith(
        color: AppColors.typographySubTitle(context),
        height: 1.5,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    switch (errorType) {
      case MapErrorType.noLocation:
        return _buildNoLocationActions(context);
      case MapErrorType.apiKeyError:
        return _buildApiKeyErrorActions(context);
      case MapErrorType.networkError:
        return _buildNetworkErrorActions(context);
      case MapErrorType.permissionError:
        return _buildPermissionErrorActions(context);
      case MapErrorType.generalError:
        return _buildGeneralErrorActions(context);
    }
  }

  Widget _buildNoLocationActions(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: () {
            // إغلاق الشيت
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: AppColors.primary(context)),
          label: Text(
            'إغلاق',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.primary(context),
            ),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: Size(200, 48),
            side: BorderSide(color: AppColors.primary(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApiKeyErrorActions(BuildContext context) {
    return Column(
      children: [
        if (onRetry != null)
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh, color: Colors.white),
            label: Text(
              'إعادة المحاولة',
              style: AppStyles.styleBold16(context).copyWith(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 48),
              backgroundColor: AppColors.primary(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: AppColors.primary(context)),
          label: Text(
            'إغلاق',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.primary(context),
            ),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: Size(200, 48),
            side: BorderSide(color: AppColors.primary(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkErrorActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: Icon(Icons.refresh, color: Colors.white),
          label: Text(
            'إعادة المحاولة',
            style: AppStyles.styleBold16(context).copyWith(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(200, 48),
            backgroundColor: AppColors.primary(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: AppColors.primary(context)),
          label: Text(
            'إغلاق',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.primary(context),
            ),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: Size(200, 48),
            side: BorderSide(color: AppColors.primary(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionErrorActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onOpenSettings,
          icon: Icon(Icons.settings, color: Colors.white),
          label: Text(
            'فتح الإعدادات',
            style: AppStyles.styleBold16(context).copyWith(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(200, 48),
            backgroundColor: AppColors.primary(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onRetry,
          icon: Icon(Icons.refresh, color: AppColors.primary(context)),
          label: Text(
            'إعادة المحاولة',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.primary(context),
            ),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: Size(200, 48),
            side: BorderSide(color: AppColors.primary(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: AppColors.primary(context)),
          label: Text(
            'إغلاق',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.primary(context),
            ),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: Size(200, 48),
            side: BorderSide(color: AppColors.primary(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralErrorActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: Icon(Icons.refresh, color: Colors.white),
          label: Text(
            'إعادة المحاولة',
            style: AppStyles.styleBold16(context).copyWith(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(200, 48),
            backgroundColor: AppColors.primary(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: AppColors.primary(context)),
          label: Text(
            'إغلاق',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.primary(context),
            ),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: Size(200, 48),
            side: BorderSide(color: AppColors.primary(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
