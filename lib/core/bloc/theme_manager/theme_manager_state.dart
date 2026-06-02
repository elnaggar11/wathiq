part of 'theme_manager_cubit.dart';

class ThemManagerState extends Equatable {
  final ThemeData themeData;

  const ThemManagerState({required this.themeData});
  @override
  List<Object> get props => [themeData];
}
