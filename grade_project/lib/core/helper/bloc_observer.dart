// core/helper/bloc_observer.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    ////debugPrint(" event =========$event");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    ////debugPrint(" error =========$error ======$stackTrace ");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    ////debugPrint(" change =========$change");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    ////debugPrint(" transation =========$transition");
  }
}
