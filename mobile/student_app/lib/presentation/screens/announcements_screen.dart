import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

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
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
                  ),
                  Expanded(
                    child: Text(
                      'Announcements',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _AnnouncementSearchField(),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(label: 'All', selected: true),
                    SizedBox(width: 10),
                    _FilterChip(label: 'Critical'),
                    SizedBox(width: 10),
                    _FilterChip(label: 'Academic'),
                    SizedBox(width: 10),
                    _FilterChip(label: 'Campus Life'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.push_pin, size: 18, color: AppColors.error),
                  const SizedBox(width: 8),
                  Text(
                    'High Priority',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9BF2DE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '2 NEW',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _PriorityNoticeCard(
                icon: Icons.warning_rounded,
                title: 'Exam Registration Closing',
                description:
                    'The deadline for Fall 2024 final examination registration is today at 11:59 PM. Late entries will not be accepted.',
                actionLabel: 'Action Required',
                badgeLabel: 'URGENT',
                background: Color(0xFFF7D5D4),
                iconBackground: Color(0xFFF7B9BC),
                accent: AppColors.error,
                badgeTextColor: Color(0xFFB14A42),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CampusStatusCard(),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Recent Updates',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _UpdateCard(
                icon: Icons.campaign_outlined,
                iconBackground: Color(0xFFE7EDF8),
                title: 'Spring Festival 2024 Volunteer Call',
                description:
                    'Be part of the university\'s largest annual event! We are looking for student volunteers across logistics and media teams.',
                tagLabel: 'CAMPUS LIFE',
                tagColor: Color(0xFFE5E0FF),
                tagTextColor: AppColors.secondary,
                timeLabel: '2h ago',
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _UpdateCard(
                icon: Icons.school_outlined,
                iconBackground: Color(0xFFD8FFF6),
                title: 'New Research Grants Available',
                description:
                    'Applications for the Undergraduate Research Initiative are now open for selected departments and mentors.',
                tagLabel: 'ACADEMIC',
                tagColor: Color(0xFF9BF2DE),
                tagTextColor: AppColors.primary,
                timeLabel: '5h ago',
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _UpdateCard(
                icon: Icons.info_outline,
                iconBackground: Color(0xFFF3E4D3),
                title: 'Cafeteria Menu Updates',
                description:
                    'Introducing new plant-based options across all campus dining halls starting next week.',
                tagLabel: 'GENERAL',
                tagColor: Color(0xFFF6D8B5),
                tagTextColor: Color(0xFFB66525),
                timeLabel: 'Oct 24',
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _DigitalTownHallBanner(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnnouncementSearchField extends StatelessWidget {
  const _AnnouncementSearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, size: 18, color: AppColors.outline),
          const SizedBox(width: 10),
          Text(
            'Search announcements...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.outline,
                ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : const Color(0xFFE9EEF8),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: selected ? AppColors.white : const Color(0xFF5D6B82),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _PriorityNoticeCard extends StatelessWidget {
  const _PriorityNoticeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.badgeLabel,
    required this.background,
    required this.iconBackground,
    required this.accent,
    required this.badgeTextColor,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final String badgeLabel;
  final Color background;
  final Color iconBackground;
  final Color accent;
  final Color badgeTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent, size: 18),
              ),
              const Spacer(),
              Text(
                badgeLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: badgeTextColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: accent.withValues(alpha: 0.88),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                actionLabel,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 16, color: accent),
            ],
          ),
        ],
      ),
    );
  }
}

class _CampusStatusCard extends StatelessWidget {
  const _CampusStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6D63F4), Color(0xFF6259F2)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.campaign_outlined, color: AppColors.white, size: 18),
              ),
              const Spacer(),
              Text(
                'CAMPUS STATUS',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.78),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Library Maintenance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'The main wing of the library will be closed this Saturday for HVAC repairs. Digital resources remain available.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.88),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                'View Schedule',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward, size: 16, color: AppColors.white),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  const _UpdateCard({
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.description,
    required this.tagLabel,
    required this.tagColor,
    required this.tagTextColor,
    required this.timeLabel,
  });

  final IconData icon;
  final Color iconBackground;
  final String title;
  final String description;
  final String tagLabel;
  final Color tagColor;
  final Color tagTextColor;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tagLabel,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: tagTextColor,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      timeLabel,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.outline,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.78),
                        height: 1.35,
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

class _DigitalTownHallBanner extends StatelessWidget {
  const _DigitalTownHallBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: const BoxConstraints(minHeight: 176),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF062F3A), Color(0xFF0A5665)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -18,
            right: -12,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF1AD7D6).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -26,
            left: -10,
            child: Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIVE FEATURE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF7EF2DD),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join the Digital Town Hall',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Happening now: Q&A with the Dean regarding campus expansion.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.86),
                          height: 1.3,
                        ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF7EF2DD),
                      foregroundColor: const Color(0xFF0B4145),
                      minimumSize: const Size(0, 38),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Enter Stream'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
