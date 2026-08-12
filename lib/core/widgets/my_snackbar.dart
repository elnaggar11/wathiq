import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wathiq/core/utils/app_colors.dart';

void mySnackBar(String message, BuildContext ctx, {bool isError = true}) {
  OverlayState overlayState = Overlay.of(ctx);
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: -50, end: 0),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: AnimatedOpacity(
                opacity: value == -50 ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: child,
              ),
            );
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isError ? AppColors.danger(ctx) : AppColors.success(ctx),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isError
                        ? Icons.error_outline_rounded
                        : Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontFamily: 'Lama Sans',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
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
  static OverlayEntry? _currentOverlay;
  static ValueNotifier<double?>? _progressNotifier;
  static ValueNotifier<String>? _messageNotifier;
  static Timer? _dismissTimer;

  static void dismiss() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    if (_currentOverlay != null) {
      try {
        _currentOverlay?.remove();
      } catch (_) {}
      _currentOverlay = null;
      _progressNotifier = null;
      _messageNotifier = null;
    }
  }

  static void show(
    BuildContext context,
    String message, {
    bool isError = true,
    double? progress,
  }) {
    // If we already have an active progress overlay, update it in-place
    if (progress != null &&
        _currentOverlay != null &&
        _progressNotifier != null &&
        _messageNotifier != null) {
      _dismissTimer?.cancel();
      _messageNotifier!.value = message;
      _progressNotifier!.value = progress;

      _dismissTimer = Timer(const Duration(seconds: 3), () {
        dismiss();
      });
      return;
    }

    // Dismiss any existing overlay before showing a new one
    dismiss();

    _progressNotifier = ValueNotifier<double?>(progress);
    _messageNotifier = ValueNotifier<String>(message);

    final progressNotifier = _progressNotifier!;
    final messageNotifier = _messageNotifier!;

    _currentOverlay = OverlayEntry(
      builder: (ctx) => Positioned(
        top: MediaQuery.of(ctx).size.height * 0.05,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: -50, end: 0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: AnimatedOpacity(
                  opacity: value == -50 ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: child,
                ),
              );
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ValueListenableBuilder<String>(
                valueListenable: messageNotifier,
                builder: (context, currentMessage, _) {
                  return ValueListenableBuilder<double?>(
                    valueListenable: progressNotifier,
                    builder: (context, currentProgress, _) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: isError
                              ? AppColors.danger(context)
                              : AppColors.success(context),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 20,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isError
                                      ? Icons.error_outline_rounded
                                      : Icons.check_circle_outline_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    currentMessage,
                                    style: const TextStyle(
                                      fontFamily: 'Lama Sans',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (currentProgress != null) ...[
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: currentProgress / 100,
                                  backgroundColor:
                                      Colors.white.withValues(alpha: 0.2),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  minHeight: 6,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${currentProgress.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  fontFamily: 'Lama Sans',
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_currentOverlay!);

    _dismissTimer = Timer(const Duration(seconds: 3), () {
      dismiss();
    });
  }
}
