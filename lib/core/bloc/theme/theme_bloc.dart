import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ChangeThemeToDarkEvent>(_changeThemeToDark);
    on<ChangeThemeToLightEvent>(_changeThemeToLight);
  }

  void _changeThemeToDark(
    ChangeThemeToDarkEvent event,
    Emitter<ThemeState> emit,
  ) {
    emit(DarkThemeState());
  }

  void _changeThemeToLight(
    ChangeThemeToLightEvent event,
    Emitter<ThemeState> emit,
  ) {
    emit(LightThemeState());
  }
}
