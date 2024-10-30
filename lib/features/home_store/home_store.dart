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
    final size = MediaQuery.of(context).size;
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
          preferredSize:
              const Size.fromHeight(80), // Altura da barra de pesquisa
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 16, top: 16),
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
                // Implementação para pesquisa
                ;
              },
            ),
          ),
        ),
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
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: size.width * 0.1,
                    child: Column(
                      children: [
                        Row(
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
                                  Text(product.name),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.star_border),
                                          Text(product.rating.rate.toString()),
                                          Text(
                                              "(${"${product.rating.reviewCount} reviews"})"),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.favorite_outline))
                                    ],
                                  ),
                                  Text("\$${product.price.toString()}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                        )
                      ],
                    ),
                  ),
                );
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
      ),
    );
  }
}
