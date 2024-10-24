import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/core/utils/formatters.dart';
import 'package:bitazza/features/coin/domain/entities/coin_price_entity.dart';
import 'package:bitazza/features/coin/presentation/bloc/coin_bloc.dart';
import 'package:bitazza/features/coin/presentation/bloc/coin_states.dart';
import 'package:bitazza/features/coin/presentation/widgets/coin_graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final coin = ModalRoute.of(context)!.settings.arguments as CoinDetails;

    return Scaffold(
      appBar: _appbar(coin),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _blocBuilder(context, coin),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appbar(CoinDetails coin) {
    return AppBar(
      title: Text(
        'BTC / ${coin.symbol.toCurrencyName()}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21.5,
        ),
      ),
    );
  }

  BlocBuilder<CoinBloc, CoinState> _blocBuilder(
    BuildContext context,
    CoinDetails coin,
  ) {
    return BlocBuilder<CoinBloc, CoinState>(
      builder: (context, state) {
        if (state is CoinLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CoinLoaded) {
          CoinDetails updatedCoin = coin;

          switch (coin.code.toCurrencyNameEnum()) {
            case CurrencyName.usd:
              updatedCoin = state.coinPrice.usdPrice;
              break;
            case CurrencyName.gbp:
              updatedCoin = state.coinPrice.gbpPrice;
              break;
            case CurrencyName.eur:
              updatedCoin = state.coinPrice.eurPrice;
              break;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                updatedCoin.rateStr,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  fontSize: 19.5,
                ),
              ),
              const SizedBox(height: 2.5),
              Text(
                '~ ${updatedCoin.symbol.toSymbol()}${updatedCoin.rateStr}',
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 30),
              CoinGraphWidget(
                data: state.priceHistory,
                currencyName: updatedCoin.code.toCurrencyNameEnum(),
              ),
            ],
          );
        } else if (state is CoinError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No data'));
      },
    );
  }
}
