import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart_bloc/cart_bloc.dart';
import 'entity/product_count.dart';
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
      child: Container(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                productCount.product.photos[0],
                height: MediaQuery.of(context).size.height / 5,
                fit: BoxFit.cover,
              ),
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
                  Expanded(
                    child: TextOpenSans(
                      text: productCount.product.formatPrice[2],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(36, 0, 0, 0),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => context.read<CartBloc>().add(
                                DecrementCountProductEvent(index: index),
                              ),
                              icon: const Icon(Icons.remove),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text('${productCount.count} ед.'),
                          const SizedBox(width: 5),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(36, 0, 0, 0),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => context.read<CartBloc>().add(
                                IncrementCountProductEvent(index: index),
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => context.read<CartBloc>().add(
                          DeleteProductEvent(index: index),
                        ),
                        icon: const Icon(Icons.delete, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
