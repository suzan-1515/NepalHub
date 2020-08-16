import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';

extension SnackBarX on BuildContext {
  showMessage(String message) => Scaffold.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}

extension SnackBarX2 on ScaffoldState {
  showMessage(String message) => this
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}

extension APIErrorDialogX on BuildContext {
  showErrorDialog(APIException apiError) => showDialog<void>(
        context: this,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(apiError: apiError);
        },
      );
}

extension ModalBottonSheetX on BuildContext {
  showBottomSheet({@required Widget child, ShapeBorder shape}) =>
      showModalBottomSheet(
          context: this,
          shape: shape,
          builder: (context) {
            return child;
          });
}
