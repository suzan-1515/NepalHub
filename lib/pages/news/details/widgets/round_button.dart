import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    Key key,
    @required this.onTap,
    @required this.text,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkResponse(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
