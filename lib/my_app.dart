import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/api_client.dart';
import 'api/shared_preverence_api.dart';
import 'bloc/cart_bloc/cart_bloc.dart';
import 'bloc/catalog_bloc/catalog_screen_bloc.dart';
import 'bloc/category_bloc/category_bloc.dart';
import 'bloc/theme_bloc/theme_bloc.dart';
import 'screen/cart_screen/cart_screen.dart';
import 'screen/catalog_screen/catalog_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiClient()),
        RepositoryProvider(create: (context) => SharedPreferencesApi()),
      ],
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
          BlocProvider(
            create: (context) => CartBloc(
              sharedPreferencesApi: context.read<SharedPreferencesApi>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is LightThemeState) {
              return MaterialApp(
                theme: state.theme,
                routes: {
                  'catalog_screen': (context) => const CatalogScreen(),
                  'cart_screen': (context) => const CartScreen(),
                },
                initialRoute: 'catalog_screen',
              );
            }
            if (state is DarkThemeState) {
              return MaterialApp(
                theme: state.theme,
                routes: {
                  'catalog_screen': (context) => const CatalogScreen(),
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
