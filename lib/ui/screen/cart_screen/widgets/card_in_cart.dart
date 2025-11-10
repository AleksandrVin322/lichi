import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/cart/cart_bloc.dart';
import '../../../../core/dto/product.dart';

class CardInCart extends StatelessWidget {
  final Map<Product, int> products;
  final int index;

  const CardInCart({required this.products, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.37,
                height: MediaQuery.of(context).size.width * 0.5,
                child: Image.network(
                  products.keys.toList()[index].photos[0],
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products.keys.toList()[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(products.keys.toList()[index].size ?? ''),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            products.keys.toList()[index].formatPrice[2],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _ButtonsCrement(
                            func: () => context.read<CartBloc>().add(
                              DecrementCountProductEvent(
                                product: products.keys.toList()[index],
                              ),
                            ),
                            icon: Icons.remove,
                          ),
                          const SizedBox(width: 5),
                          Text('${products.values.toList()[index]} ед.'),
                          const SizedBox(width: 5),
                          _ButtonsCrement(
                            func: () => context.read<CartBloc>().add(
                              IncrementCountProductEvent(
                                product: products.keys.toList()[index],
                              ),
                            ),
                            icon: Icons.add,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => context.read<CartBloc>().add(
                          DeleteProductEvent(
                            product: products.keys.toList()[index],
                          ),
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

class _ButtonsCrement extends StatelessWidget {
  final void Function()? func;
  final IconData icon;
  const _ButtonsCrement({required this.func, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(36, 0, 0, 0),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: func,
        icon: Icon(icon),
      ),
    );
  }
}
