import 'package:bitazza/features/coin/domain/entities/coin_price_entity.dart';

abstract class CoinState {}

class CoinInitial extends CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final CoinPrice coinPrice;
  final List<CoinPrice> priceHistory;

  CoinLoaded(this.coinPrice, this.priceHistory);
}

class CoinError extends CoinState {
  final String message;

  CoinError(this.message);
}
