import 'package:flutter/material.dart';

import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/spacers.dart';

class AdviceBoxWidget extends StatelessWidget {
  const AdviceBoxWidget({
    super.key,
    this.content,
    this.title,
  });
  final String? content, title;

  @override
  Widget build(BuildContext context) {
    String initContent = "ركز على كمية الدراسة وليست فترة الدراسة";
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainSpacer(
            axisDirection: Axis.horizontal,
            spacerType: SType.inf,
          ),
          Text(title ?? "نصيحة", style: Theme.of(context).textTheme.titleSmall),
          const MainSpacer(spacerType: SType.halfMain),
          Text(
            content ?? initContent,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
