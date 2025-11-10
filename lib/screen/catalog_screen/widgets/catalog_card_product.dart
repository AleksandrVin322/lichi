import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../entity/product.dart';
import 'catalog_bottom_modal_bar.dart';
import 'catalog_photo_in_card.dart';

class CardProduct extends StatelessWidget {
  final Product product;
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
              CatalogPhotoInCard(product: product),
              const SizedBox(height: 12),
              Text(product.formatPrice[2]),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),
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
                            color: hexToColor(product.colors[index]),
                          ),
                          const SizedBox(width: 6),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

Color hexToColor(String hexString) {
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
    builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
          child: CatalogBottomModalBar(product: product),
        ),
      );
    },
  );
}
