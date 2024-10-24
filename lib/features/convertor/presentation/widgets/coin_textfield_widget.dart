import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/core/utils/formatters.dart';
import 'package:flutter/material.dart';

class CoinTextfieldWidget extends StatelessWidget {
  final CoinName coin;
  final TextEditingController? ctrl;
  final bool readOnly;
  final Function(double amount)? onAmountChanged;

  const CoinTextfieldWidget({
    super.key,
    required this.coin,
    this.ctrl,
    this.readOnly = true,
    this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      readOnly: readOnly,
      onChanged: (value) {
        if (readOnly == false) {
          onAmountChanged?.call(value.isNotEmpty ? double.parse(value) : 0);
        }
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.currency_bitcoin),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 5.0,
            top: 11.0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              coin.toStrCoinName(),
              style: const TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
