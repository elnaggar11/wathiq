import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/light_theme.dart';

part 'theme_manager_state.dart';

class ThemManagerCubit extends Cubit<ThemManagerState> {
  ThemManagerCubit()
      : super(ThemManagerState(
          themeData: lightTheme,
        ));

  void toggleTheme() {
    emit(
      ThemManagerState(
        themeData: state.themeData.brightness == Brightness.light
            ? darkTheme
            : lightTheme,
      ),
    );
  }
}
