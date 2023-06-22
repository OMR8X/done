import 'package:done/core/widgets/custom_container.dart';
import 'package:done/core/widgets/spacers.dart';
import 'package:done/screens/5_studying/cubit/cubit/studying_manager_cubit.dart';
import 'package:done/screens/5_studying/widgets/timer_setter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/values_manager.dart';

class SessionSettingView extends StatefulWidget {
  const SessionSettingView({super.key});

  @override
  State<SessionSettingView> createState() => _SessionSettingViewState();
}

class _SessionSettingViewState extends State<SessionSettingView> {
  Duration studyingD = const Duration(minutes: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اعدادات الجلسة الدراسية"),
      ),
      body: Column(
        children: [
          CustomContainer(
            height: 110 + (SpacingManager.mainSpace * 2),
            disablePadding: true,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TimerSetterWidget(
                title: 'مدة الجلسة',
                maxIndex: 240,
                onChange: (i) {
                  studyingD = Duration(minutes: i);
                  setState(() {});
                },
              ),
              const MainSpacer(spacerType: SType.halfMain),
            ]),
          ),
          const MainSpacer(spacerType: SType.twiceMain),
          CustomButtonWidget(
            onTap: () {
              context.read<StudyingManagerCubit>().initTime(studyingD);
              context.read<StudyingManagerCubit>().startStudying();
            },
          )
        ],
      ),
    );
  }
}

enum ButtonType {
  filled,
  border,
}

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.onTap,
    this.text = "بدئ",
    this.bType = ButtonType.filled,
  });
  final VoidCallback onTap;
  final String text;
  final ButtonType bType;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: getSplashColor(context),
            backgroundColor: getButtonColor(context),
            fixedSize: Size(
              SpacingManager.mainWidth(context),
              45,
            )),
        onPressed: () {
          onTap();
        },
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white),
        ));
  }

  getButtonColor(BuildContext context) {
    switch (bType) {
      case ButtonType.filled:
        return Theme.of(context).primaryColor;
      case ButtonType.border:
        return Colors.transparent;
    }
  }

  getSplashColor(BuildContext context) {
    switch (bType) {
      case ButtonType.filled:
        return Colors.grey;
      case ButtonType.border:
        return Colors.grey;
    }
  }
}
