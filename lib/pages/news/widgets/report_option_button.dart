import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ReportOptionButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const ReportOptionButton({
    Key key,
    @required this.text,
    @required this.onTap,
  })  : assert(text != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(12),
        right: Radius.circular(12),
      )),
      visualDensity: VisualDensity.compact,
      onPressed: onTap,
      child: Text(text),
    );
  }
}
