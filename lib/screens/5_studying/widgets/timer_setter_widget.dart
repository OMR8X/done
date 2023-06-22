// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/resources/values_manager.dart';
import '../../../core/widgets/custom_container.dart';

enum TimeUnitType {
  s,
  m,
  h,
  d,
}

class TimerSetterWidget extends StatefulWidget {
  const TimerSetterWidget({
    super.key,
    this.title = "العنوان",
    this.timeUnitType = TimeUnitType.m,
    this.minIndex = 1,
    this.maxIndex = 60,
    required this.onChange,
  });
  final String title;
  final TimeUnitType timeUnitType;
  final int minIndex, maxIndex;
  final Function(int a) onChange;
  @override
  State<TimerSetterWidget> createState() => _TimerSetterWidgetState();
}

class _TimerSetterWidgetState extends State<TimerSetterWidget> {
  late Timer _timer;
  double time = 0;
  double size = 40;
  double maxSize = 50;
  @override
  void initState() {
    initTimer();
    super.initState();
  }

  trigger() {
    if (time >= 500) return;
    time += 120;
    setState(() {});
  }

  initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (time > 0) {
        time -= 60;
        size = maxSize;
        setState(() {});
      }
      if (time == 0) {
        size = 40;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 100,
      disableBorder: true,
      width: SpacingManager.mainWidth(context) - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Titiles(
            title: widget.title,
            type: widget.timeUnitType,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBoxWidget(size: size),
                TimeSelectorWidget(
                  maxIndex: widget.maxIndex,
                  minIndex: widget.minIndex,
                  onSelect: (a) {
                    trigger();
                    widget.onChange(a+1);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class AnimatedBoxWidget extends StatelessWidget {
  const AnimatedBoxWidget({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      curve: Curves.decelerate,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class TimeSelectorWidget extends StatefulWidget {
  const TimeSelectorWidget({
    super.key,
    required this.minIndex,
    required this.maxIndex,
    required this.onSelect,
  });
  final int minIndex, maxIndex;
  final Function(int a) onSelect;

  @override
  State<TimeSelectorWidget> createState() => _TimeSelectorWidgetState();
}

class _TimeSelectorWidgetState extends State<TimeSelectorWidget> {
  late Timer _timer;
  double time = 0;
  double scale = 1;
  double maxScale = 1.2;
  @override
  void initState() {
    initTimer();
    super.initState();
  }

  trigger() {
    if (time >= 500) return;
    time += 120;
    setState(() {});
  }

  initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (time > 0) {
        time -= 60;
        scale = maxScale;
        setState(() {});
      }
      if (time == 0) {
        scale = 1;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int length = (widget.maxIndex - widget.minIndex).abs() + 1;
    List<int> data = List.generate(length, (index) => widget.minIndex + index);
    return RotatedBox(
      quarterTurns: 1,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        perspective: 0.0013,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (value) {
          trigger();
          widget.onSelect(value);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: length,
          builder: (context, index) => SizedBox(
              width: 20,
              height: 20,
              child: RotatedBox(
                  quarterTurns: -1,
                  child: Center(
                    child: AnimatedScale(
                      scale: scale,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.decelerate,
                      child: Text(
                        "${data[index]}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class Titiles extends StatelessWidget {
  const Titiles({
    super.key,
    required this.title,
    required this.type,
  });
  final String title;
  final TimeUnitType type;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          getTimeUnit(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  String getTimeUnit() {
    switch (type) {
      case TimeUnitType.s:
        return "ثواني";
      case TimeUnitType.m:
        return "دقائق";
      case TimeUnitType.h:
        return "ساعات";
      case TimeUnitType.d:
        return "ايام";
    }
  }
}
