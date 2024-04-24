import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rabble/core/config/export.dart';

class RabbleImageLoader extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  bool isRound = false;
  double? roundValue;

  RabbleImageLoader(
      {Key? key,
      required this.imageUrl,
      this.fit,
      required this.isRound,
      this.roundValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: isRound
              ? const BorderRadius.all(Radius.circular(50))
              : const BorderRadius.all(Radius.zero),
          color: Colors.white,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),

        ),
      ),
      placeholder: (context, url) => Container(
        decoration: !isRound
            ? const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: APPColors.appWhite,
              )
            : const BoxDecoration(
                shape: BoxShape.circle,
                color: APPColors.bg_grey,
              ),
        child: const CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: !isRound
            ? const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: APPColors.bg_grey,
              )
            : const BoxDecoration(
                shape: BoxShape.circle,
                color: APPColors.bg_grey,
              ),
        child: Icon(
          Icons.error,
          size: roundValue ?? 40,
        ),
      ),
    );
  }
}
