import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsCategorySelectionItem extends StatefulWidget {
  final String name;
  final IconData icon;
  final Function(bool) onTap;
  final bool isSelected;
  NewsCategorySelectionItem({
    Key key,
    @required this.icon,
    @required this.onTap,
    @required this.isSelected,
    @required this.name,
  }) : super(key: key);

  @override
  _NewsCategorySelectionItemState createState() =>
      _NewsCategorySelectionItemState();
}

class _NewsCategorySelectionItemState extends State<NewsCategorySelectionItem> {
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
                  child: Center(
                      child: Icon(
                    widget.icon,
                    size: 32,
                    color: Theme.of(context).accentColor,
                  )),
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
