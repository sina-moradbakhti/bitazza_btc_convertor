import 'dart:async';
import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/features/coin/domain/repositories/coin_repository.dart';
import 'package:bitazza/features/coin/presentation/bloc/coin_events.dart';
import 'package:bitazza/features/coin/presentation/bloc/coin_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/coin_local_datasource.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final getIt = GetIt.instance;

  final CoinRepository getCoinPrices;
  Timer? _timer;

  CoinBloc(this.getCoinPrices) : super(CoinInitial()) {
    on<GetBtcData>(_onGetBtcData);
    add(GetBtcData());
  }

  Future<void> _onGetBtcData(GetBtcData event, Emitter<CoinState> emit) async {
    emit(CoinLoading());

    final result = await getCoinPrices.getCoinPrice(CoinName.btc);
    result.fold(
      (failure) => emit(CoinError(failure.message)),
      (coinPrice) {
        CoinLocalDatasource coinSharedRepo = getIt<CoinLocalDatasource>();

        coinSharedRepo.coinPrice = coinPrice;

        coinSharedRepo.priceHistory =
            List.unmodifiable([...coinSharedRepo.priceHistory, coinPrice]);

        // Keep only the last 24 hours of data (1 minute intervals)
        if (coinSharedRepo.priceHistory.length > 1440) {
          coinSharedRepo.priceHistory = coinSharedRepo.priceHistory.sublist(1);
        }

        emit(CoinLoaded(coinPrice, coinSharedRepo.priceHistory));

        _startPeriodicFetch();
      },
    );
  }

  void _startPeriodicFetch() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      add(GetBtcData());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
