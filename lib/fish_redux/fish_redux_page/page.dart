import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FishReduxPage extends Page<FishReduxState, Map<String, dynamic>> {
  FishReduxPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FishReduxState>(
                adapter: null,
                slots: <String, Dependent<FishReduxState>>{
                }),
            middleware: <Middleware<FishReduxState>>[
            ],);

}
