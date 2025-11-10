import 'package:flutter/material.dart';

import '../../../entity/product.dart';

class CatalogPhotoInCard extends StatefulWidget {
  final Product product;
  const CatalogPhotoInCard({required this.product, super.key});

  @override
  State<CatalogPhotoInCard> createState() => _CatalogPhotoInCardState();
}

class _CatalogPhotoInCardState extends State<CatalogPhotoInCard> {
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
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
