import 'package:flutter/material.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/infra/model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.controller,
    required this.isIconFavoriteActived,
  });

  final ProductModel product;
  final bool isIconFavoriteActived;
  final HomeStoreController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                !isIconFavoriteActived
                    ? const SizedBox(
                        height: 4,
                      )
                    : const Offstage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: 4),
                        Text("(${"${product.rating.reviewCount} reviews"})",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    isIconFavoriteActived
                        ? IconButton(
                            onPressed: () async =>
                                await controller.toggleFavorite(product),
                            icon: Icon(
                              controller.isFavorite(product)
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: controller.isFavorite(product)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          )
                        : const Offstage()
                  ],
                ),
                !isIconFavoriteActived
                    ? const SizedBox(
                        height: 4,
                      )
                    : const Offstage(),
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
    );
  }
}
