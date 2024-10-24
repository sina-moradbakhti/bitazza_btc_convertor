import 'package:bitazza/features/main/presentation/bloc/main_event.dart';
import 'package:bitazza/features/main/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<UpdateNavigationIndexEvent>(_onUpdateMainNavigation);
  }

  void _onUpdateMainNavigation(
    UpdateNavigationIndexEvent event,
    Emitter<MainState> emit,
  ) {
    emit(UpdatedNavigationState(event.index));
  }
}
