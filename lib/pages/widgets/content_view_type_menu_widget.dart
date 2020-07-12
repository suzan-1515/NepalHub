import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/util/content_view_type.dart';

class ViewTypePopupMenu extends StatelessWidget {
  const ViewTypePopupMenu({
    Key key,
    @required this.onSelected,
    @required this.selectedViewType,
  }) : super(key: key);

  final Function(ContentViewType) onSelected;
  final ContentViewType selectedViewType;

  Widget _popupMenuItem(icon, color, title, value) {
    return PopupMenuItem<ContentViewType>(
      value: value,
      child: Row(
        children: <Widget>[
          Icon(icon, color: color),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.65,
      child: SizedBox(
        height: 40,
        width: 40,
        child: PopupMenuButton<ContentViewType>(
          icon: Icon(FontAwesomeIcons.ellipsisV),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<ContentViewType>>[
            _popupMenuItem(
                FontAwesomeIcons.list,
                selectedViewType == ContentViewType.LIST_VIEW
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                'List View',
                ContentViewType.LIST_VIEW),
            _popupMenuItem(
                FontAwesomeIcons.addressCard,
                selectedViewType == ContentViewType.THUMBNAIL_VIEW
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                'Thumbnail View',
                ContentViewType.THUMBNAIL_VIEW),
            _popupMenuItem(
                FontAwesomeIcons.image,
                selectedViewType == ContentViewType.COMPACT_VIEW
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                'Compact View',
                ContentViewType.COMPACT_VIEW),
          ],
        ),
      ),
    );
  }
}
