import 'package:flutter/material.dart';

import '../../../../core/dto/product.dart';

/// Фото в карточке на странице с каталогом.
class PhotoInCard extends StatefulWidget {
  final Product product;

  /// Конструктор [PhotoInCard].
  const PhotoInCard({required this.product, super.key});

  @override
  State<PhotoInCard> createState() => _PhotoInCardState();
}

class _PhotoInCardState extends State<PhotoInCard> {
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: PageView.builder(
            itemCount: widget.product.photos.length,
            onPageChanged: (index) {
              setState(() {
                ind = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.product.photos[index],
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 14,
          bottom: 14,
          child: Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 255, 255, 255).withAlpha(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (ind == 0)
                    ? const Icon(Icons.circle, size: 7, color: Colors.black)
                    : const Icon(Icons.circle, size: 7, color: Colors.white),
                (ind > 0 && ind < widget.product.photos.length - 1)
                    ? const Icon(Icons.circle, size: 7, color: Colors.black)
                    : const Icon(Icons.circle, size: 7, color: Colors.white),
                (ind == widget.product.photos.length - 1)
                    ? const Icon(Icons.circle, size: 7, color: Colors.black)
                    : const Icon(Icons.circle, size: 7, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
