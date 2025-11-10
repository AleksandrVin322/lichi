import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailWidget extends StatelessWidget {
  final void Function()? func;

  /// Виджет при ошибках запросов на сервер.
  const FailWidget({required this.func, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Произошла ошибка, пожалуйста, повторите позднее',
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(100),
                ),
              ),
              onPressed: func,
              child: Text(
                'Повторить',
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
