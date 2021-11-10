import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:roadzen/models/fakedetails.dart';
import 'dart:developer' as developer;

class FakeDetailsGeneratorBloc extends ChangeNotifier{

  FakeDetails? fakeDetails;

  String TAG = "FakeDetailsGeneratorBloc";
  Faker? faker;
  int totalMembers = 0;

  void generateFakeDetails(){
    faker = new Faker();
    int min = 21;
    int max = 60;
    Random rnd = new Random();
    int age = min + rnd.nextInt(max - min);
    fakeDetails = FakeDetails(personFakeName:  faker!.person.name(), personFakeFirstName: faker!.person.firstName(), personFakeLastName: faker!.person.lastName()+"s", personFakeAge:  age);
    developer.log(TAG, name:  "Fake details generated with ${faker!.person.name()} and age $age");
    notifyListeners();
  }

}