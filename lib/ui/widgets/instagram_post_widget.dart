import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/utils/app_assets.dart';

class SelectImageWidget extends StatelessWidget {
  final String imageUrl;
  final String? countInfo;
  final void Function()? onTap;
  final bool isSelected;
  final String count;

  const SelectImageWidget({
    Key? key,
    required this.imageUrl,
    this.onTap,
    this.countInfo,
    required this.isSelected,
    required this.count,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectIcon(),
                        const SizedBox(height: 6),
                        Text(
                          count,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
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
    switch (countInfo) {
      case 'Likes':
        return const Icon(Icons.favorite, color: Colors.white);
      case 'Views':
        return const Icon(Icons.visibility, color: Colors.white);
      case 'Comments':
        return SvgPicture.asset(AppAssets.commentIcon);
    }
    return const SizedBox();
  }
}
