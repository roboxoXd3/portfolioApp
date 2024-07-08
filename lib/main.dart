import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_app/config/routes/app_router.dart';
import 'package:portfolio_app/shared/blocs/core_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoreBloc(),
      child: BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Portfolio App',
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}