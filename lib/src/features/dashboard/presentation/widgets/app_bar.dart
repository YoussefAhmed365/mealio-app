import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/features/authentication/domain/entities/user.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final UserEntity user;

  const NavBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.gray200, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Meal',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.amber600, fontWeight: FontWeight.w900, fontSize: 28),
                ),
                Text(
                  '.io',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.stone800, fontWeight: FontWeight.w900, fontSize: 28),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const HeroIcon(HeroIcons.magnifyingGlass, style: HeroIconStyle.outline, size: 24),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const HeroIcon(HeroIcons.bell, style: HeroIconStyle.outline, size: 24),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.amber100, width: 2),
                      shape: BoxShape.circle,
                      image: DecorationImage(image: user.photoUrl != null ? NetworkImage(user.photoUrl!) : const AssetImage("assets/images/avatar.webp") as ImageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
