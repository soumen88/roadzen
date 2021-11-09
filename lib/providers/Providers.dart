import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/bottombar/BottomBarStatusBloc.dart';
import 'package:roadzen/homescreen/HomeScreenBloc.dart';

final homeScreenProvider = ChangeNotifierProvider.autoDispose<HomeScreenBloc>((ref) => HomeScreenBloc());


final bottomBarStatusProvider = ChangeNotifierProvider<BottomBarStatusBloc>((ref) {
  return BottomBarStatusBloc();
});
