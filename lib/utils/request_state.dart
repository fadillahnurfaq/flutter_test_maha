sealed class RequestState {}

class RequestStateInitial extends RequestState {}

class RequestStateLoading extends RequestState {}

class RequestStateEmpty extends RequestState {}

class RequestStateError extends RequestState {
  final String message;
  RequestStateError({
    required this.message,
  });
}

class RequestStateLoaded<T> extends RequestState {
  final T result;
  RequestStateLoaded({required this.result});
}
