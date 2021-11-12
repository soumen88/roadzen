import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'dart:developer' as developer;

import 'package:roadzen/providers/providers.dart';
import 'package:roadzen/routes/AppRouter.gr.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreenPage>{

  String currentScreen = "SplashScreenState";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (builder, watch, child){
              final timerExpired = watch(durationProvider).data!.value;
              if(timerExpired){
                startLoginScreen();
              }
              return Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: 300.0,
                      height: 500.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/rz_logo.jpg",
                                ))
                        ),
                      ),
                    ),
                  ),
                  Text("Roadzen", style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(currentScreen , name: "WidgetsBinding");
      context.read(durationProvider.notifier).startTimer();
    });

  }

  void startLoginScreen(){
    //context.router.replace(LoginScreenRoute());
    context.router.navigate(FamilyDetailsScreenRoute());
  }
}
