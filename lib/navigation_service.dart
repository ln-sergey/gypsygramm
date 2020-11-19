import 'package:flutter/material.dart';

abstract class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState;
}
