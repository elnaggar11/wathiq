import 'package:flutter/material.dart';
import 'package:wathiq/core/utils/app_colors.dart';

void mySnackBar(String message, BuildContext ctx, {bool isError = true}) {
  OverlayState overlayState = Overlay.of(ctx);
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isError ? AppColors.danger(ctx) : Colors.green,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0.1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isError ? Icons.error : Icons.check_circle,
                    color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}

class FloatingSnackBar {
  static void show(
    BuildContext context,
    String message, {
    bool isError = true,
    double? progress,
  }) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.05, // Adjust height
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isError ? AppColors.danger(context) : Colors.green,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12, // Softer shadow color
                    blurRadius: 2, // Slight blur for a subtle effect
                    spreadRadius: 0.1, // Minimal spread
                    offset: Offset(0, 1), // Light bottom shadow for depth
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isError ? Icons.error : Icons.check_circle,
                          color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          message,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  if (progress != null) ...[
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${progress.toStringAsFixed(1)}%',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Insert Overlay
    overlayState.insert(overlayEntry);

    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
