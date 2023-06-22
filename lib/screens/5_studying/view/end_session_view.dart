import 'package:done/core/resources/assets_manager.dart';
import 'package:done/core/widgets/custom_container.dart';
import 'package:done/core/widgets/spacers.dart';
import 'package:done/screens/5_studying/cubit/cubit/studying_manager_cubit.dart';
import 'package:done/screens/5_studying/view/session_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class EndSessionView extends StatefulWidget {
  const EndSessionView({super.key});

  @override
  State<EndSessionView> createState() => _EndSessionViewState();
}

class _EndSessionViewState extends State<EndSessionView>
    with TickerProviderStateMixin {
  late AnimationController animController;
  late Animation<Alignment> animation;
  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    animation = Tween<Alignment>(
            begin: const Alignment(0, 0), end: const Alignment(0, 0.75))
        .animate(
            CurvedAnimation(parent: animController, curve: Curves.easeInOut));
    animController.addListener(() {
      setState(() {});
    });
    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animController.forward();
      }
    });
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("انتهت الجلسة الدراسية"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
                child: AlignTransition(
              alignment: animation,
              child: LottieBuilder.asset(
                LottieManager.done,
                height: 250,
                width: 250,
                fit: BoxFit.contain,
                repeat: false,
              ),
            )),
            Expanded(
                child: CustomContainer(
              disableBorder: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonWidget(
                    onTap: () {
                      context.read<StudyingManagerCubit>().stop();
                    },
                    bType: ButtonType.filled,
                    text: 'جلسة دراسية جديدة',
                  ),
                  const MainSpacer(spacerType: SType.twiceMain),
                  CustomButtonWidget(
                    onTap: () {
                      context.read<StudyingManagerCubit>().stop();
                      Navigator.of(context).pop();
                    },
                    bType: ButtonType.border,
                    text: 'العودة للشاشة الرئيسية',
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
// foo transition => contaroller + animation