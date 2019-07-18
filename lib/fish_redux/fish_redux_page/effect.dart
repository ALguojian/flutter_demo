import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FishReduxState> buildEffect() {
  return combineEffects(<Object, Effect<FishReduxState>>{
    FishReduxAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FishReduxState> ctx) {
}
