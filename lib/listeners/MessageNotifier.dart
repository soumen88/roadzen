import 'package:flutter/material.dart';
import 'package:roadzen/mixin/message_notifier_mixin.dart';

class MessageNotifier extends ChangeNotifier with MessageNotifierMixin {

  List<String> _properties = [];
  List<String> get properties => _properties;

  Future<void> load() async {
    try {
      /// Do some network calls or something else
      await Future.delayed(Duration(seconds: 1), (){

        _properties = ["Item 1", "Item 2", "Item 3"];
        notifyInfo('Successfully called load() method');

      });
    }
    catch(e) {
      notifyError('Error calling load() method');
    }

  }

}