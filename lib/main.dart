import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final _myTabbedPageKey = new GlobalKey();
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

