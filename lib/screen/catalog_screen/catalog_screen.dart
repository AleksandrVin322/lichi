import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../card_product.dart';
import '../../service/api_client.dart';
import '../../style/text_style.dart';
import 'catalog_bloc/catalog_screen_bloc.dart';
import 'theme_bloc/theme_bloc.dart';

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
                CatalogScreenBloc(apiClient: context.read<ApiClient>())
                  ..add(CatalogScreenLoadedEvent()),
          ),
          BlocProvider(create: (context) => ThemeBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is LightThemeState) {
              return MaterialApp(theme: state.theme, home: BodyCatalogScreen());
            }
            if (state is DarkThemeState) {
              return MaterialApp(theme: state.theme, home: BodyCatalogScreen());
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
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('0', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 5),
                          Icon(Icons.shopping_bag, color: Colors.white),
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
          SizedBox(
            height: 20,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SizedBox(width: 16),
                Text('Все'),
                SizedBox(width: 16),
                Text('Платья'),
                SizedBox(width: 16),
                Text('Купальники'),
                SizedBox(width: 16),
                Text('Деним'),
                SizedBox(width: 16),
                Text('Блузы и топы'),
                SizedBox(width: 16),
                Text('Брюки'),
                SizedBox(width: 16),
                Text('Бриджи'),
                SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
            builder: (context, state) {
              if (state is CatalogLoadedState) {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    children: List.generate(state.clothes.length, (index) {
                      return CardProduct(
                        price: state.clothes[index].formatPrice[0],
                        name: state.clothes[index].name,
                        photos: state.clothes[index].photos,
                        priceR: state.clothes[index].formatPrice[1],
                      );
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
