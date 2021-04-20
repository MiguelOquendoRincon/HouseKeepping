import './routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_kepping/src/preferences/preferences.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'House Kepping',
      theme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Color(0xFFF2874A6),
        backgroundColor: Colors.grey,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: 'home',
      routes: Routes.getRoutes()
    );
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences.getInstPref();
  await prefs.loadPrefs();
  runApp(MyApp());
}

