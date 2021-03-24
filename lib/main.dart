import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import './Models/task.dart';
import './Screens/Addtask.dart';
import './Screens/SplashScreen.dart';
import './Screens/taskpage.dart';
import './Config/config.dart';
import './Screens/Homepage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initalizationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initalizationSettings =
      InitializationSettings(android: initalizationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initalizationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(Tasks())); //keep the app always in portrait mode
}

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: TaskTodo())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do',
        theme: ThemeData(
          accentColor: taskColor,
          primaryColor: taskColor,
        ),
        home: Homepage(),
        routes: {
          SplashScreen.routename: (ctx) => SplashScreen(),
          Homepage.routename: (ctx) => Homepage(),
          TaskPage.routename: (ctx) => TaskPage(),
          AddTask.routename: (ctx) => AddTask(),
        },
      ),
    );
  }
}
