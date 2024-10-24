import 'package:bitazza/core/models/failure_model.dart';
import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/features/coin/data/datasources/coin_remote_datasource.dart';
import 'package:bitazza/features/coin/domain/entities/coin_price_entity.dart';
import 'package:bitazza/features/coin/domain/repositories/coin_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinRemoteDataSource remoteDataSource;

  CoinRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CoinPrice>> getCoinPrice(CoinName coin) async {
    try {
      switch (coin) {
        case CoinName.btc:
          final btcPriceModel = await remoteDataSource.fetchBtc();
          return Right(btcPriceModel);

        default:
          return Left(
            Failure(message: 'Unknown coin: $coin'),
          );
      }
    } catch (e) {
      debugPrint(e.toString());

      return Left(
        Failure(message: 'Failed to fetch BTC prices from the server'),
      );
    }
  }
}
