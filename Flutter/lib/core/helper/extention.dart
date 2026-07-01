// core/helper/extention.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension Navigattion on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtenton<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this == [];
}

extension MapExtenton<X, Y> on Map<X, Y>? {
  bool isNullOrEmpty() => this == null || this == {};
}
