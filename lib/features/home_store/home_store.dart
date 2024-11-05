import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja/core/shared/injector.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/features/home_store/states/home_store_state.dart';

import '../../core/shared/image_path.dart';
import 'widgets/product_card.dart';

class HomeStore extends StatefulWidget {
  const HomeStore({super.key});

  @override
  State<HomeStore> createState() => _HomeStoreState();
}

class _HomeStoreState extends State<HomeStore> {
  final controller = injector.get<HomeStoreController>();

  _connectedFail() {
    controller.isConnected().addListener(() {
      if (controller.isConnected().value) {
        context.go('/wrong');
      } else {
        controller.initialize();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize();

      _connectedFail();
    });
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
            onPressed: () {
              context.go('/favorites');
            },
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
                  controller.filterByName(value);
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
                        child: ProductCard(
                          product: product,
                          controller: controller,
                          isIconFavoriteActived: true,
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
