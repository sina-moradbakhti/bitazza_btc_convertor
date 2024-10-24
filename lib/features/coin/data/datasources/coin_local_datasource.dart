import '../../domain/entities/coin_price_entity.dart';

class CoinLocalDatasource {
  List<CoinPrice> priceHistory = List.unmodifiable([]);
  CoinPrice coinPrice = CoinPrice.empty();
}
