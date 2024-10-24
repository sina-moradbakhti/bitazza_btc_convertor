import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/core/utils/formatters.dart';
import 'package:bitazza/features/convertor/presentation/bloc/convertor_bloc.dart';
import 'package:bitazza/features/convertor/presentation/bloc/convertor_event.dart';
import 'package:bitazza/features/convertor/presentation/bloc/convertor_state.dart';
import 'package:bitazza/features/convertor/presentation/widgets/coin_textfield_widget.dart';
import 'package:bitazza/features/convertor/presentation/widgets/currency_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertorPage extends StatefulWidget {
  const ConvertorPage({super.key});

  @override
  State<ConvertorPage> createState() => _ConvertorPageState();
}

class _ConvertorPageState extends State<ConvertorPage> {
  final amountCtrl = TextEditingController();
  final coinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: BlocListener<ConvertorBloc, ConvertorState>(
        listener: (context, state) {
          if (state.reversedConvert) {
            amountCtrl.text = state.amount.toString();
          } else {
            coinCtrl.text = state.amountInBtc.toString();
          }
        },
        child: _blocBuilder(context),
      ),
    );
  }

  Widget _blocBuilder(BuildContext context) {
    final convertorBloc = context.read<ConvertorBloc>();

    return BlocBuilder<ConvertorBloc, ConvertorState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: !state.reversedConvert
                ? [
                    _currencyField(convertorBloc, state),
                    const SizedBox(height: 24),
                    _divider(convertorBloc, state),
                    const SizedBox(height: 24),
                    _coinField(convertorBloc, state),
                  ]
                : [
                    _coinField(convertorBloc, state),
                    const SizedBox(height: 24),
                    _divider(convertorBloc, state),
                    const SizedBox(height: 24),
                    _currencyField(convertorBloc, state),
                  ],
          ),
        );
      },
    );
  }

  Widget _currencyField(ConvertorBloc bloc, ConvertorState state) {
    return CurrencyTextfieldWidget(
      readonly: state.reversedConvert,
      ctrl: amountCtrl,
      defaultCurrency: state.selectedCurrency,
      onCurrencyChanged: (currencyName) =>
          bloc.add(CurrencyChangedEvent(currencyName.toStrCurrencyName())),
      onAmountChanged: (amount) => bloc.add(ConvertAmountChangedEvent(amount)),
    );
  }

  Widget _coinField(ConvertorBloc bloc, ConvertorState state) {
    return CoinTextfieldWidget(
      ctrl: coinCtrl,
      coin: CoinName.btc,
      readOnly: !state.reversedConvert,
      onAmountChanged: (amount) =>
          bloc.add(ConvertBtcAmountChangedEvent(amount)),
    );
  }

  Widget _divider(ConvertorBloc bloc, ConvertorState state) {
    return Center(
      child: IconButton(
        onPressed: () => bloc.add(RevereseConvertEvent(!state.reversedConvert)),
        icon: const Icon(Icons.swap_vert, size: 28.0),
      ),
    );
  }

  PreferredSizeWidget get _appbar => AppBar(
        title: const Text(
          'Convert',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 21.5,
          ),
        ),
      );
}
