import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 124),
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
                          'Study Timeline',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, color: AppColors.onSurface),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Weekly Progress',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA6F0E4),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '60% Goal',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _WeeklyProgressCard(),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Today, Oct 24',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        'VIEW CALENDAR',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _TimelineEntry(
                    state: _TimelineState.completed,
                    startTime: '08:00 AM',
                    endTime: '10:00 AM',
                    badge: 'COMPLETED',
                    title: 'Advanced Calculus Revision',
                    subtitle: 'Main Library, 2F',
                    trailingMeta: 'Unit 4-6',
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _TimelineEntry(
                    state: _TimelineState.ongoing,
                    startTime: '02:00 PM',
                    endTime: '04:00 PM',
                    badge: 'ONGOING',
                    title: 'Library Research',
                    description: 'Focusing on Micro-economics case study',
                    subtitle: 'Economics Wing',
                    trailingMeta: '45m left',
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _TimelineEntry(
                    state: _TimelineState.upcoming,
                    startTime: '05:30 PM',
                    endTime: '07:00 PM',
                    badge: 'UPCOMING',
                    title: 'Group Project Sync',
                    subtitle: 'Zoom Meeting',
                    trailingMeta: 'Team A',
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _TimelineEntry(
                    state: _TimelineState.upcoming,
                    startTime: '08:00 PM',
                    endTime: '09:30 PM',
                    badge: 'UPCOMING',
                    title: 'Quick Quiz Prep',
                    subtitle: 'Personal Study',
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _FocusModeCard(),
                ),
              ],
            ),
            const Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: _TimelineBottomDock(),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyProgressCard extends StatelessWidget {
  const _WeeklyProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '12',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                TextSpan(
                  text: ' / 20 hours',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.60,
              minHeight: 9,
              backgroundColor: Color(0xFFD8E5F5),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 16, color: AppColors.onSurface),
              const SizedBox(width: 6),
              Text(
                '8 hours remaining to hit your target',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurface.withValues(alpha: 0.78),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _TimelineState {
  completed,
  ongoing,
  upcoming,
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.state,
    required this.startTime,
    required this.endTime,
    required this.badge,
    required this.title,
    required this.subtitle,
    this.description,
    this.trailingMeta,
  });

  final _TimelineState state;
  final String startTime;
  final String endTime;
  final String badge;
  final String title;
  final String subtitle;
  final String? description;
  final String? trailingMeta;

  @override
  Widget build(BuildContext context) {
    final isOngoing = state == _TimelineState.ongoing;
    final isCompleted = state == _TimelineState.completed;
    final cardColor = isOngoing ? const Color(0xFF0B8C81) : AppColors.white;
    final cardBorder = isOngoing ? Colors.transparent : AppColors.borderSubtle;
    final titleColor = isOngoing ? AppColors.white : AppColors.onSurface;
    final subtitleColor = isOngoing
        ? AppColors.white.withValues(alpha: 0.92)
        : AppColors.onSurface.withValues(alpha: 0.70);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 22,
          child: Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? AppColors.successGreen : AppColors.white,
                  border: Border.all(
                    color: isOngoing
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.successGreen
                            : const Color(0xFFD0D9E8),
                    width: isOngoing ? 3 : 2,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 10, color: AppColors.white)
                    : null,
              ),
              Container(
                width: 2,
                height: 132,
                color: const Color(0xFFD9E2EF),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cardBorder),
              boxShadow: isOngoing
                  ? const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$startTime - $endTime',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: isOngoing
                                  ? AppColors.white.withValues(alpha: 0.92)
                                  : AppColors.onSurface.withValues(alpha: 0.75),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isOngoing
                            ? AppColors.white.withValues(alpha: 0.20)
                            : isCompleted
                                ? const Color(0xFFDDF9E6)
                                : const Color(0xFFE9EEF8),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        badge,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isOngoing
                                  ? AppColors.white
                                  : isCompleted
                                      ? AppColors.successGreen
                                      : const Color(0xFF7F8A98),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: titleColor,
                        fontWeight: FontWeight.w800,
                        height: 1.08,
                      ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    description!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: subtitleColor,
                          height: 1.3,
                        ),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.place_outlined, size: 16, color: AppColors.outline),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: subtitleColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    if (trailingMeta != null) ...[
                      Icon(
                        isCompleted ? Icons.calendar_today_outlined : Icons.more_time_rounded,
                        size: 15,
                        color: isOngoing ? AppColors.white : AppColors.outline,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        trailingMeta!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: subtitleColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FocusModeCard extends StatelessWidget {
  const _FocusModeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2436),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Focus Mode',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow_rounded, color: AppColors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class _TimelineBottomDock extends StatelessWidget {
  const _TimelineBottomDock();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2638),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 18, color: AppColors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  'Log Time',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.white.withValues(alpha: 0.22),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.book_online_outlined, size: 16, color: AppColors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  'Book Slot',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
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
