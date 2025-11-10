import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'entity/product_count.dart';
import 'screen/catalog_screen/cart_bloc/bloc/cart_bloc.dart';
import 'style/text_style.dart';

class CardInCart extends StatelessWidget {
  final ProductCount productCount;
  final int index;

  const CardInCart({
    required this.productCount,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            productCount.product.photos[0],
            height: MediaQuery.of(context).size.height / 5,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productCount.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                TextOpenSans(
                  text: productCount.product.size ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                const SizedBox(height: 33),
                TextOpenSans(
                  text: productCount.product.formatPrice[2],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.read<CartBloc>().add(
                            DecrementCountProductEvent(index: index),
                          ),
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${productCount.count} ед.'),
                        IconButton(
                          onPressed: () => context.read<CartBloc>().add(
                            IncrementCountProductEvent(index: index),
                          ),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => context.read<CartBloc>().add(
                        DeleteProductEvent(index: index),
                      ),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
