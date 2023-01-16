import 'package:chat_app/services/global.dart';
import 'package:chat_app/services/instance.dart';
import 'package:chat_app/ui/screens/home_screen.dart';
import 'package:chat_app/ui/screens/welcome.dart';
import 'package:chat_app/ui/themes/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Request.init(BASE_URL);
  bool isLoggin = await Request.isAuthenticated();
  runApp(MyApp(isLoggin: isLoggin));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLoggin}) : super(key: key);

  final bool isLoggin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jioni Chat',
      theme: customTheme,
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/welcome': (context) => const WelcomePage(),
      },
      initialRoute: isLoggin ? '/home' : '/welcome',
    );
  }
}
