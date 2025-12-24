
// import 'package:flutter/material.dart';
// import 'package:beamer/beamer.dart';
// import 'package:to_doapp/app/router/app_router.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Todo Architecture',
//       routerDelegate: AppRouter.routerDelegate,
//       routeInformationParser: BeamerParser(),
//       backButtonDispatcher:
//           BeamerBackButtonDispatcher(delegate: AppRouter.routerDelegate),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/app/router/app_router.dart';

// 2. Change StatelessWidget to ConsumerWidget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  // 3. Add WidgetRef ref to the build method
  Widget build(BuildContext context, WidgetRef ref) {
    
    // 4. Watch the router provider
    final delegate = ref.watch(routerDelegateProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Todo Architecture',
      // 5. Use the delegate from Riverpod
      routerDelegate: delegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(delegate: delegate),
    );
  }
}