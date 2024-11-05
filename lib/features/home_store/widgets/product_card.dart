import 'package:flutter/material.dart';
import 'package:loja/features/theme/app_colors.dart';
import 'package:loja/infra/model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.isFavoriteIconEnabled,
  });

  final ProductModel product;
  final bool isFavoriteIconEnabled;
  final Future<void> Function() toggleFavorite;
  final bool isFavorite;

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
                        color: AppColors.appGreyDarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6)),
                !isFavoriteIconEnabled
                    ? const SizedBox(
                        height: 4,
                      )
                    : const Offstage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.appYellowColor,
                        ),
                        const SizedBox(width: 4),
                        Text(product.rating.rate.toString(),
                            style: TextStyle(
                                color: AppColors.appGreyDarkColor.withAlpha(
                                  65,
                                ),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: 4),
                        Text("(${"${product.rating.reviewCount} reviews"})",
                            style: TextStyle(
                                color: AppColors.appGreyDarkColor.withAlpha(65),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    isFavoriteIconEnabled
                        ? IconButton(
                            onPressed: () async => await toggleFavorite(),
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: isFavorite
                                  ? AppColors.appRedColor
                                  : AppColors.appGreyDarkColor.withAlpha(80),
                            ),
                          )
                        : const Offstage()
                  ],
                ),
                !isFavoriteIconEnabled
                    ? const SizedBox(
                        height: 4,
                      )
                    : const Offstage(),
                Text(
                  "\$${product.price.toString()}",
                  style: const TextStyle(
                    color: AppColors.appOrangeColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
