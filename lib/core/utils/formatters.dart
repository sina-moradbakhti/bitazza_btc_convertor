import 'package:bitazza/core/utils/enums.dart';

extension SymbolFormatter on String {
  String toSymbol() {
    switch (this) {
      case '&#36;':
        return '\$';
      case '&pound;':
        return '£';
      case '&euro;':
        return '€';
      default:
        return this;
    }
  }

  String toCurrencyName() {
    switch (this) {
      case '&#36;':
        return 'USD';
      case '&pound;':
        return 'GBP';
      case '&euro;':
        return 'EUR';
      default:
        return this;
    }
  }

  CurrencyName toCurrencyNameEnum() {
    switch (this) {
      case 'USD':
        return CurrencyName.usd;
      case 'GBP':
        return CurrencyName.gbp;
      case 'EUR':
        return CurrencyName.eur;
      default:
        return CurrencyName.usd;
    }
  }
}

extension CoinNameFormatter on CoinName {
  String toStrCoinName() {
    switch (this) {
      case CoinName.btc:
        return 'BTC';
      default:
        return '';
    }
  }
}

extension CurrencyNameFormatter on CurrencyName {
  String toStrCurrencyName() {
    switch (this) {
      case CurrencyName.usd:
        return 'USD';
      case CurrencyName.gbp:
        return 'GBP';
      case CurrencyName.eur:
        return 'EUR';
      default:
        return '';
    }
  }
}
