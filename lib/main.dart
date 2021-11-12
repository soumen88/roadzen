import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/routes/AppRouter.gr.dart';
import 'dart:developer' as developer;
void main() {
  runZonedGuarded(() async {
    runApp(
        ProviderScope(child: MyApp())
    );
  },(error, stackTrace) {
    developer.log(TAG , name: "Error FROM OUT_SIDE FRAMEWORK ");
    developer.log(TAG , name: "--------------------------------");
    developer.log(TAG , name: "Error :  $error");
    developer.log(TAG , name: "StackTrace :  $stackTrace");
  });

}
String TAG = "Main";
class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({Key? key}) : super(key: key);
  String currentScreen = "Main";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Roadzen",
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      builder: (context, router) => router!,
    );
  }
}
