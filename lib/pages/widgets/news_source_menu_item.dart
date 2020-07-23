import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/models/models.dart';

class NewsSourceMenuItem extends StatelessWidget {
  final NewsSource source;
  final Function onTap;

  const NewsSourceMenuItem(
      {Key key, @required this.source, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => onTap(source),
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
                  child: CachedNetworkImage(
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                    imageUrl: source.favicon,
                    placeholder: (context, _) => Icon(FontAwesomeIcons.image),
                    errorWidget: (context, url, error) => Icon(
                      FontAwesomeIcons.image,
                      color: Colors.black12,
                    ),
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                source.name,
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
