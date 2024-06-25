part of "widgets.dart";

class AppRefresher extends StatelessWidget {
  final RefreshController controller;
  final bool enablePullUp;
  final Function()? onRefresh;
  final Function()? onLoading;
  final Widget? child;
  const AppRefresher({
    super.key,
    required this.controller,
    this.enablePullUp = false,
    this.onRefresh,
    this.onLoading,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: true,
      enablePullUp: enablePullUp,
      header: const MaterialClassicHeader(color: AppColors.primary),
      onRefresh: onRefresh,
      onLoading: onLoading,
      physics: const ScrollPhysics(),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.loading) {
            body = const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (mode == LoadStatus.failed) {
            body = const TextLabel(
              text: "Load failed, try again",
            );
          } else if (mode == LoadStatus.noMore) {
            body = const TextLabel(
              text: "No more data",
            );
          } else {
            body = const SizedBox();
          }
          return Center(child: body);
        },
      ),
      child: child,
    );
  }
}
