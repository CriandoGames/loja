import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja/core/shared/injector.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/features/home_store/states/home_store_state.dart';

import '../../core/shared/image_path.dart';

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
    controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.loadFavorites().whenComplete(
      () {
        if (!controller.isConnected()) {
          context.go('/wrong');
        }

        if (controller.value is HomeStoreStateEmpty &&
            controller.isEmptyError() &&
            controller.isConnected()) {
          controller.fetchProducts();
        }

        setState(() {});
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 16, top: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Anything',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) {
                  controller.filterByCategory(value);
                },
              ),
            )),
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
                return SizedBox(
                  width: size.width * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => context.push('/details', extra: product),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Image.network(
                                product.imageUrl,
                                width: 126,
                                height: 121,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.name,
                                        style: const TextStyle(
                                            color: Color(0xFF37474f),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.6)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(product.rating.rate.toString(),
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            const SizedBox(width: 4),
                                            Text(
                                                "(${"${product.rating.reviewCount} reviews"})",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () async =>
                                              await controller
                                                  .toggleFavorite(product.id),
                                          icon: Icon(
                                            controller.isFavorite(product.id)
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: controller
                                                    .isFavorite(product.id)
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "\$${product.price.toString()}",
                                      style: const TextStyle(
                                          color: Color(0xFFF37A20),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
            );
          } else if (state is HomeStoreStateEmpty) {
            return Center(
              child: Image.asset(
                ImagePath.homeEmptyImage(),
                width: 300,
                height: 280,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
