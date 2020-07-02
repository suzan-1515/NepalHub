import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsSourceSelectionItem extends StatefulWidget {
  final String name;
  final String icon;
  final Function(bool) onTap;
  final bool isSelected;
  NewsSourceSelectionItem({
    Key key,
    @required this.icon,
    @required this.onTap,
    @required this.isSelected,
    @required this.name,
  }) : super(key: key);

  @override
  _NewsSourceSelectionItemState createState() =>
      _NewsSourceSelectionItemState();
}

class _NewsSourceSelectionItemState extends State<NewsSourceSelectionItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          widget.onTap(isSelected);
        },
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: widget.icon ?? '',
                    placeholder: (context, url) =>
                        Icon(FontAwesomeIcons.spinner),
                    errorWidget: (context, url, error) =>
                        Opacity(opacity: 0.7, child: Icon(Icons.error)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: isSelected
                  ? Icon(
                      FontAwesomeIcons.solidCheckCircle,
                      color: Colors.green,
                    )
                  : Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
