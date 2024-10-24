import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/core/utils/formatters.dart';
import 'package:bitazza/features/convertor/domain/repositories/convertor_repository.dart';
import 'package:bitazza/features/convertor/presentation/bloc/convertor_event.dart';
import 'package:bitazza/features/convertor/presentation/bloc/convertor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ConvertorBloc extends Bloc<ConvertorEvent, ConvertorState> {
  final getIt = GetIt.instance;

  final ConvertorRepository convertorRepository;

  CurrencyName selectedCurrency = CurrencyName.usd;

  ConvertorBloc(this.convertorRepository)
      : super(ConvertorState(
          amount: 0.0,
          amountInBtc: 0.0,
          selectedCurrency: CurrencyName.usd,
        )) {
    on<ConvertAmountChangedEvent>(_onConvertAmountChanged);
    on<ConvertBtcAmountChangedEvent>(_onConvertBtcAmountChanged);
    on<CurrencyChangedEvent>(_onCurrencyChanged);
    on<RevereseConvertEvent>(_onRevereseConvert);
  }

  Future<void> _onRevereseConvert(
      RevereseConvertEvent event, Emitter<ConvertorState> emit) async {
    emit(
      ConvertorState(
        amount: state.amount,
        amountInBtc: state.amountInBtc,
        selectedCurrency: state.selectedCurrency,
        reversedConvert: event.reversedConvert,
      ),
    );
  }

  Future<void> _onConvertBtcAmountChanged(
      ConvertBtcAmountChangedEvent event, Emitter<ConvertorState> emit) async {
    double conversionRate = 0.0;

    switch (selectedCurrency) {
      case CurrencyName.usd:
        conversionRate = convertorRepository.convertBtcToUsd(event.amount);
        break;
      case CurrencyName.gbp:
        conversionRate = convertorRepository.convertBtcToGbp(event.amount);
        break;
      case CurrencyName.eur:
        conversionRate = convertorRepository.convertBtcToEur(event.amount);
        break;
    }

    emit(
      ConvertorState(
        amount: conversionRate,
        amountInBtc: event.amount,
        selectedCurrency: selectedCurrency,
        reversedConvert: state.reversedConvert,
      ),
    );
  }

  Future<void> _onConvertAmountChanged(
      ConvertAmountChangedEvent event, Emitter<ConvertorState> emit) async {
    double conversionRate = 0.0;

    switch (selectedCurrency) {
      case CurrencyName.usd:
        conversionRate = convertorRepository.convertUsdToBtc(event.amount);
        break;
      case CurrencyName.gbp:
        conversionRate = convertorRepository.convertGbpToBtc(event.amount);
        break;
      case CurrencyName.eur:
        conversionRate = convertorRepository.convertEurToBtc(event.amount);
        break;
    }

    emit(
      ConvertorState(
        amount: event.amount,
        amountInBtc: conversionRate,
        selectedCurrency: selectedCurrency,
        reversedConvert: state.reversedConvert,
      ),
    );
  }

  Future<void> _onCurrencyChanged(
      CurrencyChangedEvent event, Emitter<ConvertorState> emit) async {
    selectedCurrency = event.currency.toCurrencyNameEnum();

    emit(
      ConvertorState(
        amount: state.amount,
        amountInBtc: state.amountInBtc,
        selectedCurrency: selectedCurrency,
        reversedConvert: state.reversedConvert,
      ),
    );

    if (state.reversedConvert) {
      add(ConvertBtcAmountChangedEvent(state.amountInBtc));
    } else {
      add(ConvertAmountChangedEvent(state.amount));
    }
  }
}
