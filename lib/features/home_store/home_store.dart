import 'package:flutter/material.dart';
import 'package:loja/domain/shared/injector.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/features/home_store/states/home_store_state.dart';

import '../../domain/shared/image_path.dart';

class HomeStore extends StatefulWidget {
  const HomeStore({super.key});

  @override
  State<HomeStore> createState() => _HomeStoreState();
}

class _HomeStoreState extends State<HomeStore> {
  final controller = injector.get<HomeStoreController>();

  @override
  void initState() {
    super.initState();
    controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_outline),
              onPressed: () {},
            )
          ],
        ),
        body: ValueListenableBuilder<HomeStoreState>(
          valueListenable: controller,
          builder: (_, state, __) {
            if (state is HomeStoreStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeStoreStateInitial) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  final product = state.products[index];
                  return Text(product.name);
                },
              );
            } else if (state is HomeStoreStateEmpty) {
              return Center(
                child: Image.asset(ImagePath.homeEmptyImage()),
              );
            } else if (state is HomeStoreStateError) {
              return Center(
                child: Image.asset(ImagePath.homeEmptyImage()),
              );
            }
            return const SizedBox();
          },
        ));
  }
}
