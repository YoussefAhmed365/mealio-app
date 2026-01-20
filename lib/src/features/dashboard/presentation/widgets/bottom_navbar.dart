import 'package:flutter/material.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final String currentPageRoute;
  final links = [
    {"name": "Home", "activeIcon": Icons.home_rounded, "icon": Icons.home_outlined, "route": "/home"},
    {"name": "Weekly Plans", "activeIcon": Icons.calendar_today_rounded, "icon": Icons.calendar_today_rounded, "route": "/plans"},
    {"name": "Recipes", "activeIcon": Icons.flatware_rounded, "icon": Icons.flatware_outlined, "route": "/recipes"},
    {"name": "Shopping List", "activeIcon": Icons.shopping_bag_rounded, "icon": Icons.shopping_bag_outlined, "route": "/shoping-list"},
    {"name": "Discover Recipes", "activeIcon": Icons.chat_bubble_rounded, "icon": Icons.chat_bubble_outline_rounded, "route": "/discover"},
    {"name": "Nutrition Analysis", "activeIcon": Icons.bar_chart_rounded, "icon": Icons.bar_chart_outlined, "route": "/analysis"},
  ];

  BottomNavBar({super.key, required this.currentPageRoute});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.amber600,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 20), blurRadius: 20)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            links.length,
                (index) =>
            (IconButton(
              onPressed: () {
                router.pushNamed(links[index]["route"] as String);
              },
              icon: Icon((links[index]["route"] == currentPageRoute ? links[index]["activeIcon"] : links[index]["icon"]) as IconData?, color: Colors.white, size: 26,),
            )),
          ),
        ),
      ),
    );
  }
}
