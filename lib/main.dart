import 'package:bitazza/features/coin/data/datasources/coin_local_datasource.dart';
import 'package:bitazza/features/coin/data/datasources/coin_remote_datasource.dart';
import 'package:bitazza/features/coin/data/repositories/coin_repository_impl.dart';
import 'package:bitazza/features/coin/presentation/bloc/coin_bloc.dart';
import 'package:bitazza/features/coin/presentation/pages/details_page.dart';
import 'package:bitazza/features/convertor/data/repositories/convertor_repository_impl.dart';
import 'package:bitazza/features/convertor/presentation/bloc/convertor_bloc.dart';
import 'package:bitazza/features/main/presentation/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/main/presentation/pages/main_page.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerLazySingleton<CoinLocalDatasource>(() => CoinLocalDatasource());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MainBloc(),
        ),
        BlocProvider(
          create: (_) => CoinBloc(CoinRepositoryImpl(
            remoteDataSource: CoinRemoteDataSource(),
          )),
        ),
        BlocProvider(
          create: (_) => ConvertorBloc(
            ConvertorRepositoryImpl(
              coinLocalDatasource: getIt<CoinLocalDatasource>(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        home: const MainPage(),
        routes: {
          '/details': (context) => const DetailsPage(),
        },
      ),
    );
  }
}
