import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ezsale/core/common/actionable.dart';
import 'package:ezsale/core/common/app_exception.dart';
import 'package:ezsale/core/dialogs/show_error_dialog.dart';
import 'package:ezsale/core/widgets/progressable_state.dart';
import 'package:ezsale/core/common/future_action_callback.dart';

abstract class ProgressActionableState<T extends StatefulWidget>
    extends ProgressableState<T> implements Actionable {
  Future performAction(FutureActionCallback<BuildContext> action) async {
    setProgress(true);

    try {
      FocusScope.of(context).requestFocus(FocusNode());
      await action(context);
    } on AppException catch (error) {
      setProgress(false);

      await showErrorDialog(context, error.message ?? 'Unknown error occured');
    } on PlatformException catch (error) {
      setProgress(false);

      await showErrorDialog(context, error.details ?? 'Unknown error occured');
    } catch (error) {
      setProgress(false);

      await showErrorDialog(context, 'Unknown error occurred');
    } finally {
      await new Future.delayed(const Duration(milliseconds: 100), () {
        setProgress(false);
      });
    }
  }
}
