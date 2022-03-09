import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/dash_board_screen.dart';
import 'package:responsive_admin_dashboard/screens/audio/audio_main.dart';
import 'package:responsive_admin_dashboard/screens/users/user_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAP-5Tbc4CxouX6FPjCEuTSrz-y1mwk0s8",
      appId: "1:735665091280:web:4ae1830ca3a7cdeecf24d5",
      projectId: "mission-k3-4f577",
      storageBucket: "mission-k3-4f577.appspot.com",
      messagingSenderId: "735665091280",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Controller>(
        create: (context) => Controller(),
        child: GetMaterialApp(
          title: 'Responsive Admin Dashboard',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: DashBoardScreen(),
        ));
  }
}
