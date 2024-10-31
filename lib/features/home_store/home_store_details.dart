import 'package:flutter/material.dart';
import 'package:loja/core/shared/injector.dart';
import 'package:loja/features/home_store/home_store_controller.dart';
import 'package:loja/infra/model/product_model.dart';

class HomeStoreDetails extends StatefulWidget {
  final ProductModel _product;
  const HomeStoreDetails({required ProductModel product, super.key})
      : _product = product;

  @override
  State<HomeStoreDetails> createState() => _HomeStoreDetailsState();
}

class _HomeStoreDetailsState extends State<HomeStoreDetails> {
  final controller = injector.get<HomeStoreController>();

  @override
  Widget build(BuildContext context) {
    controller.loadFavorites().whenComplete(() {
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.toggleFavorite(widget._product.id);
            },
            icon: Icon(
              controller.isFavorite(widget._product.id)
                  ? Icons.favorite
                  : Icons.favorite_outline,
              color: controller.isFavorite(widget._product.id)
                  ? Colors.red
                  : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget._product.imageUrl,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                widget._product.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        ),
                        const SizedBox(width: 4),
                        Text(widget._product.rating.rate.toString()),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            "(${widget._product.rating.reviewCount} reviews)",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'R\$ ${widget._product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF5EC401),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.notes_outlined,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget._product.category,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.menu_sharp,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget._product.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
