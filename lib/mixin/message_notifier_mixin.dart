import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

/// mixin to be user on a [ChangeNotifier] class
/// It provides two fields [error] and [info] and two methods [notifyError] and [notifyInfo]
/// Useful used in combination with [MessageListener] to display error or information messages to users
mixin MessageNotifierMixin on ChangeNotifier {
  String TAG = "MessageNotifierMixin";
  String? _error;
  String? get error => _error;

  String? _info;
  String? get info => _info;

  void notifyError(String error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
  }

  void notifyInfo(String info) {
    developer.log(TAG, name : "Info received $info");
    _info = info;
    notifyListeners();
  }

  void clearInfo() {
    _info = null;
  }

}