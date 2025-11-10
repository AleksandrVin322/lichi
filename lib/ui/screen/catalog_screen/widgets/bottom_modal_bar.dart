import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/bloc/cart/cart_bloc.dart';
import '../../../../core/dto/product.dart';

class BottomModalBar extends StatefulWidget {
  final Product product;

  /// Нижняя вызывная панель для каталога. Применяется для выбора размера и добавления товара в корзину.
  const BottomModalBar({required this.product, super.key});

  @override
  State<BottomModalBar> createState() => _BottomModalBarState();
}

class _BottomModalBarState extends State<BottomModalBar> {
  String size = '';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          'Выберите размер',
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(
          height: 1,
          color: Color.fromARGB(129, 158, 158, 158),
          thickness: 1,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ButtonSize(
                func: () {
                  setState(() {
                    size = 'XS';
                  });
                },
                size: size,
                textSize: 'XS',
              ),

              _ButtonSize(
                func: () {
                  setState(() {
                    size = 'S';
                  });
                },
                size: size,
                textSize: 'S',
              ),

              _ButtonSize(
                func: () {
                  setState(() {
                    size = 'M';
                  });
                },
                size: size,
                textSize: 'M',
              ),

              _ButtonSize(
                func: () {
                  setState(() {
                    size = 'L';
                  });
                },
                size: size,
                textSize: 'L',
              ),

              const Text('Как подобрать размер?'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 70,
          child: TextButton(
            onPressed: (size != '')
                ? () {
                    bloc.add(
                      AddProductEvent(
                        product: Product(
                          price: widget.product.price,
                          photos: widget.product.photos,
                          formatPrice: widget.product.formatPrice,
                          name: widget.product.name,
                          size: size,
                          colors: widget.product.colors,
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                    Flushbar(
                      messageText: Center(
                        child: Text(
                          'Товар успешно добавлен в корзину',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      duration: const Duration(seconds: 3),
                      flushbarPosition: FlushbarPosition.TOP,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      backgroundColor: Colors.black,
                    ).show(context);
                  }
                : null,
            style: TextButton.styleFrom(
              backgroundColor: (size != '') ? Colors.black : Colors.grey,
            ),
            child: Center(
              child: Text(
                'В корзину · ${widget.product.formatPrice[2]}',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _ButtonSize extends StatelessWidget {
  final void Function()? func;
  final String size;
  final String textSize;
  const _ButtonSize({
    required this.func,
    required this.size,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: (size == textSize) ? Colors.grey : null,
        ),
        height: 30,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            textSize,
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
