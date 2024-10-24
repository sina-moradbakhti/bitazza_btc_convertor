import 'package:bitazza/features/coin/data/datasources/coin_local_datasource.dart';

import '../../domain/repositories/convertor_repository.dart';

class ConvertorRepositoryImpl implements ConvertorRepository {
  final CoinLocalDatasource coinLocalDatasource;

  ConvertorRepositoryImpl({
    required this.coinLocalDatasource,
  });

  @override
  double convertEurToBtc(double euroValue) =>
      euroValue / coinLocalDatasource.coinPrice.eurPrice.rateFloat;

  @override
  double convertGbpToBtc(double gbpValue) =>
      gbpValue / coinLocalDatasource.coinPrice.gbpPrice.rateFloat;

  @override
  double convertUsdToBtc(double usdValue) =>
      usdValue / coinLocalDatasource.coinPrice.usdPrice.rateFloat;

  @override
  double convertBtcToEur(double btcValue) =>
      btcValue * coinLocalDatasource.coinPrice.eurPrice.rateFloat;

  @override
  double convertBtcToGbp(double btcValue) =>
      btcValue * coinLocalDatasource.coinPrice.gbpPrice.rateFloat;

  @override
  double convertBtcToUsd(double btcValue) =>
      btcValue * coinLocalDatasource.coinPrice.usdPrice.rateFloat;
}
