import 'package:bitazza/core/utils/constants.dart';
import 'package:bitazza/features/coin/domain/entities/coin_price_entity.dart';

import 'package:dio/dio.dart';

class CoinRemoteDataSource {
  CoinRemoteDataSource();

  final Dio _dio = Dio();

  Future<CoinPrice> fetchBtc() async {
    try {
      final response = await _dio.get(
        AppConstants.bitcoinPriceUrl,
      );

      return CoinPrice.fromMap(response.data);
    } catch (e) {
      throw Exception('Failed to fetch BTC prices from the server');
    }
  }
}
