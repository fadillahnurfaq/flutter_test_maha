import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_maha/services/user_service.dart';

import 'package:flutter_test_maha/utils/request_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserService _userService;
  HomeCubit(this._userService) : super(HomeState.initial());

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Future<void> getList() async {
    emit(state.copyWith(errorMessage: "", response: RequestStateLoading()));

    final result = await _userService.getAll();
    refreshController.refreshCompleted();
    result.fold((l) {
      emit(state.copyWith(
          errorMessage: l, response: RequestStateError(message: l)));
    }, (r) {
      emit(
        state.copyWith(
          response: (r.data == null)
              ? RequestStateEmpty()
              : RequestStateLoaded(result: r),
        ),
      );
    });
  }
}
