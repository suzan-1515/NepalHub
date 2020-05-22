import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/dto/dto.dart';

class NewsSourceItem extends StatelessWidget {
  NewsSourceItem({
    Key key,
    @required this.context,
    @required this.source,
  }) : super(key: key);

  final BuildContext context;
  final FeedSource source;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: source.icon ?? '',
                placeholder: (context, url) => Icon(FontAwesomeIcons.spinner),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Spacer(),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4),
                child: Text(
                  source.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget child) {
                return GestureDetector(
                  onTap: () {
                    source.enabled.value = !value;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(100, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight
                      ),
                    ),
                    child: value
                        ? Icon(
                            FontAwesomeIcons.solidCheckCircle,
                            color: Colors.green,
                          )
                        : Icon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.grey,
                          ),
                  ),
                );
              },
              valueListenable: source.enabled,
            ),
          ),
        ],
      ),
    );
  }
}
