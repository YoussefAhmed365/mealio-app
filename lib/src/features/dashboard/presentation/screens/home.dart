import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/widgets/button.dart';
import 'package:mealio/src/features/authentication/domain/entities/user.dart';
import 'package:mealio/src/features/dashboard/presentation/widgets/app_bar.dart';
import 'package:mealio/src/features/dashboard/presentation/widgets/bottom_navbar.dart';
import 'package:heroicons/heroicons.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;

  const HomeScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todayMeals = [
    {"title": "Red Bread & Jam", "image": "assets/images/food/red-bread-jam.jpg", "time": "6m", "calories": "250cal"},
    {"title": "Grilled Chicken", "image": "assets/images/food/grilled-chicken.jpg", "time": "~1h", "calories": "30k"},
    {"title": "Cashew Nut Salad", "image": "assets/images/food/cashew-nut-salad.jpg", "time": "15m", "calories": "150cal"},
  ];

  final List<Map<String, dynamic>> weekPlan = [
    {"date": "18", "day": "SAT", "background": AppColors.amber100, "color": AppColors.amber400, "title": "Oatmeal with berries", "calories": "250Kcal", "time": "30m"},
    {"date": "19", "day": "SUN", "background": AppColors.blue100, "color": AppColors.blue400, "title": "Chicken Salad", "calories": "300Kcal", "time": "45m"},
    {"date": "20", "day": "MON", "background": AppColors.green100, "color": AppColors.green400, "title": "Roasted Vegetables", "calories": "400Kcal", "time": "60m"},
    {"date": "21", "day": "TUE", "background": AppColors.indigo100, "color": AppColors.indigo400, "title": "Lintil Soup", "calories": "200Kcal", "time": "35m"},
  ];

  final List<Map<String, String>> ingredients = [
    {"ingedient": "Tomato", "sort": "Vegetables", "quantity": "3 pcs"},
    {"ingedient": "Chicken", "sort": "Meat", "quantity": "500 g"},
    {"ingedient": "Salt", "sort": "Spices", "quantity": "200 g"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(user: widget.user),
      bottomNavigationBar: BottomNavBar(currentPageRoute: "/home"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                "Hi, ${widget.user.firstname}!",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, color: AppColors.stone800),
              ),
              const SizedBox(height: 8),
              Text(
                "What's on the menu today?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.gray500, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 30),

              // AI Generate Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(colors: [AppColors.amber400, AppColors.amber600], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: AppColors.amber600.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "Start Generating Your Meals of The Week.",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            "Personalized meal plans tailored to your preferences with AI.",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Button(text: "Generate With AI", onPressed: () {}, textColor: AppColors.amber700, fontSize: Theme.of(context).textTheme.labelLarge, isFullWidth: false, padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), backgroundColor: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Today's Selected Meal
              Text(
                "Your Meal Today",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: AppColors.stone800),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 330,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: todayMeals.length + 1,
                  itemBuilder: (context, index) {
                    Color color;
                    Color borderColor;
                    Color imageBorderColor;
                    switch ((index + 2) % 3) {
                      case 0:
                        color = AppColors.red50;
                        borderColor = AppColors.red100;
                        imageBorderColor = AppColors.red200;
                        break;
                      case 1:
                        color = AppColors.green50;
                        borderColor = AppColors.green100;
                        imageBorderColor = AppColors.gray200;
                        break;
                      case 2:
                        color = AppColors.blue50;
                        borderColor = AppColors.blue100;
                        imageBorderColor = AppColors.blue200;
                        break;
                      default:
                        color = AppColors.amber50;
                        borderColor = AppColors.amber100;
                        imageBorderColor = AppColors.amber200;
                        break;
                    }
                    if (index == 0) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(right: 12),
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.amber50,
                          border: Border.all(color: AppColors.amber100, width: 3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              width: 78,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.amber200),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "13",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.amber600, fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Mon",
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.amber600, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Spagitte With Meat Balls",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.stone800, fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("Italian Cuisine • 45 mins", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray500)),
                                  const SizedBox(height: 4),
                                  Text("Ingredients: 1/2Kg Meat, Spaghetti, Salt", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray500)),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              HeroIcon(HeroIcons.clock, color: AppColors.gray500, size: 18, style: HeroIconStyle.outline),
                                              Text("30m", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.gray500)),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Row(
                                            children: [
                                              HeroIcon(HeroIcons.fire, color: AppColors.gray500, size: 18, style: HeroIconStyle.solid),
                                              Text("50k", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.gray500)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Button(text: "Details", onPressed: () {}, textColor: AppColors.amber800, backgroundColor: AppColors.yellow400, isFullWidth: false, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final int dataIndex = index - 1;
                    final Map<String, String> data = todayMeals[dataIndex];

                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(right: 12),
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: color,
                        border: Border.all(color: borderColor, width: 3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                              border: Border.all(color: imageBorderColor, width: 5),
                              image: DecorationImage(image: AssetImage(data["image"]!), fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data["title"]!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.stone800, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  HeroIcon(HeroIcons.clock, color: AppColors.gray500, size: 18, style: HeroIconStyle.outline),
                                  Text(data["time"]!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.gray500)),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  HeroIcon(HeroIcons.fire, color: AppColors.gray500, size: 18, style: HeroIconStyle.solid),
                                  Text(data["calories"]!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.gray500)),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Button(text: "See Recipe", onPressed: () {}, type: ButtonType.outline, padding: EdgeInsets.symmetric(vertical: 8), textColor: AppColors.amber600, borderColor: AppColors.amber600, borderWidth: 2),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Meal Plan This Week",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: AppColors.stone800),
                  ),
                  Button(
                    text: "View",
                    onPressed: () {},
                    type: ButtonType.text,
                    icon: HeroIcon(HeroIcons.calendarDays, style: HeroIconStyle.solid, size: 24),
                    textColor: AppColors.amber600,
                    fontSize: Theme.of(context).textTheme.bodyLarge,
                    isFullWidth: false,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: weekPlan.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 20, // المسافة الكلية للفاصل
                      thickness: 1, // سمك الخط نفسه
                      color: AppColors.slate100, // لون الخط الفاصل (رمادي فاتح جداً)
                    );
                  },
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> data = weekPlan[index];
                    return Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(color: data["background"], borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data["day"],
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: data["color"], fontVariations: <FontVariation>[FontVariation('wght', 900)]),
                              ),
                              Text(
                                data["date"],
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: data["color"], fontVariations: <FontVariation>[FontVariation('wght', 900)]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["title"],
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.stone800, fontVariations: <FontVariation>[FontVariation('wght', 700)]),
                            ),
                            Text(
                              "${data['calories']} • ${data['time']}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.stone400, fontVariations: <FontVariation>[FontVariation('wght', 600)]),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: HeroIcon(HeroIcons.pencil, style: HeroIconStyle.solid, size: 18, color: AppColors.gray400),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Ingredients",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: AppColors.stone800),
                  ),
                  Button(
                    text: "Add",
                    onPressed: () {},
                    type: ButtonType.text,
                    icon: HeroIcon(HeroIcons.plusSmall, style: HeroIconStyle.solid, size: 24),
                    textColor: AppColors.amber600,
                    fontSize: Theme.of(context).textTheme.bodyLarge,
                    isFullWidth: false,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.slate100),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: HeroIcon(HeroIcons.magnifyingGlass, color: AppColors.gray400, size: 20, style: HeroIconStyle.outline),
                    hintText: "Search ingredients...",
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.gray400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  const double spacing = 12;
                  final double itemWidth = (constraints.maxWidth - spacing) / 2;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: 12,
                    children: List.generate(ingredients.length + 1, (index) {
                      if (index < ingredients.length) {
                        // Existing ingredient items
                        final item = ingredients[index];
                        return SizedBox(
                          width: itemWidth,
                          height: itemWidth,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.slate100),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['ingedient']!,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.stone800, fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 6),
                                Text(item['sort']!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.stone400)),
                                const Spacer(),
                                Text(item['quantity']!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray500)),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // The 'Add Ingredient' button box
                        return SizedBox(
                          width: itemWidth,
                          height: itemWidth,
                          child: InkWell(
                            onTap: () {
                              // Handle add ingredient action
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.slate50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.slate300, width: 2),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    HeroIcon(
                                      HeroIcons.plus,
                                      style: HeroIconStyle.solid,
                                      size: 32,
                                      color: AppColors.slate500,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Add Ingredient",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.slate600,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
