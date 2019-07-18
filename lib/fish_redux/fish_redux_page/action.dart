import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FishReduxAction { action }

class FishReduxActionCreator {
  static Action onAction() {
    return const Action(FishReduxAction.action);
  }
}
