part of "widgets.dart";

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        "assets/empty.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String message;
  const ErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            size: 35.0,
            color: AppColors.primary,
          ),
          const VerticalGap10(),
          TextLabel(
            text: message,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}

class WidgetAnimator<T> extends StatelessWidget {
  final RequestState requestState;
  final Widget loadingWidget;
  final Widget Function(T result) successWidget;
  final Widget Function(String message)? customErrorWidget;
  final Widget emptyWidget;
  final Widget initialWidget;

  const WidgetAnimator({
    super.key,
    required this.requestState,
    required this.successWidget,
    this.loadingWidget = const LoadingWidget(),
    this.customErrorWidget,
    this.emptyWidget = const EmptyWidget(),
    this.initialWidget = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return _getChild();
  }

  _getChild() {
    if (requestState is RequestStateLoaded) {
      final result = (requestState as RequestStateLoaded<T>).result;
      return successWidget(result);
    } else if (requestState is RequestStateError) {
      final message = (requestState as RequestStateError).message;
      return ErrorWidget(message: message);
    } else if (requestState is RequestStateInitial) {
      return initialWidget;
    } else if (requestState is RequestStateEmpty) {
      return emptyWidget;
    } else if (requestState is RequestStateLoading) {
      return loadingWidget;
    } else {
      return const SizedBox();
    }
  }
}
