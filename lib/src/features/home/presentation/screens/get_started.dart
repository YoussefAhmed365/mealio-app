import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';

class GetstartedScreen extends StatefulWidget {
  const GetstartedScreen({super.key});

  @override
  State<GetstartedScreen> createState() => _GetstartedScreenState();
}

class _GetstartedScreenState extends State<GetstartedScreen> {
  // PageController للتحكم في الصفحات (الانتقال والسحب)
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
          child: Column(
            children: [
              // --- رأس الصفحة: شعار التطبيق ---
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Meal',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber[800]),
                    ),
                    Text(
                      '.io',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown[700]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // --- مؤشر التقدم ---
              Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 4.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(color: _currentPage >= index ? Colors.amber[800] : secondaryTextColor?.withAlpha(77), borderRadius: BorderRadius.circular(2.0)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // --- محتوى الصفحات المتغيرة ---
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [_buildStepOne(), _buildStepTwo(), _buildStepThree()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ويدجت بناء الخطوة الأولى ---
  Widget _buildStepOne() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            'FROM CRAVINGS TO CALENDAR, SEAMLESSLY',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.amber[800], fontWeight: FontWeight.w600, fontSize: 12, fontFamily: 'Winslow'),
          ),
          const SizedBox(height: 8),
          Text(
            'Crafting Your Ideal Weekly Menu, Intelligently Designed',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 16),
          Text(
            'Meal.io is a revolutionary application that harnesses the power of AI to learn your food preferences and generate personalized weekly meal plans.',
            textAlign: TextAlign.center,
            style: TextStyle(color: secondaryTextColor, fontSize: 16),
          ),
          const SizedBox(height: 28),
          // --- صورة البرجر مع الكارت الذي يعلوها ---
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset('assets/images/getstarted1.webp', fit: BoxFit.cover, height: 300, width: MediaQuery.of(context).size.width),
              ),
              Positioned(
                bottom: -40,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20, offset: const Offset(0, 10))],
                    border: Border.all(color: backgroundColor ?? Colors.white, width: 4),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '18k+',
                        style: TextStyle(color: Colors.amber[800], fontSize: 32, fontWeight: FontWeight.w900),
                      ),
                      Text('Awards Winning', style: TextStyle(color: secondaryTextColor, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60), // مسافة إضافية بسبب الكارت
          // --- زر البدء ---
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[800],
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              shadowColor: Colors.amber[800]?.withAlpha(128),
            ),
            onPressed: () {
              _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
            },
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // --- ويدجت بناء الخطوة الثانية ---
  Widget _buildStepTwo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            'PLAN YOUR MEALS',
            style: TextStyle(color: Colors.amber[800], fontWeight: FontWeight.w600, fontSize: 12, fontFamily: 'Winslow'),
          ),
          const SizedBox(height: 8),
          Text(
            'Get Your Ideas Ready In Just A Minute With Generative AI!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 15)],
            ),
            child: const Column(
              children: [
                _FeatureTile(icon: Icons.lightbulb_outline, title: 'Tell Us What You Like', subtitle: 'We take the guesswork out of meal planning by intelligently interpreting your tastes.'),
                SizedBox(height: 24),
                _FeatureTile(icon: Icons.tune, title: 'Set Your Preferences', subtitle: 'Your plan, your rules. Customize based on dietary needs, budget, and more.'),
                SizedBox(height: 24),
                _FeatureTile(icon: Icons.auto_awesome, title: 'Get AI-Powered Ideas', subtitle: 'Meal.io acts as your personal culinary assistant. Simply ask for a meal plan.'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[800],
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
            },
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // --- ويدجت بناء الخطوة الثالثة ---
  Widget _buildStepThree() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 15)],
            ),
            child: Column(
              children: [
                Icon(Icons.restaurant_menu, color: Colors.amber[800], size: 48),
                const SizedBox(height: 16),
                Text(
                  'Your Personalized Plan is Here!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'The AI will generate a tailored meal plan with all the meal details, including the name, description, and an enticing image.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: secondaryTextColor),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/images/getstarted2.webp', width: MediaQuery.of(context).size.width, height: 300, fit: BoxFit.cover),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[800],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    router.go('/signup');
                  },
                  child: const Text(
                    'Create Your Account',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- ويدجت مساعد لعرض مميزات التطبيق في الخطوة الثانية ---
class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.amber[800], size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: secondaryTextColor, height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}
