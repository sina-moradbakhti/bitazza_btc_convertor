import 'package:bitazza/features/coin/presentation/widgets/coin_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc.dart';
import '../bloc/coin_states.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: BlocListener<CoinBloc, CoinState>(
        listener: _listener,
        child: _blocBuilder(context),
      ),
    );
  }

  PreferredSizeWidget get _appBar => AppBar(
        title: Column(
          children: [
            const Text(
              'Bitcoin',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21.5,
              ),
            ),
            const SizedBox(height: 2.5),
            BlocBuilder<CoinBloc, CoinState>(
              builder: (context, state) {
                String lastUpdate = '';

                if (state is CoinLoading) {
                  lastUpdate = 'Updating...';
                } else if (state is CoinLoaded) {
                  lastUpdate = state.coinPrice.latestUpdated;
                } else if (state is CoinError) {
                  lastUpdate = 'Error';
                }

                return Text(
                  'Latest update: $lastUpdate',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                    letterSpacing: 0.5,
                    fontSize: 11.5,
                  ),
                );
              },
            ),
          ],
        ),
      );

  void _listener(BuildContext context, CoinState state) => (context, state) {
        if (state is CoinError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      };

  BlocBuilder<CoinBloc, CoinState> _blocBuilder(BuildContext context) {
    return BlocBuilder<CoinBloc, CoinState>(
      builder: (context, state) {
        if (state is CoinLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CoinLoaded) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  CoinItemWidget(
                    baseCoin: 'btc',
                    coin: state.coinPrice.usdPrice,
                  ),
                  const Divider(height: 0),
                  CoinItemWidget(
                    baseCoin: 'btc',
                    coin: state.coinPrice.gbpPrice,
                  ),
                  const Divider(height: 0),
                  CoinItemWidget(
                    baseCoin: 'btc',
                    coin: state.coinPrice.eurPrice,
                  ),
                ],
              ),
            ),
          );
        } else if (state is CoinError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text('No data'));
      },
    );
  }
}
