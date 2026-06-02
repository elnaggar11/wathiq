import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
      // primaryColor: AppColors.primary,
      // primaryColorLight: AppColors.primary,

      // hintColor: AppColors.typographyBody,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      // colorScheme: const ColorScheme.light(
      //   primary: AppColors.primary,
      //   secondary: AppColors.secondColor,
      //   tertiary: AppColors.thirdColor,
      //   shadow: AppColors.black,
      //   secondaryContainer: AppColors.secondColor,
      // ),

      // appBarTheme: AppBarTheme(
      //   centerTitle: true,
      //   elevation: 0.0,
      //   color: Colors.transparent,
      //   iconTheme: const IconThemeData(
      //     color: AppColors.black,
      //   ),
      //   titleTextStyle:
      //       getBoldStyle(color: AppColors.black, fontSize: 16).copyWith(
      //     fontWeight: FontWeight.w900,
      //   ),
      //   // titleTextStyle: TextStyle(
      //   //   fontWeight: FontWeight.w700,
      //   //   fontFamily: AppFonts.tajawal,
      //   //   fontSize: 28
      //   //   color: Colors.black,
      //   // ),
      // ),

      // textTheme: const TextTheme(
      //   displayLarge: TextStyle(
      //     fontSize: 72.0,
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.black,
      //   ),
      //   displayMedium: TextStyle(
      //     fontSize: 36.0,
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.black,
      //   ),
      //   displaySmall: TextStyle(
      //     fontSize: 24.0,
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.black,
      //   ),
      //   headlineMedium: TextStyle(
      //     fontSize: 18.0,
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.black,
      //   ),
      //   headlineSmall: TextStyle(
      //     fontSize: 16.0,
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.black,
      //   ),
      //   titleLarge: TextStyle(
      //     fontSize: 14.0,
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.black,
      //   ),
      //   bodyLarge: TextStyle(
      //     fontSize: 16.0,
      //     fontWeight: FontWeight.normal,
      //     color: AppColors.black,
      //   ),
      //   bodyMedium: TextStyle(
      //     fontSize: 14.0,
      //     fontWeight: FontWeight.normal,
      //     color: AppColors.black,
      //   ),
      // ),

      // //! TFF Theme
      // inputDecorationTheme: InputDecorationTheme(
      //   suffixIconColor: AppColors.iconsprimary,
      //   contentPadding: const EdgeInsets.all(AppPadding.p8),
      //   hintStyle: TextStyle(color: AppColors.iconsprimary),
      //   labelStyle: const TextStyle(color: Colors.green, fontSize: AppSize.s14),
      //   errorStyle: const TextStyle(color: AppColors.error),
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: const BorderSide(
      //       color: AppColors.white,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: AppColors.iconsprimary,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //     borderSide: const BorderSide(
      //       color: AppColors.error,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      //   focusedErrorBorder: OutlineInputBorder(
      //     borderSide: const BorderSide(
      //       color: AppColors.primary,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      // ),

      // //! TextButton THeme
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     foregroundColor: AppColors.primary,
      //   ),
      // ),

      // //!ElevatedButtonTheme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          fixedSize: const Size.fromHeight(56),
          minimumSize: const Size.fromHeight(56),
          elevation: 0.0,
          backgroundColor: Color(0xFF0C3F82),
        ),
      ),
      // //! Check Box Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xff23614F); // Color when checked
            }

            return Colors.white; // Color when unchecked
          },
        ),
        checkColor: WidgetStateProperty.all(Colors.white), // Check icon color
        overlayColor:
            WidgetStateProperty.all(Colors.white), // Ripple effect color
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xFFE9E9E9),
          ),
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
      ),

      // //! Radio Theme
      // radioTheme: RadioThemeData(
      //   fillColor: WidgetStateProperty.all(AppColors.primary),
      // ),

      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //   type: BottomNavigationBarType.fixed,
      // ),

      // //! Bottom Sheet Theme
      // bottomSheetTheme: const BottomSheetThemeData(
      //   backgroundColor: AppColors.white,
      // ),
    );
ThemeData get darkTheme => ThemeData(
      // primaryColor: AppColors.black,
      // primaryColorLight: AppColors.error,
      // hintColor: AppColors.typographyBody,
      brightness: Brightness.dark,
      // scaffoldBackgroundColor: AppColors.black,
      // colorScheme: const ColorScheme.dark(
      //   primary: AppColors.primary,
      //   secondary: AppColors.secondColor,
      //   tertiary: AppColors.thirdColor,
      //   shadow: AppColors.black,
      //   secondaryContainer: AppColors.secondColor,
      // ),

      // appBarTheme: AppBarTheme(
      //   centerTitle: true,
      //   elevation: 0.0,
      //   color: Colors.transparent,
      //   iconTheme: const IconThemeData(
      //     color: AppColors.black,
      //   ),
      //   titleTextStyle:
      //       getBoldStyle(color: AppColors.black, fontSize: 16).copyWith(
      //     fontWeight: FontWeight.w900,
      //   ),
      // ),

      // //! TFF Theme
      // inputDecorationTheme: InputDecorationTheme(
      //   suffixIconColor: AppColors.iconsprimary,
      //   contentPadding: const EdgeInsets.all(AppPadding.p8),
      //   hintStyle: TextStyle(color: AppColors.iconsprimary),
      //   labelStyle: const TextStyle(color: Colors.gr, fontSize: AppSize.s14),
      //   errorStyle: const TextStyle(color: AppColors.error),
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: const BorderSide(
      //       color: AppColors.white,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //       color: AppColors.iconsprimary,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //     borderSide: const BorderSide(
      //       color: AppColors.error,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      //   focusedErrorBorder: OutlineInputBorder(
      //     borderSide: const BorderSide(
      //       color: AppColors.primary,
      //       width: AppSize.s1_5,
      //     ),
      //     borderRadius: BorderRadius.circular(
      //       AppSize.s14,
      //     ),
      //   ),
      // ),

      // //! TextButton THeme
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     foregroundColor: AppColors.primary,
      //   ),
      // ),

      // //!ElevatedButtonTheme
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(
      //         AppSize.s12,
      //       ),
      //     ),
      //     fixedSize: const Size.fromHeight(52),
      //     minimumSize: const Size.fromHeight(52),
      //     elevation: 0.0,
      //     backgroundColor: AppColors.primary,
      //   ),
      // ),
      // //! Check Box Theme
      // checkboxTheme: CheckboxThemeData(
      //   fillColor: WidgetStateProperty.all(AppColors.white),
      //   checkColor: WidgetStateProperty.all(AppColors.primary),
      //   // overlayColor: MaterialStateProperty.all(AppColors.primary),

      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(5),
      //   ),
      // ),

      // //! Radio Theme
      // radioTheme: RadioThemeData(
      //   fillColor: WidgetStateProperty.all(AppColors.primary),
      // ),

      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //   type: BottomNavigationBarType.fixed,
      // ),

      // //! Bottom Sheet Theme
      // bottomSheetTheme: const BottomSheetThemeData(
      //   backgroundColor: AppColors.black,
      // ),
    );
