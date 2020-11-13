import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

extension SnackBarX on BuildContext {
  showMessage(String message) => Flushbar(
        message: message,
        duration: Duration(seconds: 3),
        margin: const EdgeInsets.all(8.0),
        borderRadius: 6.0,
      )..show(this);
}

extension SnackBarX2 on ScaffoldState {
  showMessage(String message) => this
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}

extension ModalBottonSheetX on BuildContext {
  showBottomSheet({
    @required Widget child,
    ShapeBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
  }) =>
      showModalBottomSheet(
          context: this,
          shape: shape,
          isScrollControlled: true,
          builder: (context) {
            return child;
          });
}

extension DialogX on BuildContext {
  dialog({@required Widget child}) => showDialog(
      context: this,
      builder: (context) {
        return child;
      });
}
