import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final String currentPageRoute;

  // Use a builder so each link can return the appropriate widget (HeroIcon or Icon)
  final List<Map<String, dynamic>> links = [
    {"name": "Home", "iconBuilder": (bool active) => HeroIcon(HeroIcons.home, style: active ? HeroIconStyle.solid : HeroIconStyle.outline, color: active ? AppColors.amber500 : AppColors.gray300, size: 24), "route": "/home"},
    {"name": "Plans", "iconBuilder": (bool active) => HeroIcon(HeroIcons.calendar, style: active ? HeroIconStyle.solid : HeroIconStyle.outline, color: active ? AppColors.amber500 : AppColors.gray300, size: 24), "route": "/plans"},
    {"name": "Recipes", "iconBuilder": (bool active) => Icon(Icons.flatware_outlined, color: active ? AppColors.amber500 : AppColors.gray300, size: 24), "route": "/recipes"},
    {"name": "Shop", "iconBuilder": (bool active) => HeroIcon(HeroIcons.calendar, style: active ? HeroIconStyle.solid : HeroIconStyle.outline, color: active ? AppColors.amber500 : AppColors.gray300, size: 24), "route": "/shoping-list"},
    {"name": "Discover", "iconBuilder": (bool active) => HeroIcon(HeroIcons.chatBubbleOvalLeft, style: active ? HeroIconStyle.solid : HeroIconStyle.outline, color: active ? AppColors.amber500 : AppColors.gray300, size: 24), "route": "/discover"},
    {"name": "Stats", "iconBuilder": (bool active) => HeroIcon(HeroIcons.chartBar, style: active ? HeroIconStyle.solid : HeroIconStyle.outline, color: active ? AppColors.amber500 : AppColors.gray300, size: 24), "route": "/analysis"},
  ];

  BottomNavBar({super.key, required this.currentPageRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, right: 10, left: 10),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        border: Border.all(color: AppColors.gray200, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          links.length,
          (index) => Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    router.goNamed(links[index]["route"] as String);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: (links[index]["route"] == currentPageRoute) ? BoxDecoration(color: AppColors.amber100, shape: BoxShape.circle) : null,
                    // Use the provided iconBuilder to render the correct widget for each entry
                    child: (links[index]["iconBuilder"] as Widget Function(bool))(links[index]["route"] == currentPageRoute),
                  ),
                ),
                Text(links[index]["name"], style: Theme.of(context).textTheme.labelMedium?.copyWith(color: links[index]["route"] == currentPageRoute ? AppColors.amber500 : AppColors.gray300, fontVariations: <FontVariation>[FontVariation("wght", 700)]), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
