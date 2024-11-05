import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja/features/error/wrong.dart';
import 'package:loja/features/home_store/home_store.dart';
import 'package:loja/features/home_store/home_store_details.dart';
import 'package:loja/features/home_store/home_store_favoretes.dart';
import 'package:loja/infra/model/product_model.dart';

class Routes {
  static final Routes _singleton = Routes._internal();

  factory Routes() => _singleton;

  Routes._internal();

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeStore();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return HomeStoreDetails(product: state.extra as ProductModel);
            },
          ),
          GoRoute(
            path: 'favorites',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeStoreFavoretes();
            },
          ),
          GoRoute(
            path: 'wrong',
            builder: (BuildContext context, GoRouterState state) {
              return const Wrong();
            },
          ),
        ],
      ),
    ],
  );
}
