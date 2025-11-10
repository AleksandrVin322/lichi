import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/dto/product.dart';
import 'bottom_modal_bar.dart';
import 'photo_in_card.dart';

class CardProduct extends StatelessWidget {
  final Product product;

  /// Карточка для продукта.
  const CardProduct({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
      child: Center(
        child: InkWell(
          onTap: () => _showModal(context: context, product: product),
          child: Column(
            children: [
              Expanded(flex: 6, child: PhotoInCard(product: product)),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      product.formatPrice[2],
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Center(
                      child: SizedBox(
                        height: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            product.colors.length,
                            (index) => Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: _hexToColor(product.colors[index]),
                                ),
                                const SizedBox(width: 6),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) {
    buffer.write('FF');
  }
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

void _showModal({required BuildContext context, required Product product}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
          child: BottomModalBar(product: product),
        ),
      );
    },
  );
}
