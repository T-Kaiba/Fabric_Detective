import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/chi_styles.dart';

class CHIBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<Widget> widgets;
  final List<String> icons;
  final List<String> labels;
  final int totalCount;
  final void Function(int)? itemChanged;
  const CHIBottomNavigationBar(
      {super.key,
      required this.currentIndex,
      this.itemChanged,
      required this.widgets,
      required this.icons,
      required this.labels,
      this.totalCount = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      selectedItemColor: CHIStyles.primaryColor,
      unselectedItemColor: CHIStyles.primaryTextColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: itemChanged,
      items: [
        for (int item = 0; item < widgets.length; item++) ...{
          BottomNavigationBarItem(
            icon: (item == 3 && totalCount > 0)
                ? Badge(
                    label: Text(
                      totalCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: SvgPicture.asset(icons[item],
                        color: CHIStyles.primaryTextColor),
                  )
                : SvgPicture.asset(icons[item],
                    color: CHIStyles.primaryTextColor),
            label: labels[item],
            activeIcon: (item == 3 && totalCount > 0)
                ? Badge(
                    label: Text(
                      totalCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: SvgPicture.asset(icons[item],
                        color: CHIStyles.primaryColor))
                : SvgPicture.asset(icons[item], color: CHIStyles.primaryColor),
          )
          // BottomNavigationBarItem(
          //   icon: Stack(children: [
          //     SvgPicture.asset(icons[item], color: CHIStyles.primaryTextColor),
          //     if (item == 3 && totalCount > 0)
          //       Positioned(
          //         top: -2,
          //         right: -2,
          //         child: Container(
          //           padding: const EdgeInsets.all(4),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.red,
          //           ),
          //           child: Align(
          //             alignment: Alignment.center,
          //             child: Text(
          //               totalCount.toString(),
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 8,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //   ]),
          //   label: labels[item],
          //   activeIcon: Stack(children: [
          //     SvgPicture.asset(icons[item], color: CHIStyles.primaryColor),
          //     if (item == 3 && totalCount > 0)
          //       Positioned(
          //         top: -4,
          //         right: -4,
          //         child: Container(
          //           padding: const EdgeInsets.all(4),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.red,
          //           ),
          //           child: Align(
          //             alignment: Alignment.center,
          //             child: Text(
          //               totalCount.toString(),
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 8,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //   ]),
          // )
        }
      ],
    );
  }
}
