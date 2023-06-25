import 'dart:async';
import 'package:debato/componentes/dialogs.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService extends GetxService {

  late FirebaseAnalytics analytics;
  late FirebaseMessaging messaging;
  late FirebaseCrashlytics crashlytics;

  Future<FirebaseService> init() async {

    analytics   = FirebaseAnalytics.instance;
    messaging   = FirebaseMessaging.instance;
    crashlytics = FirebaseCrashlytics.instance;

    // habilita a coleta de crashlytics
    await crashlytics.setCrashlyticsCollectionEnabled(true);
    // Atualiza as opções de notificação em segundo plano
    await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    // solicita permissão para notificações
    await messaging.requestPermission(alert: true, announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true);
    // se inscreve no topico
    await messaging.subscribeToTopic('instalado');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) => onMessage(message));
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => onMessageOpenedApp(message));

    //FirebaseMessaging.onBackgroundMessage((RemoteMessage message) => onMessage(message));
    //FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

    return this;
  }

  void logEvent(String eventName) async{
    await analytics.logEvent(name: eventName);
  }

  void setScreen(String screenName) async{
    await analytics.setCurrentScreen(screenName: screenName);
  }

  void setUserIdentifier(String idUser) async{
    await crashlytics.setUserIdentifier(idUser);
  }

  void subscribeToTopic(String topicName) async{
    await messaging.subscribeToTopic(topicName);
  }

  void unsubscribeFromTopic(String topicName) async{
    await messaging.unsubscribeFromTopic(topicName);
  }
  void setCustomKeyCrashlytics(String key, String value) async{
    await crashlytics.setCustomKey(key, value);
  }

  Future onSelectNotification(String? payload) async {}

  Future<void> onMessage(RemoteMessage message) async {
    dialog(message);
  }

  Future<void> onMessageOpenedApp(RemoteMessage message) async {
    dialog(message);
  }

  Future<void> onBackgroundMessage(RemoteMessage message) async {
    dialog(message);
  }

  Future<String> getTokenFirebase() async{
    String token = await messaging.getToken() ?? "";
    return token;
  }

  Future<String> getAPNSTokenFirebase() async{
    String token = await messaging.getAPNSToken() ?? "";
    return token;
  }

  void dialog(RemoteMessage message) async {
    String titulo = message.notification?.title ?? "Debato";
    String mensagem = message.notification?.body ?? "";
    dialogPadrao(titulo: titulo, texto: mensagem);
  }

}

