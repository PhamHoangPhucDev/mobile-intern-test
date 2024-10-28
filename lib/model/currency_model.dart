class CurrencyRate {
  final String base;
  final Map<String, num> rates;

  CurrencyRate({required this.base, required this.rates});

  factory CurrencyRate.fromJson(Map<String, dynamic> json) {
    return CurrencyRate(
      base: json['base'],
      rates: Map<String, num>.from(json['rates']),
    );
  }
}
