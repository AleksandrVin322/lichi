import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/cart_bloc/cart_bloc.dart';
import 'entity/product.dart';
import 'style/text_style.dart';

class CardProduct extends StatefulWidget {
  final Product product;
  const CardProduct({required this.product, super.key});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
      child: Center(
        child: InkWell(
          onTap: () => _showModal(
            context: context,
            formatPrice: widget.product.formatPrice,
            price: widget.product.price,
            name: widget.product.name,
            photos: widget.product.photos,
            colors: widget.product.colors,
          ),
          child: Column(
            children: [
              Stack(
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
                        color: const Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ).withAlpha(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          (ind == 0)
                              ? const Icon(
                                  Icons.circle,
                                  size: 7,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 7,
                                ),
                          (ind > 0 && ind < widget.product.photos.length - 1)
                              ? const Icon(
                                  Icons.circle,
                                  size: 7,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 7,
                                ),
                          (ind == widget.product.photos.length - 1)
                              ? const Icon(
                                  Icons.circle,
                                  size: 7,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 7,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              TextOpenSans(
                text: '${widget.product.price} руб.',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 12),
              Text(
                widget.product.name,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.product.colors.length,
                      (index) => Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: hexToColor(widget.product.colors[index]),
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
    buffer.write('FF'); // добавляем альфа-канал (непрозрачность)
  }
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

void _showModal({
  required BuildContext context,
  required List<String> formatPrice,
  required int price,
  required List<String> photos,
  required String name,
  required List<String> colors,
}) {
  var size = 'M';
  final bloc = context.read<CartBloc>();
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const TextOpenSans(
                text: 'Выберите размер',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 1,
                color: Color.fromARGB(129, 158, 158, 158),
                thickness: 1,
              ),
              const SizedBox(height: 30),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        size = 'XS';
                      },
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          'XS',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        size = 'S';
                      },
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          'S',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        size = 'M';
                      },
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          'M',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        size = 'L';
                      },
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          'L',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Как подобрать размер?'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: TextButton(
                  onPressed: () {
                    bloc.add(
                      AddProductEvent(
                        product: Product(
                          price: price,
                          photos: photos,
                          formatPrice: formatPrice,
                          name: name,
                          size: size,
                          colors: colors,
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text('Товар успешно добавлен в корзину'),
                          ),
                        ),
                        duration: const Duration(seconds: 3),
                        backgroundColor: Colors.black,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 90,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                  child: Center(
                    child: Text(
                      'В корзину · ${formatPrice[1]}',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
