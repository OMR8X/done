import 'package:done/core/resources/assets_manager.dart';
import 'package:done/core/widgets/buttons/circular_button.dart';
import 'package:flutter/material.dart';

import '../../3_home/view/home_view.dart';
import '../../4_analysis/view/analysis_view.dart';

class PagesHolder extends StatefulWidget {
  const PagesHolder({super.key});

  @override
  State<PagesHolder> createState() => _PagesHolderState();
}

class _PagesHolderState extends State<PagesHolder> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (a) => setState(() {
            currentPage = a;
          }),
          physics: const BouncingScrollPhysics(),
          children: const [HomeView(), AnalysisView()],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomTapBar(
            currentPage: currentPage,
            onPress: (int page) {
              pageController.jumpToPage(
                page,
              );
              setState(() {});
            },
          ),
        ),
      ],
    ));
  }
}

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({
    super.key,
    required this.onPress,
    required this.currentPage,
  });
  final Function(int page) onPress;
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border:
                Border(top: BorderSide(color: Theme.of(context).dividerColor))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularButton(
              hide: true,
              svgPath: UIAssetsManger.homeIcon,
              isSelected: currentPage == 0,
              onPress: () {
                onPress(0);
              },
            ),
            CircularButton(
                hide: true,
                svgPath: UIAssetsManger.analysIcon,
                isSelected: currentPage == 1,
                onPress: () {
                  onPress(1);
                }),
          ],
        ));
  }
}
