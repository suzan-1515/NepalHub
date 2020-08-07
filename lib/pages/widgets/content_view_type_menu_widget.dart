import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/utils/content_view_type.dart';

class ViewTypePopupMenu extends StatelessWidget {
  const ViewTypePopupMenu({
    Key key,
    @required this.onSelected,
    @required this.selectedViewType,
  }) : super(key: key);

  final Function(ContentViewStyle) onSelected;
  final ContentViewStyle selectedViewType;

  Widget _popupMenuItem(BuildContext context, icon, color, title, value) {
    return PopupMenuItem<ContentViewStyle>(
      value: value,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: Theme.of(context).textTheme.button.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: 0.65,
      child: SizedBox(
        height: 40,
        width: 40,
        child: PopupMenuButton<ContentViewStyle>(
          icon: Icon(
            FontAwesomeIcons.ellipsisV,
            size: 18,
          ),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<ContentViewStyle>>[
            _popupMenuItem(
                context,
                FontAwesomeIcons.list,
                selectedViewType == ContentViewStyle.LIST_VIEW
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                'List View',
                ContentViewStyle.LIST_VIEW),
            _popupMenuItem(
                context,
                FontAwesomeIcons.addressCard,
                selectedViewType == ContentViewStyle.THUMBNAIL_VIEW
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                'Thumbnail View',
                ContentViewStyle.THUMBNAIL_VIEW),
            _popupMenuItem(
                context,
                FontAwesomeIcons.image,
                selectedViewType == ContentViewStyle.COMPACT_VIEW
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                'Compact View',
                ContentViewStyle.COMPACT_VIEW),
          ],
        ),
      ),
    );
  }
}
