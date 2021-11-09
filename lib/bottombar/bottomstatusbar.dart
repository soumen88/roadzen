import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;
import 'package:roadzen/providers/providers.dart';

class BottomStatusBar extends StatefulWidget {
  final VoidCallback animationStarted;
  final void Function(bool?)? animationFinished;
  BottomStatusBar({
    Key? key,
    required this.animationStarted,
    required this.animationFinished,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomStatusBarState();
  }

}
class BottomStatusBarState extends State<BottomStatusBar> with TickerProviderStateMixin {
  bool _isContainerVisible = true;
  String TAG = "ConnectivityStatusBar";
  AnimationController? _animation;
  Animation<double>? _fadeInFadeOut;
  bool _isAnimationInProgress = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      developer.log(TAG , name: "WidgetsBinding");

    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (builder, watch, child){
        final futureProvider = watch(bottomBarStatusProvider).currentStatus;
        return displayBar(context);
      },
    );
  }

  void changeState(){
    try{
      _animation = AnimationController(vsync: this, duration: Duration(seconds: 3),);
      _fadeInFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(_animation!);

      _animation!.addStatusListener((status){
        if(status == AnimationStatus.completed){
          _isAnimationInProgress = false;
          widget.animationFinished!(true);
          context.read(bottomBarStatusProvider.notifier).startTimer();
        }
        else if(status == AnimationStatus.dismissed){

        }
      });
      _animation!.forward();
    }
    catch(e){
      developer.log(TAG, name : "Error in animation $e");
    }

  }

  Widget displayBar(BuildContext context){
    changeState();
    _isContainerVisible = true;
    _isAnimationInProgress = true;
    widget.animationStarted();
    developer.log(TAG, name : "Is display ${_isContainerVisible}");
    String message = context.read(bottomBarStatusProvider).textMessage!;
    bool isError = context.read(bottomBarStatusProvider).isError!;
    return FadeTransition(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          message,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ) ,
        color: isError ? Colors.redAccent : Colors.green ,
      ),
      opacity: _fadeInFadeOut! ,
    );
  }
  @override
  dispose() {
    if(_animation != null){
      //animation!.dispose();
    }

    super.dispose();
  }
}