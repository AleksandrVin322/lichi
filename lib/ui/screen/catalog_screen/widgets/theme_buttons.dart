import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/bloc/theme/theme_bloc.dart';

/// Виджет содержащий две кнопки для смены светлой и темной темы.
class ThemeButtons extends StatelessWidget {
  /// Конструктор [ThemeButtons].
  const ThemeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ButtonForTheme(
            func: () => context.read<ThemeBloc>().add(ChangeThemeToDarkEvent()),
            colorButton: Colors.white,
            icon: Icons.dark_mode,
            colorIcon: Colors.black,
            text: 'Темная тема',
            colorText: Colors.black,
          ),
        ),
        Expanded(
          child: _ButtonForTheme(
            func: () =>
                context.read<ThemeBloc>().add(ChangeThemeToLightEvent()),
            colorButton: Colors.black,
            icon: Icons.light_mode,
            colorIcon: Colors.white,
            text: 'Светлая тема',
            colorText: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _ButtonForTheme extends StatelessWidget {
  final void Function()? func;
  final Color colorButton;
  final IconData icon;
  final Color colorIcon;
  final String text;
  final Color colorText;
  const _ButtonForTheme({
    required this.func,
    required this.colorButton,
    required this.icon,
    required this.colorIcon,
    required this.text,
    required this.colorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 80,
      child: ElevatedButton(
        onPressed: func,
        style: TextButton.styleFrom(
          backgroundColor: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorIcon, size: 25),
            const SizedBox(width: 5),
            Text(
              text,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
