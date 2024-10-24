class CoinPrice {
  final CoinDetails usdPrice;
  final CoinDetails gbpPrice;
  final CoinDetails eurPrice;
  final String latestUpdated;

  CoinPrice({
    required this.usdPrice,
    required this.gbpPrice,
    required this.eurPrice,
    required this.latestUpdated,
  });

  factory CoinPrice.fromMap(Map<String, dynamic> map) {
    return CoinPrice(
      usdPrice: CoinDetails.fromMap(map['bpi']['USD']),
      gbpPrice: CoinDetails.fromMap(map['bpi']['GBP']),
      eurPrice: CoinDetails.fromMap(map['bpi']['EUR']),
      latestUpdated: map['time']['updated'] as String,
    );
  }

  factory CoinPrice.empty() {
    return CoinPrice(
      usdPrice: CoinDetails.empty(),
      gbpPrice: CoinDetails.empty(),
      eurPrice: CoinDetails.empty(),
      latestUpdated: '',
    );
  }
}

class CoinDetails {
  final String code;
  final String symbol;
  final String rateStr;
  final double rateFloat;
  final String description;
  final DateTime updatedTime;

  CoinDetails({
    required this.code,
    required this.symbol,
    required this.rateStr,
    required this.rateFloat,
    required this.description,
    required this.updatedTime,
  });

  factory CoinDetails.fromMap(Map<String, dynamic> map) {
    return CoinDetails(
      code: map['code'] as String,
      symbol: map['symbol'] as String,
      rateStr: map['rate'] as String,
      rateFloat: map['rate_float'] as double,
      description: map['description'] as String,
      updatedTime: DateTime.now(),
    );
  }

  factory CoinDetails.empty() {
    return CoinDetails(
      code: '',
      symbol: '',
      rateStr: '',
      rateFloat: 0.0,
      description: '',
      updatedTime: DateTime.now(),
    );
  }
}
