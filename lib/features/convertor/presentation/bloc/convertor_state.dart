import 'package:bitazza/core/utils/enums.dart';

class ConvertorState {
  double amount;
  double amountInBtc;
  CurrencyName selectedCurrency;

  bool reversedConvert = false;

  ConvertorState({
    required this.amount,
    required this.amountInBtc,
    required this.selectedCurrency,
    this.reversedConvert = false,
  });
}
