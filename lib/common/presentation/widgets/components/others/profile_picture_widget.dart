import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

import '../../../presentation.dart';
class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    this.image,
    this.size = 48,
    this.borderWidth,
  });

  ProfilePictureWidget.network({
    super.key,
    String? imageUrl,
    this.size = 48,
    this.borderWidth,
  }) : image = imageUrl == null ? null : CachedNetworkImageProvider(imageUrl);

  final double size;
  final ImageProvider? image;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.of(context).grey4,
        border: borderWidth == null
            ? null
            : Border.all(
                color: AppColors.of(context).tertiaryColor, width: borderWidth!),
      ),
      clipBehavior: Clip.hardEdge,
      child: image != null
          ? Image(
              image: image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                Logger(runtimeType.toString()).severe(
                  'Failed to render profile image',
                  error,
                  stackTrace,
                );
                return Icon(
                  CupertinoIcons.person_alt,
                  size: size,
                  color: AppColors.of(context).grey2,
                );
              },
            )
          : Icon(
              CupertinoIcons.person_alt,
              size: size,
              color: AppColors.of(context).grey2,
            ),
    );
  }
}
