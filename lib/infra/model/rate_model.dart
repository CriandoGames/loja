class RateModel {
  final int reviewCount;
  final num rate;

  RateModel({
    required this.reviewCount,
    required this.rate,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      reviewCount: json['count'],
      rate: json['rate'],
    );
  }
}
