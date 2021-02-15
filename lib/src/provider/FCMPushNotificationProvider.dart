import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:io';
import 'dart:async';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<Map>.broadcast();
  Stream<Map> get mensajes => _mensajesStreamController.stream;

  initNotifications({bool admin = false}) {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.unsubscribeFromTopic('admin');
    //  _firebaseMessaging.subscribeToTopic('admin');
    if (admin) {
      _firebaseMessaging.subscribeToTopic('admin');
    }

    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      print(token);
    });

    _firebaseMessaging.configure(onMessage: (info) {
      print('======= On Message ========');
      print(info);

      String argumento = 'no-data';
      if (Platform.isAndroid) {
        print('android');

        argumento = info.toString();
        //  argumento = info['data']['comida'] ?? 'no-data';
      } else {
        //argumento = info['comida'] ?? 'no-data-ios';
        print('ios');

        argumento = info.toString();
      }

      _mensajesStreamController.sink.add(info);
    }, onLaunch: (info) {
      print('======= On Launch ========');
      print(info);
    }, onResume: (info) {
      print('======= On Resume ========');
      print(info);

      String argumento = 'no-data';

      if (Platform.isAndroid) {
        //  argumento = info['data']['comida'] ?? 'no-data';
        argumento = info.toString();

        print("android");
      } else {
        print('ios');

        //argumento = info['comida'] ?? 'no-data-ios';
      }

      _mensajesStreamController.sink.add(info);
    });
  }

  unsubscribeFromTopic() {
    _firebaseMessaging.unsubscribeFromTopic('admin');
  }

  dispose() {
    unsubscribeFromTopic();
    _mensajesStreamController?.close();
  }
}
