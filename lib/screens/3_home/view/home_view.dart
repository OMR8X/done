import 'package:done/cubit/cubit/app_data_holder_cubit.dart';
import 'package:done/screens/5_studying/view/start_studying.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/buttons/circular_button.dart';
import '../../../core/widgets/spacers.dart';
import '../widgets/advice_box_widget.dart';
import '../widgets/lottie_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() async {
    await context.read<AppDataHolderCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" الشاشة الرئيسية"),
      ),
      body: Column(
        children: [
          const HomeViewLottieWidget(),
          const MainSpacer(),
          const AdviceBoxWidget(),
          const MainSpacer(spacerType: SType.twiceMain),
          CircularButton(
            onPress: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => const StartStudyingView()))
                  .then((value) {
                context.read<AppDataHolderCubit>().init();
              });
            },
          )
        ],
      ),
    );
  }
}
