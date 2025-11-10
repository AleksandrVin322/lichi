import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'style/text_style.dart';

class CardProduct extends StatefulWidget {
  final String price;
  final String priceR;
  final String name;
  final List<String> photos;
  const CardProduct({
    required this.price,
    required this.priceR,
    required this.name,
    required this.photos,
    super.key,
  });

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
          onTap: () => _showModal(context, widget.priceR),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: widget.photos.length,
                      onPageChanged: (index) {
                        setState(() {
                          ind = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.photos[index],
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
                              ? Icon(Icons.circle, size: 7)
                              : Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 7,
                                ),
                          (ind > 0 && ind < widget.photos.length - 1)
                              ? Icon(Icons.circle, size: 7)
                              : Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 7,
                                ),
                          (ind == widget.photos.length - 1)
                              ? Icon(Icons.circle, size: 7)
                              : Icon(
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
                text: '${widget.price} руб.',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 12),
              Center(
                child: TextOpenSans(
                  text: widget.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showModal(BuildContext context, String priceR) {
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
                color: const Color.fromARGB(129, 158, 158, 158),
                thickness: 1,
              ),
              const SizedBox(height: 10),

              Expanded(
                child: Column(
                  children: [
                    TextButton(onPressed: () {}, child: Text('XS')),
                    const SizedBox(height: 10),
                    TextButton(onPressed: () {}, child: Text('S')),
                    const SizedBox(height: 10),
                    TextButton(onPressed: () {}, child: Text('M')),
                    const SizedBox(height: 10),
                    TextButton(onPressed: () {}, child: Text('L')),
                    const SizedBox(height: 10),
                    const Text('Как подобрать размер?'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                  child: Center(
                    child: Text(
                      'В корзину · $priceR',
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
