
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:to_doapp/app/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Todo Architecture',
      routerDelegate: AppRouter.routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: AppRouter.routerDelegate),
    );
  }
}
