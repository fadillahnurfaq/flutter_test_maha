part of 'widgets.dart';

class AnimatorAvatarCachedImage extends StatelessWidget {
  final String url;
  final double radius;
  const AnimatorAvatarCachedImage({
    super.key,
    required this.url,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoPreview(url: url),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: radius,
                    backgroundColor: AppColors.grey,
                    backgroundImage: imageProvider,
                  ),
                ),
            placeholder: (context, url) => CircleAvatar(
                  radius: radius,
                  backgroundColor: AppColors.grey,
                  child: const CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
            errorWidget: (context, url, error) {
              return CircleAvatar(
                radius: radius,
                backgroundColor: AppColors.grey,
                child: const Center(
                  child: Icon(Icons.error),
                ),
              );
            })
        : const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage("assets/images/photo-placeholder.png"),
          );
  }
}
