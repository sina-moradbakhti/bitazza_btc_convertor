import 'package:bitazza/core/utils/enums.dart';
import 'package:bitazza/features/coin/domain/entities/coin_price_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class CoinGraphWidget extends StatelessWidget {
  final List<CoinPrice> data;
  final CurrencyName currencyName;

  const CoinGraphWidget({
    super.key,
    required this.data,
    required this.currencyName,
  });

  @override
  Widget build(BuildContext context) {
    final chartSize = MediaQuery.of(context).size.width;

    return SizedBox(
      width: chartSize,
      height: chartSize - 50,
      child: data.length > 1
          ? SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                opposedPosition: false,
                labelAlignment: LabelAlignment.center,
                dateFormat: DateFormat.Hm(),
                intervalType: DateTimeIntervalType.minutes,
                interval: 5,
              ),
              primaryYAxis: NumericAxis(
                opposedPosition: true,
                labelAlignment: LabelAlignment.center,
                numberFormat: NumberFormat.currency(
                  decimalDigits: 0,
                  name: '',
                ),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
              ),
              series: <LineSeries>[
                LineSeries<CoinDetails, DateTime>(
                  dataSource: _data(),
                  xValueMapper: (CoinDetails coin, _) => coin.updatedTime,
                  yValueMapper: (CoinDetails coin, _) => coin.rateFloat,
                  color: Colors.blue,
                )
              ],
            )
          : const Center(
              child: Text('chart is filling, wait for 1 minute'),
            ),
    );
  }

  List<CoinDetails> _data() {
    switch (currencyName) {
      case CurrencyName.usd:
        return data.map((coin) => coin.usdPrice).toList();
      case CurrencyName.gbp:
        return data.map((coin) => coin.gbpPrice).toList();
      case CurrencyName.eur:
        return data.map((coin) => coin.eurPrice).toList();
      default:
        return [];
    }
  }
}
