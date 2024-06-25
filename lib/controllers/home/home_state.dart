part of 'home_cubit.dart';

class HomeState extends Equatable {
  final RequestState response;
  final String errorMessage;
  const HomeState({
    required this.response,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        response,
        errorMessage,
      ];
  factory HomeState.initial() {
    return HomeState(
      response: RequestStateInitial(),
      errorMessage: "",
    );
  }
  HomeState copyWith({
    RequestState? response,
    String? errorMessage,
  }) {
    return HomeState(
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
