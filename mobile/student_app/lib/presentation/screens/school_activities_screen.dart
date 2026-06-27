import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class SchoolActivitiesScreen extends StatelessWidget {
  const SchoolActivitiesScreen({super.key});

  static const _heroImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuD9_o2Cbh2bZ7-pCAm8HWBT-XJwMInbjZfGeXZH-CmBTUpl3rxRHZAEuIyLIGCUGRa__DYPz-TtKzFbl9YVvGs25OKjx5RSb20Ch2x37BO4Xyel7I5rIUPqzk2kSnw9DPgCQLTvwwsnLeuPfHhjhgGB7UtcFBzNjfMHkEiZlYUXxj9whidayCpYztKnyik5PbOu1tbimVNkx48qocuio-FM7t5TefXmibEiiFf_10OHsp7tKsD04RvjH4sIXF9cRMficS8-aYBEQcM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: Text(
          'School Activities',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.emoji_events_outlined, color: AppColors.primary),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _SummaryCard(
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _SectionHeader(
            title: 'Activity History',
            actionLabel: 'View All',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          const _ActivityTile(
            icon: Icons.volunteer_activism,
            iconColor: AppColors.successGreen,
            backgroundColor: Color(0xFFEAF8F0),
            title: 'Community Service',
            date: 'Oct 24, 2023',
            points: '+50 pts',
          ),
          const SizedBox(height: 12),
          const _ActivityTile(
            icon: Icons.terminal,
            iconColor: AppColors.secondary,
            backgroundColor: Color(0xFFEAE7FF),
            title: 'Tech Talk Event',
            date: 'Oct 20, 2023',
            points: '+30 pts',
          ),
          const SizedBox(height: 12),
          const _ActivityTile(
            icon: Icons.bloodtype,
            iconColor: AppColors.errorRose,
            backgroundColor: Color(0xFFFFEEF2),
            title: 'Blood Donation',
            date: 'Oct 15, 2023',
            points: '+40 pts',
          ),
          const SizedBox(height: 12),
          const _ActivityTile(
            icon: Icons.code,
            iconColor: AppColors.warningAmber,
            backgroundColor: Color(0xFFFFF6E8),
            title: 'Hackathon',
            date: 'Oct 02, 2023',
            points: '+100 pts',
          ),
          const SizedBox(height: 24),
          Text(
            'Achievements',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 108,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _AchievementBadge(
                  icon: Icons.star,
                  iconColor: AppColors.primary,
                  label: 'Star Citizen',
                ),
                SizedBox(width: 16),
                _AchievementBadge(
                  icon: Icons.eco,
                  iconColor: AppColors.secondary,
                  label: 'Eco Warrior',
                ),
                SizedBox(width: 16),
                _AchievementBadge(
                  icon: Icons.favorite,
                  iconColor: AppColors.errorRose,
                  label: 'Lifesaver',
                ),
                SizedBox(width: 16),
                _AchievementBadge(
                  icon: Icons.workspace_premium,
                  iconColor: AppColors.outlineVariant,
                  label: 'Honor Roll',
                  faded: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Upcoming Opportunities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          _OpportunityHeroCard(imageUrl: _heroImageUrl),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _OpportunityMiniCard(
                  icon: Icons.school,
                  iconColor: AppColors.primary,
                  backgroundColor: Color(0xFFE7F4F1),
                  title: 'Guest Lecture: AI Trends',
                  points: '+15 pts',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _OpportunityMiniCard(
                  icon: Icons.brush,
                  iconColor: Color(0xFF924628),
                  backgroundColor: Color(0xFFFFEADB),
                  title: 'Art Workshop 101',
                  points: '+20 pts',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.10)),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.successGreen.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.military_tech,
                color: AppColors.successGreen,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Points',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color(0xFF3D4947),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                  ),
                  Text(
                    '480',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.successGreen.withValues(alpha: 0.2)),
              ),
              child: Text(
                'Rank #12',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.successGreen,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: onTap,
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          iconAlignment: IconAlignment.end,
          label: Text(
            actionLabel,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          icon: const Icon(Icons.chevron_right, size: 16),
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.date,
    required this.points,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String date;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF3D4947),
                      ),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.successGreen,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.faded = false,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: faded ? 0.5 : 1,
      child: SizedBox(
        width: 82,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: iconColor.withValues(alpha: 0.2), width: 2),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: faded ? AppColors.outline : AppColors.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OpportunityHeroCard extends StatelessWidget {
  const _OpportunityHeroCard({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Color(0xCC000000)],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.successGreen,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Service',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tree Planting',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    'Saturday, 9:00 AM',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _OpportunityMiniCard extends StatelessWidget {
  const _OpportunityMiniCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.points,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            points,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
