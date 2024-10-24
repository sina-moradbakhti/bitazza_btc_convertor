import 'package:bitazza/features/coin/presentation/pages/coin_page.dart';
import 'package:bitazza/features/convertor/presentation/pages/convertor_page.dart';
import 'package:bitazza/features/main/presentation/bloc/main_bloc.dart';
import 'package:bitazza/features/main/presentation/bloc/main_event.dart';
import 'package:bitazza/features/main/presentation/bloc/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: IndexedStack(
          index: context.select((MainBloc bloc) {
            int currectIndex = 0;

            if (bloc.state is UpdatedNavigationState) {
              currectIndex = (bloc.state as UpdatedNavigationState).index;
            }

            return currectIndex;
          }),
          children: const [
            CoinPage(),
            ConvertorPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.select((MainBloc bloc) {
            int currectIndex = 0;

            if (bloc.state is UpdatedNavigationState) {
              currectIndex = (bloc.state as UpdatedNavigationState).index;
            }

            return currectIndex;
          }),
          onTap: (index) {
            context.read<MainBloc>().add(UpdateNavigationIndexEvent(index));
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_bitcoin),
              label: 'Bitcoin',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange_rounded),
              label: 'Convert',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          elevation: 1.0,
          selectedFontSize: 13.0,
          unselectedFontSize: 13.0,
        ),
      ),
    );
  }
}
