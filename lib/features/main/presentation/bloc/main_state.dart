abstract class MainState {}

class MainInitial extends MainState {}

class UpdatedNavigationState extends MainState {
  final int index;
  UpdatedNavigationState(this.index);
}
