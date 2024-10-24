abstract class MainEvent {}

class UpdateNavigationIndexEvent extends MainEvent {
  final int index;

  UpdateNavigationIndexEvent(this.index);
}
