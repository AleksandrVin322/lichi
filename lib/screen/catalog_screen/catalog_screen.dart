import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api_client.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../bloc/catalog_bloc/catalog_screen_bloc.dart';
import '../../bloc/category_bloc/category_bloc.dart';
import '../../bloc/theme_bloc/theme_bloc.dart';
import '../../card_product.dart';
import '../../style/text_style.dart';
import '../cart/cart_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiClient(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CatalogScreenBloc(apiClient: context.read<ApiClient>()),
          ),
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(
            create: (context) =>
                CategoryBloc(apiClient: context.read<ApiClient>()),
          ),
          BlocProvider(create: (context) => CartBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is LightThemeState) {
              return MaterialApp(
                theme: state.theme,
                routes: {
                  'catalog_screen': (context) => const BodyCatalogScreen(),
                  'cart_screen': (context) => const CartScreen(),
                },
                initialRoute: 'catalog_screen',
              );
            }
            if (state is DarkThemeState) {
              return MaterialApp(
                theme: state.theme,
                routes: {
                  'catalog_screen': (context) => const BodyCatalogScreen(),
                  'cart_screen': (context) => const CartScreen(),
                },
                initialRoute: 'catalog_screen',
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class BodyCatalogScreen extends StatelessWidget {
  const BodyCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(child: SizedBox()),
            const Expanded(
              child: TextOpenSans(
                text: 'Каталог товаров',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(100),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('cart_screen'),
                      child: Row(
                        children: [
                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              if (state is CartInitialState) {
                                return Text(
                                  '${state.cart.itemCount}',
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 40),
            child: TextOpenSans(
              text:
                  'Каждый день тысячи девушек распаковывают пакеты с новинками Lichi и становятся счастливее, ведь очевидно, что новое платье может изменить день, а с ним и всю жизнь!',
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 80,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () =>
                        context.read<ThemeBloc>().add(ChangeThemeToDarkEvent()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.dark_mode, color: Colors.black),
                        const SizedBox(width: 5),
                        Text(
                          'Темная тема',
                          style: GoogleFonts.openSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () => context.read<ThemeBloc>().add(
                      ChangeThemeToLightEvent(),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.light_mode,
                          color: Colors.white,
                          size: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Светлая тема',
                          style: GoogleFonts.openSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoadedState) {
                return SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.category.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const SizedBox(width: 5),
                          InkWell(
                            child: Column(
                              children: [
                                Text(state.category[index].name),
                                (state.index == index)
                                    ? Container(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        width:
                                            state.category[index].name.length *
                                            8,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            onTap: () {
                              context.read<CatalogScreenBloc>().add(
                                ProductsLoadedEvent(
                                  category: state.category[index].url,
                                ),
                              );
                              context.read<CategoryBloc>().add(
                                CategorySwitchEvent(index: index),
                              );
                            },
                          ),
                          const SizedBox(width: 5),
                        ],
                      );
                    },
                  ),
                );
              }

              return const CircularProgressIndicator();
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
            builder: (context, state) {
              if (state is CatalogLoadedState) {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.45,
                    children: List.generate(state.products.length, (index) {
                      return CardProduct(product: state.products[index]);
                    }),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
