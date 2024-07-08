import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/pages/home_page.dart';
import '../../features/projects/pages/projects_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: HomePage(),
        ),
      ),
      // Add more routes as needed
       GoRoute(
        path: '/projects',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: ProjectsPage(),
        ),
      ),
    ],
  );
}