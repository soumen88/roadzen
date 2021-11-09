import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/bottombar/bottombarstatusbloc.dart';
import 'package:roadzen/homescreen/homescreenbloc.dart';

final homeScreenProvider = ChangeNotifierProvider.autoDispose<HomeScreenBloc>((ref) => HomeScreenBloc());


final bottomBarStatusProvider = ChangeNotifierProvider<BottomBarStatusBloc>((ref) {
  return BottomBarStatusBloc();
});
