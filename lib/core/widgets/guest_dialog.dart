import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../../config/routes/app_routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

OverlayEntry? _guestDialogOverlayEntry;

void showGuestDialog() {
  if (_guestDialogOverlayEntry != null) {
    // Prevent showing multiple dialogs
    return;
  }

  _guestDialogOverlayEntry = OverlayEntry(
    builder: (context) => Material(
      color: Colors.transparent,
      child: Center(
        child: AlertDialog(
          content: Text(
            'يجب عليك تسجيل الدخول اولا',
            textAlign: TextAlign.center,
            style: AppStyles.stylBold10(context),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _removeGuestDialog();
                navigatorKey.currentState?.pushNamed(Routes.splash);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.disabled(context),
              ),
              child:
                  Text('تسجيل الدخول ', style: AppStyles.stylBold10(context)),
            ),
            const SizedBox(
                height:
                    14), // Use SizedBox instead of verticalSpace for spacing
            ElevatedButton(
              onPressed: () {
                _removeGuestDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error(context),
              ),
              child: Text('الغاء', style: AppStyles.stylBold10(context)),
            ),
          ],
        ),
      ),
    ),
  );

  navigatorKey.currentState?.overlay?.insert(_guestDialogOverlayEntry!);
}

void _removeGuestDialog() {
  _guestDialogOverlayEntry?.remove();
  _guestDialogOverlayEntry = null;
}
