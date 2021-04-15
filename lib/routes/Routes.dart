import 'package:flutter/material.dart';
import 'package:house_kepping/src/views/prueba.dart';
import 'package:house_kepping/src/views/view.home.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() => <String, WidgetBuilder>{ 'home'    : (BuildContext context) => HomePage(), 'prueba': (BuildContext context) => MyHomePage()};
}