



import 'package:flutter/material.dart';

class ContextUtil {
  late BuildContext? _context;
  set setContext(BuildContext? context) => _context = context;
  BuildContext? get context => _context;

  BuildContext? _routingContext;
  set setRoutingContext(BuildContext? context) => _routingContext = context;
  BuildContext? get routingContext => _routingContext;

  ContextUtil._privateConstructor();
  static final ContextUtil instance = ContextUtil._privateConstructor();
}