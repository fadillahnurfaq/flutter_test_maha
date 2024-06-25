import 'package:flutter/material.dart';
import 'package:flutter_test_maha/controllers/home/home_cubit.dart';
import 'package:flutter_test_maha/models/response_model.dart';
import 'package:flutter_test_maha/models/user_model.dart';
import 'package:flutter_test_maha/services/user_service.dart';
import 'package:flutter_test_maha/utils/app_text_style.dart';
import 'package:flutter_test_maha/utils/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(UserService())..getList(),
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: TextLabel(
              text: "DATA PENGGUNA",
              textStyle: AppTextStyle.h1,
            ),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.response != current.response,
            builder: (context, state) {
              return AppRefresher(
                controller: context.read<HomeCubit>().refreshController,
                onRefresh: () async =>
                    await context.read<HomeCubit>().getList(),
                child: WidgetAnimator<ResponseModel<List<UserModel>>>(
                  requestState: state.response,
                  successWidget: (result) {
                    return ListView.separated(
                      itemCount: result.data?.length ?? 0,
                      padding: const EdgeInsets.all(16.0),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const VerticalGap10(),
                      itemBuilder: (context, index) {
                        final UserModel? data = result.data?[index];
                        return AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatorAvatarCachedImage(
                                url: data?.avatar ?? "",
                                radius: 50,
                              ),
                              const VerticalGap5(),
                              ExpandedView2Row(
                                flex1: 30,
                                flex2: 70,
                                child1: const TextLabel(text: "ID"),
                                child2: TextLabel(
                                  text: "${data?.id ?? ""}",
                                ),
                              ),
                              ExpandedView2Row(
                                flex1: 30,
                                flex2: 70,
                                child1: const TextLabel(text: "Full Name"),
                                child2: TextLabel(
                                  text:
                                      "${data?.firstName ?? ""}${data?.firstName.isNotEmpty == true ? " " : ""}${data?.lastName ?? ""}",
                                ),
                              ),
                              ExpandedView2Row(
                                flex1: 30,
                                flex2: 70,
                                child1: const TextLabel(text: "Email"),
                                child2: TextLabel(
                                  text: data?.email ?? "",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
