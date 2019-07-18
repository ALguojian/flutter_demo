import 'package:fish_redux/fish_redux.dart';

class FishReduxState implements Cloneable<FishReduxState> {
  Map<String, dynamic> args;

  @override
  FishReduxState clone() {
    return FishReduxState()..args = args;
  }
}

FishReduxState initState(Map<String, dynamic> args) {
  return FishReduxState()..args = args;
}
