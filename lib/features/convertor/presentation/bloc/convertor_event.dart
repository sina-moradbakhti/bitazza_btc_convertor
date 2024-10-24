abstract class ConvertorEvent {}

class ConvertAmountChangedEvent extends ConvertorEvent {
  final double amount;

  ConvertAmountChangedEvent(this.amount);
}

class ConvertBtcAmountChangedEvent extends ConvertorEvent {
  final double amount;

  ConvertBtcAmountChangedEvent(this.amount);
}

class CurrencyChangedEvent extends ConvertorEvent {
  final String currency;
  CurrencyChangedEvent(this.currency);
}

class RevereseConvertEvent extends ConvertorEvent {
  final bool reversedConvert;

  RevereseConvertEvent(this.reversedConvert);
}
