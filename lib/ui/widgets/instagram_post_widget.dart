import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/utils/app_assets.dart';

class SelectImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final String count;
  final void Function()? onTap;
  final String? countInfo;
  final double iconSize;

  const SelectImageWidget({
    Key? key,
    required this.imageUrl,
    required this.isSelected,
    required this.count,
    this.onTap,
    this.countInfo,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              if (isSelected) ...[
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(4, 4, 4, 0.6),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    selectIcon(),
                    const SizedBox(height: 5),
                    Text(
                      count,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget selectIcon() {
    switch (countInfo?.toLowerCase()) {
      case 'likes':
      case 'auto-likes':
      case 'page likes':
      case 'post likes':
        return Icon(
          Icons.favorite,
          color: Colors.white,
          size: iconSize,
        );
      case 'followers':
      case 'playlist followers':
      case 'group followers':
        return Icon(
          Icons.groups,
          color: Colors.white,
          size: iconSize,
        );
      case 'views':
        return Icon(
          Icons.visibility,
          color: Colors.white,
          size: iconSize,
        );
      case 'comments':
        return SvgPicture.asset(
          AppAssets.commentIcon,
          width: iconSize,
          height: iconSize,
        );
    }
    return const SizedBox();
  }
}
