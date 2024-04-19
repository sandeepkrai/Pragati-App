import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack/Courses/Course_Home.dart';
import 'package:hack/Management/Management/provider.dart';
import 'package:hack/firebase/auth.dart';
import 'package:hack/pages/authenticate.dart';
import 'package:hack/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:hack/firebase_options.dart';
import 'harsh/lib/providers/cart_provider.dart';
import 'firebase_options.dart';
// FlutterFire's Firebase Cloud Messaging plugin
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO: Request permission
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('Permission granted: ${settings.authorizationStatus}');

  String? token = await messaging.getToken();
  print('Registration Token=$token');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Data(),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        StreamProvider<User?>(
          create: (context) {
            return AuthServices().userChanges;
          },
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of(context);

    // return const Authenticate();

    // To-Do: Uncomment for production
    if (user == null) {
      return const Authenticate();
    } else {
      return HomePage_Main();
    }
  }
}
