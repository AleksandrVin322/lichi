import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/api/api_client.dart';
import 'core/api/database_client.dart';
import 'core/bloc/cart/cart_bloc.dart';
import 'core/bloc/catalog/catalog_bloc.dart';
import 'core/bloc/category/category_bloc.dart';
import 'core/bloc/theme/theme_bloc.dart';
import 'ui/screen/cart_screen/cart_screen.dart';
import 'ui/screen/catalog_screen/catalog_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiClient()),
        RepositoryProvider(create: (context) => DatabaseClient()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CatalogBloc(apiClient: context.read<ApiClient>()),
          ),
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(
            create: (context) =>
                CategoryBloc(apiClient: context.read<ApiClient>()),
          ),
          BlocProvider(
            create: (context) =>
                CartBloc(sharedPreferencesApi: context.read<DatabaseClient>()),
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
