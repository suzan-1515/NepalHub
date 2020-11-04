import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsMenuItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;

  const NewsMenuItem(
      {Key key,
      @required this.title,
      @required this.icon,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[100], shape: BoxShape.circle),
                  child: TransitionToImage(
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                    placeholder: Icon(FontAwesomeIcons.image),
                    loadingWidgetBuilder: (context, progress, imageData) =>
                        CircularProgressIndicator(
                      value: progress,
                    ),
                    image: AdvancedNetworkImage(
                      icon,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
