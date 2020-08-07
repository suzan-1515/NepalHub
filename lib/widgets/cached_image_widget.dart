import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CachedImage extends StatelessWidget {
  CachedImage(this.imageURL, {this.tag});

  final String imageURL;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? UniqueKey(),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageURL ?? '',
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
              const Icon(FontAwesomeIcons.image, size: 16),
            ],
          ),
        ),
        errorWidget: (context, url, error) => AnimatedOpacity(
          opacity: 0.45,
          duration: const Duration(milliseconds: 200),
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
