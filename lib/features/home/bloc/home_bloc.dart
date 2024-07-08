// lib/features/home/bloc/home_bloc.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class HomeEvent {}

class LoadHomeDataEvent extends HomeEvent {}
class ToggleThemeEvent extends HomeEvent {}


// States
class HomeState {
  final List<String> skills;
  final List<String> projects;
  final bool isLoading;
  final ThemeMode themeMode;

  HomeState({
    this.skills = const [],
    this.projects = const [],
    this.isLoading = false,
    this.themeMode = ThemeMode.light,
  });

  HomeState copyWith({
    List<String>? skills,
    List<String>? projects,
    bool? isLoading,
     ThemeMode? themeMode,
  }) {
    return HomeState(
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(isLoading: true)) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
     on<ToggleThemeEvent>(_onToggleTheme);

  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<HomeState> emit) {
    final newThemeMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newThemeMode));
  }

  void _onLoadHomeData(LoadHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    
    // Simulate data loading
    await Future.delayed(const Duration(seconds: 1));
    
    emit(state.copyWith(
      skills: ['Flutter', 'Dart', 'Firebase', 'UI/UX', 'Git'],
      projects: ['Project 1', 'Project 2', 'Project 3', 'Project 4', 'Project 5'],
      isLoading: false,
    ));

    
  }
}