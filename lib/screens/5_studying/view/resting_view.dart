import 'package:done/core/widgets/spacers.dart';
import 'package:done/screens/5_studying/cubit/cubit/studying_manager_cubit.dart';
import 'package:done/screens/5_studying/view/session_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../3_home/widgets/lottie_widget.dart';

class RestingView extends StatelessWidget {
  const RestingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("استراحة"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const HomeViewLottieWidget(),
          const MainSpacer(spacerType: SType.twiceMain),
          CustomButtonWidget(
            text: "اكمال الجلسة الدراسية",
            bType: ButtonType.border,
            onTap: () {
              context.read<StudyingManagerCubit>().startStudying();
            },
          ),
        ],
      ),
    );
  }
}
