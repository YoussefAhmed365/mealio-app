import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/widgets/button.dart';
import 'package:mealio/src/features/authentication/domain/entities/user.dart';

import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;

  const HomeScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentPageRoute: "/home"),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 24),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TopNav
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Meal',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.amber600, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          '.io',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.brown[700], fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none_rounded)),
                        HeroIcon(
                          HeroIcons.bell,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.amber600, width: 2),
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("assets/images/avatar.webp")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Search Bar
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.amber100,
                    border: Border.all(color: AppColors.amber400, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.gray400),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search anything',
                            border: InputBorder.none,
                            isDense: true,
                            hintStyle: TextStyle(color: AppColors.gray400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Advertise Container
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(image: AssetImage("assets/images/dashboard-bg.webp"), fit: BoxFit.cover),
                    gradient: LinearGradient(colors: [AppColors.amber300, AppColors.amber600]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Start Generating Your Meals of The Week.",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.amber800,
                          shadows: <Shadow>[Shadow(blurRadius: 20.0, color: Colors.white54)],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Discover the magic of effortless meal planning! Generate delicious, personalized meal plans tailored to your preferences with just one click.",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.gray600,
                          shadows: <Shadow>[Shadow(blurRadius: 20.0, color: Colors.white54)],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Button(text: "Generate With AI", onPressed: () {}, fontSize: Theme.of(context).textTheme.bodyLarge, isFullWidth: false, padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                    ],
                  ),
                ),

                // Today Meal Container
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: AppColors.amber100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              border: Border.all(color: AppColors.amber600, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "13",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.amber600, fontVariations: <FontVariation>[FontVariation('wght', 600)]),
                                ),
                                Text(
                                  "Mon",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.amber600, fontVariations: <FontVariation>[FontVariation('wght', 600)]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Your Meal Today",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.amber600, fontVariations: <FontVariation>[FontVariation('wght', 600)]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text("Spagitte With Meat Balls", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.gray400)),
                      const SizedBox(height: 20),
                      Text("Ingredients", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.gray400)),
                    ],
                  ),
                ),

                // Three Meals For Today
                const SizedBox(height: 30),

                // Table: Week Meal Plan
                const SizedBox(height: 30),

                // My Ingridents
                const SizedBox(height: 30),

                // Shopping List
                const SizedBox(height: 30),

                // Budget
                const SizedBox(height: 30),

                // Tracking
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Text("Name: ${widget.user.firstname} ${widget.user.lastname}!", style: Theme.of(context).textTheme.headlineMedium),
// Text("Email: ${widget.user.email}"),
// Button(
//  onPressed: () async {
//  await AuthService().logout();
//  },
//  icon: const Icon(Icons.logout, color: Colors.white),
//  text: "Logout",
//  isFullWidth: false,
// ),
