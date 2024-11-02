import 'package:equatable/equatable.dart';

class RateModel extends Equatable {
  const RateModel({
    required this.reviewCount,
    required this.rate,
  });

  final int reviewCount;
  final num rate;

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      reviewCount: json['count'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'count': reviewCount,
        'rate': rate,
      };

  @override
  List<Object?> get props => [reviewCount, rate];
}
