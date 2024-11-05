import 'package:flutter/material.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/features/theme/app_colors.dart';

import '../../core/shared/injector.dart';
import 'widgets/product_card.dart';

class HomeStoreFavorites extends StatefulWidget {
  const HomeStoreFavorites({super.key});

  @override
  State<HomeStoreFavorites> createState() => _HomeStoreFavoritesState();
}

class _HomeStoreFavoritesState extends State<HomeStoreFavorites> {
  final controller = injector.get<HomeStoreController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Favorites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.appGreyDarkColor,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: controller.favorite.value.length,
          itemBuilder: (_, index) {
            final product = controller.favorite.value[index];
            return SizedBox(
              width: size.width * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductCard(
                    product: product,
                    isFavoriteIconEnabled: false,
                    isFavorite: controller.isFavorite(product),
                    toggleFavorite: () => controller.toggleFavorite(product),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  )
                ],
              ),
            );
          },
        ));
  }
}
