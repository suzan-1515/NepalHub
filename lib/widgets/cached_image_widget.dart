import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CachedImage extends StatelessWidget {
  CachedImage(this.imageURL, {this.tag});

  final String imageURL;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? UniqueKey(),
      child: TransitionToImage(
        image: AdvancedNetworkImage(
          imageURL,
          useDiskCache: true,
          cacheRule: CacheRule(maxAge: const Duration(days: 3)),
        ),
        fit: BoxFit.cover,
        loadingWidgetBuilder: (context, progress, imageData) => Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress,
              ),
              const Icon(FontAwesomeIcons.image, size: 16),
            ],
          ),
        ),
        placeholderBuilder: (context, reloadImage) => Opacity(
          opacity: 0.45,
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey[500],
            child: const Icon(FontAwesomeIcons.image, size: 32),
          ),
        ),
      ),
    );
  }
}
