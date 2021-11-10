import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/bottombar/bottombarstatusbloc.dart';
import 'package:roadzen/components/quantitybloc.dart';
import 'package:roadzen/homescreen/homescreenbloc.dart';
import 'package:roadzen/models/fakedetailsgeneratorbloc.dart';
import 'package:roadzen/models/familymodel.dart';
import 'package:roadzen/register/familyregistrationbloc.dart';
import 'package:roadzen/splashscreen/timerdurationbloc.dart';

final homeScreenProvider = ChangeNotifierProvider.autoDispose<HomeScreenBloc>((ref) => HomeScreenBloc());

final bottomBarStatusProvider = ChangeNotifierProvider<BottomBarStatusBloc>((ref) {
  return BottomBarStatusBloc();
});

final fakeDetailsProvider = ChangeNotifierProvider<FakeDetailsGeneratorBloc>((ref) {
  return FakeDetailsGeneratorBloc();
});

final durationProvider = StateNotifierProvider<TimerDurationBloc, AsyncValue<bool>>((ref) {
  return TimerDurationBloc();
});

final registrationProvider = StateNotifierProvider<FamilyRegistrationBloc, AsyncValue<SplayTreeMap<int,List<FamilyModel>>?>>((ref) {
  return FamilyRegistrationBloc();
});

final counterProvider = ChangeNotifierProvider.autoDispose<QuantityBloc>((ref) => QuantityBloc());