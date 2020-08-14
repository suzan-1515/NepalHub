import 'package:flutter/material.dart';

class CaseItem extends StatelessWidget {
  const CaseItem({
    Key key,
    @required this.context,
    @required this.todayCases,
    @required this.cases,
    @required this.higlightColor,
    @required this.textColor,
    @required this.label,
  }) : super(key: key);

  final BuildContext context;
  final int todayCases;
  final int cases;
  final Color higlightColor;
  final Color textColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: higlightColor,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30.0), right: Radius.circular(30.0))),
          child: Text(
            '+$todayCases',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: textColor),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '$cases',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: higlightColor, fontWeight: FontWeight.w700),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.caption.copyWith(
                color: higlightColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
