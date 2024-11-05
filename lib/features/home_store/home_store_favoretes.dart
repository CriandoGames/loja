import 'package:flutter/material.dart';
import 'package:loja/features/home_store/home_store_controller.dart';

import '../../core/shared/injector.dart';
import 'widgets/product_card.dart';

class HomeStoreFavoretes extends StatefulWidget {
  const HomeStoreFavoretes({super.key});

  @override
  State<HomeStoreFavoretes> createState() => _HomeStoreFavoretesState();
}

class _HomeStoreFavoretesState extends State<HomeStoreFavoretes> {
  final controller = injector.get<HomeStoreController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Favorites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
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
                      controller: controller,
                      isIconFavoriteActived: false),
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
