import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/core/utils/formatters.dart';
import 'package:flutter/material.dart';

class CurrencyTextfieldWidget extends StatelessWidget {
  final TextEditingController? ctrl;
  final Function(CurrencyName currencyName)? onCurrencyChanged;
  final Function(double amount)? onAmountChanged;
  final CurrencyName defaultCurrency;
  final bool readonly;

  const CurrencyTextfieldWidget({
    super.key,
    this.ctrl,
    this.onCurrencyChanged,
    this.onAmountChanged,
    this.defaultCurrency = CurrencyName.usd,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      readOnly: readonly,
      onChanged: (value) =>
          onAmountChanged?.call(value.isNotEmpty ? double.parse(value) : 0),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration(
        labelText: 'Amount',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.attach_money),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 5.0,
            top: 11.0,
          ),
          child: DropdownButton<String>(
            value: defaultCurrency.toStrCurrencyName(),
            onChanged: (String? newValue) {
              if (onCurrencyChanged != null) {
                onCurrencyChanged!(newValue!.toCurrencyNameEnum());
              }
            },
            items: <String>[
              CurrencyName.usd.toStrCurrencyName(),
              CurrencyName.gbp.toStrCurrencyName(),
              CurrencyName.eur.toStrCurrencyName(),
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                alignment: Alignment.center,
                child: Text(value),
              );
            }).toList(),
            isDense: true,
            hint: Container(),
            underline: Container(),
          ),
        ),
      ),
    );
  }
}
