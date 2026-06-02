import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get bottomPadding => MediaQuery.of(this).viewPadding.bottom;
  bool get isDarkTheme =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  // void showToast({
  //   required ToastificationType type,
  //   required String title,
  //   String? description,
  // }) =>
  //     showCustomToast(
  //       this,
  //       type: type,
  //       title: title,
  //       description: description,
  //     );

  double get aspectRatio => size.aspectRatio;

  double get heightWithoutPadding => height - topPadding - bottomPadding;

  double get heightWithoutAppBar => heightWithoutPadding - kToolbarHeight;

  double get heightWithoutAppBarAndPadding =>
      heightWithoutPadding - kToolbarHeight;

  double get heightWithoutAppBarAndPaddingAndBottomBar =>
      heightWithoutAppBarAndPadding - kBottomNavigationBarHeight;

  double get heightWithoutAppBarAndPaddingAndBottomBarAndKeyboard =>
      heightWithoutAppBarAndPaddingAndBottomBar -
      MediaQuery.of(this).viewInsets.bottom;

  double get heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBar =>
      heightWithoutAppBarAndPaddingAndBottomBarAndKeyboard - kToolbarHeight;

  double
      get heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBarAndBottomBar =>
          heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBar -
          kBottomNavigationBarHeight;

  double get heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBarAndBottomBarAndKeyboard =>
      heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBarAndBottomBar -
      MediaQuery.of(this).viewInsets.bottom;

  double get heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBarAndBottomBarAndKeyboardAndTopBar =>
      heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBarAndBottomBarAndKeyboard -
      kToolbarHeight;

  double get heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBarAndBottomBarAndKeyboardAndTopBarAndBottomBar =>
      heightWithoutAppBarAndPaddingAndBottomBarAndKeyboardAndTopBarAndBottomBarAndKeyboardAndTopBar -
      kBottomNavigationBarHeight;

  double responsiveHeight(num value) {
    //! Figma Height
    double xdHeight = 760;
    // double percentage = (value / xdHeight * 100).roundToDouble() / 100;
    double percentage = (value / xdHeight * 100) / 100;
    return height * percentage;
  }

  double responsiveWidth(num value) {
    //! Figma Height
    double xdWidth = 360;
    // double percentage = (value / xdWidth * 100).roundToDouble() / 100;
    double percentage = (value / xdWidth * 100) / 100;
    return width * percentage;
  }

  Future navigateTo(String routeName, [Object? arguments]) async {
    await Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void navigateToWithReplacementNamed(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  void navigateToWithReplacement(Widget screen) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void navigateToWithReplacementAndClearStack(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  void navigateToWithClearStackAndArguments(
      String routeName, Object arguments) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  Future navigateToWithArguments(String routeName, Object arguments) async {
    return await Navigator.of(this).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void navigateToWithReplacementAndArguments(
      String routeName, Object arguments) {
    Navigator.of(this).pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  void pop() {
    Navigator.of(this).pop();
  }

  Future mayPop() async {
    await Navigator.of(this).maybePop();
  }
}
