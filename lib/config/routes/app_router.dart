import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(body: Center(child: Text('Home'))),
        ),
      ),
      // Add more routes as needed
    ],
  );
}