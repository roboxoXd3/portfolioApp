import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class CoreEvent {}

class ChangeThemeEvent extends CoreEvent {}

// State
class CoreState {
  final ThemeMode themeMode;
  
  CoreState({this.themeMode = ThemeMode.light});
  
  CoreState copyWith({ThemeMode? themeMode}) {
    return CoreState(themeMode: themeMode ?? this.themeMode);
  }
}

// BLoC
class CoreBloc extends Bloc<CoreEvent, CoreState> {
  CoreBloc() : super(CoreState()) {
    on<ChangeThemeEvent>((event, emit) {
      final newThemeMode = state.themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
      emit(state.copyWith(themeMode: newThemeMode));
    });
  }
}