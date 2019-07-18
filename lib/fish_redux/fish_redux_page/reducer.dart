import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FishReduxState> buildReducer() {
  return asReducer(
    <Object, Reducer<FishReduxState>>{
      FishReduxAction.action: _onAction,
    },
  );
}

FishReduxState _onAction(FishReduxState state, Action action) {
  final FishReduxState newState = state.clone();
  return newState;
}
