import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadzen/bottombar/bottombarstatusbloc.dart';
import 'package:roadzen/components/quantitybloc.dart';
import 'package:roadzen/homescreen/homescreenbloc.dart';
import 'package:roadzen/listeners/MessageNotifier.dart';
import 'package:roadzen/mixin/message_notifier_mixin.dart';
import 'package:roadzen/models/fakedetailsgeneratorbloc.dart';
import 'package:roadzen/models/familymodel.dart';
import 'package:roadzen/register/familyregistrationbloc.dart';
import 'package:roadzen/splashscreen/timerdurationbloc.dart';



final bottomBarStatusProvider = ChangeNotifierProvider<BottomBarStatusBloc>((ref) {
  return BottomBarStatusBloc();
});

final fakeDetailsProvider = ChangeNotifierProvider.autoDispose<FakeDetailsGeneratorBloc>((ref) {
  return FakeDetailsGeneratorBloc();
});

final counterProvider = ChangeNotifierProvider.autoDispose<QuantityBloc>((ref) => QuantityBloc());

final homeScreenProvider = ChangeNotifierProvider<HomeScreenBloc>((ref){

  return HomeScreenBloc();
});

final durationProvider = ChangeNotifierProvider.autoDispose<TimerDurationBloc>((ref) {
  return TimerDurationBloc();
});

final registrationProvider = ChangeNotifierProvider.autoDispose<FamilyRegistrationBloc>((ref) {
  return FamilyRegistrationBloc();
});

final messagesProvider = ChangeNotifierProvider.autoDispose<MessageNotifier>((ref) {
  return MessageNotifier();
});
