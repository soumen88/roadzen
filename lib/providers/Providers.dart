import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/homescreen/HomeScreenBloc.dart';

final homeScreenProvider = ChangeNotifierProvider.autoDispose<HomeScreenBloc>((ref) => HomeScreenBloc());