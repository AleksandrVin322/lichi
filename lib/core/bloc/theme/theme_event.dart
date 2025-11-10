part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ChangeThemeToDarkEvent extends ThemeEvent {}

class ChangeThemeToLightEvent extends ThemeEvent {}
