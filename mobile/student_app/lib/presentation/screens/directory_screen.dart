import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  _HeaderCircleButton(
                    icon: Icons.menu_rounded,
                    onTap: () => context.pop(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Campus Directory',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search_rounded, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _DirectorySearchBar(),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: _CategoryStrip(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CampusMapCard(),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Recent Searches',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    'Clear all',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: _RecentSearchesRow(),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Main Campus Buildings',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _BuildingCard(
                    icon: Icons.groups_2_outlined,
                    title: 'Engineering Hall',
                    subtitle: 'Faculty of Applied Sciences',
                    distance: '200m away',
                    iconBg: Color(0xFFB8F5E8),
                    distanceBg: Color(0xFFDDF6E8),
                    distanceColor: AppColors.successGreen,
                  ),
                  SizedBox(height: 12),
                  _BuildingCard(
                    icon: Icons.menu_book_outlined,
                    title: 'Central Library',
                    subtitle: 'Research & Quiet Zones',
                    distance: '450m away',
                    iconBg: Color(0xFFE4DDFE),
                    distanceBg: Color(0xFFFFEDCC),
                    distanceColor: AppColors.warningAmber,
                    iconColor: AppColors.secondary,
                  ),
                  SizedBox(height: 12),
                  _BuildingCard(
                    icon: Icons.group_work_outlined,
                    title: 'Student Union',
                    subtitle: 'Cafeteria & Services',
                    distance: '800m away',
                    iconBg: Color(0xFFFFE3D8),
                    distanceBg: Color(0xFFFFE1E7),
                    distanceColor: AppColors.errorRose,
                    iconColor: Color(0xFF9B5B34),
                  ),
                  SizedBox(height: 12),
                  _BuildingCard(
                    icon: Icons.science_outlined,
                    title: 'Innovation Lab',
                    subtitle: 'Robotics & AI Center',
                    distance: '1.2km away',
                    iconBg: Color(0xFFE1E7F7),
                    distanceBg: Color(0xFFDDF6E8),
                    distanceColor: AppColors.successGreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF9FBEFF), style: BorderStyle.solid),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}

class _DirectorySearchBar extends StatelessWidget {
  const _DirectorySearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.outline),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search buildings, offices, or staff...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF98A4A1),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          _CategoryChip(label: 'All', selected: true),
          SizedBox(width: 8),
          _CategoryChip(label: 'Buildings'),
          SizedBox(width: 8),
          _CategoryChip(label: 'Offices'),
          SizedBox(width: 8),
          _CategoryChip(label: 'Cafes'),
          SizedBox(width: 8),
          _CategoryChip(label: 'Labs'),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : const Color(0xFFDDE7F7),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: selected ? AppColors.white : const Color(0xFF4E5C6D),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _CampusMapCard extends StatelessWidget {
  const _CampusMapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFA7D8CC), Color(0xFF86C5B8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const Positioned.fill(child: _CampusMapIllustration()),
          Positioned(
            top: 12,
            right: 12,
            child: Column(
              children: const [
                _MapZoomButton(icon: Icons.add_rounded),
                SizedBox(height: 8),
                _MapZoomButton(icon: Icons.remove_rounded),
              ],
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: SizedBox(
              height: 42,
              child: FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF0A756D),
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.open_in_full_rounded, size: 18),
                label: const Text(
                  'Expand Map',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapZoomButton extends StatelessWidget {
  const _MapZoomButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.outline),
    );
  }
}

class _CampusMapIllustration extends StatelessWidget {
  const _CampusMapIllustration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned(
          left: 26,
          top: 64,
          child: _RoadStrip(width: 210, angle: -0.3),
        ),
        Positioned(
          left: 44,
          top: 38,
          child: _RoadStrip(width: 156, angle: 0.54),
        ),
        Positioned(
          left: 34,
          top: 76,
          child: _MapBuilding(width: 56, height: 34),
        ),
        Positioned(
          left: 96,
          top: 54,
          child: _MapBuilding(width: 50, height: 32),
        ),
        Positioned(
          left: 154,
          top: 38,
          child: _MapBuilding(width: 58, height: 34),
        ),
        Positioned(
          left: 182,
          top: 86,
          child: _MapBuilding(width: 60, height: 36),
        ),
        Positioned(
          left: 72,
          top: 104,
          child: _MapBuilding(width: 52, height: 32),
        ),
        Positioned(
          left: 134,
          top: 108,
          child: _MapBuilding(width: 42, height: 28),
        ),
        Positioned(
          left: 54,
          top: 54,
          child: _MapPin(color: AppColors.errorRose),
        ),
        Positioned(
          left: 108,
          top: 18,
          child: _MapPin(color: AppColors.primary),
        ),
        Positioned(
          left: 210,
          top: 62,
          child: _MapPin(color: AppColors.warningAmber),
        ),
      ],
    );
  }
}

class _RoadStrip extends StatelessWidget {
  const _RoadStrip({
    required this.width,
    required this.angle,
  });

  final double width;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: width,
        height: 18,
        decoration: BoxDecoration(
          color: const Color(0xFFDBF4EA),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.9), width: 2),
        ),
      ),
    );
  }
}

class _MapBuilding extends StatelessWidget {
  const _MapBuilding({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EFEA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF7FA498), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 6,
            right: 6,
            top: 5,
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFBBD8CD),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            left: 6,
            right: 6,
            bottom: 6,
            child: Row(
              children: List.generate(
                4,
                (_) => Expanded(
                  child: Container(
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4E4DD),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_on_rounded, color: color, size: 16),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _RecentSearchesRow extends StatelessWidget {
  const _RecentSearchesRow();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          _RecentSearchChip(label: 'Student Union'),
          SizedBox(width: 10),
          _RecentSearchChip(label: "Registrar's Office"),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _RecentSearchChip extends StatelessWidget {
  const _RecentSearchChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, color: AppColors.outline, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildingCard extends StatelessWidget {
  const _BuildingCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.iconBg,
    required this.distanceBg,
    required this.distanceColor,
    this.iconColor = AppColors.onSurface,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String distance;
  final Color iconBg;
  final Color distanceBg;
  final Color distanceColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.84),
                        height: 1.2,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: distanceBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              distance,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: distanceColor,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
