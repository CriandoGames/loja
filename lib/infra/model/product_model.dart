import 'package:equatable/equatable.dart';
import 'package:loja/infra/model/rate_model.dart';

class ProductModel extends Equatable {
  final num id;
  final String name;
  final String description;
  final num price;
  final String category;
  final String imageUrl;
  final RateModel rating;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      imageUrl: json['image'],
      rating: RateModel.fromJson(json['rating']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        category,
        imageUrl,
        rating,
      ];
}
