import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ezsale/core/common/future_action_callback.dart';

abstract class Actionable {
  Future performAction(FutureActionCallback<BuildContext> action);
}
