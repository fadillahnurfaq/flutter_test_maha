part of "widgets.dart";

class PhotoPreview extends StatelessWidget {
  final File? photo;
  final String? url;
  const PhotoPreview({
    super.key,
    this.photo,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLabel(
          text: "Photo Preview",
          textStyle: AppTextStyle.h1,
        ),
      ),
      body: photo != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(photo!), fit: BoxFit.cover)),
            )
          : CachedNetworkImage(
              imageUrl: url!,
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (_, url) => SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              ),
              errorWidget: (_, url, error) => SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
    );
  }
}
