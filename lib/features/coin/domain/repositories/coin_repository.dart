import 'package:bitazza/core/models/failure_model.dart';
import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/features/coin/domain/entities/coin_price_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CoinRepository {
  Future<Either<Failure, CoinPrice>> getCoinPrice(CoinName coin);
}
