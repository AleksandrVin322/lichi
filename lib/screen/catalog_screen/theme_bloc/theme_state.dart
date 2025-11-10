part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class LightThemeState extends ThemeState {
  final theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
  );
  LightThemeState();
}

class DarkThemeState extends ThemeState {
  final theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[900],
  );
  DarkThemeState();
}
