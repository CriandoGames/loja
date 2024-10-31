import 'package:flutter/material.dart';
import 'package:loja/infra/model/product_model.dart';

class HomeStoreDetails extends StatelessWidget {
  final ProductModel _product;
  const HomeStoreDetails({required ProductModel product, super.key})
      : _product = product;

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.favorite_outline),
            onPressed: () {},
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
                _product.imageUrl,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                _product.name,
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
                        Text(_product.rating.rate.toString()),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            "(${_product.rating.reviewCount} reviews)",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'R\$ ${_product.price.toStringAsFixed(2)}',
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
                      _product.category,
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
                      _product.description,
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
