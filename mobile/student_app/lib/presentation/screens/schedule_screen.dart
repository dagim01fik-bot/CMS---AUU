import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 28),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Schedule",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Thursday, Sept 26',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.outline,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderSubtle),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF735A45), Color(0xFF2B353D)],
                      ),
                    ),
                    child: const Icon(Icons.person, color: AppColors.white, size: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const _ScheduleTimeline(
              items: [
                _ScheduleEntry(
                  time: '09:00 - 11:00 AM',
                  title: 'Database Systems',
                  room: 'Room 204',
                  instructor: 'Dr. Abebe',
                  badgeLabel: 'COMPLETED',
                  badgeTextColor: Color(0xFF14B86A),
                  badgeBackground: Color(0xFFDFF8EA),
                  markerColor: Color(0xFF10B981),
                ),
                _ScheduleEntry(
                  time: '11:30 - 01:30 PM',
                  title: 'Software Engineering II',
                  room: 'Lab 05',
                  instructor: 'Prof. Sarah',
                  badgeLabel: 'ONGOING',
                  badgeTextColor: AppColors.white,
                  badgeBackground: AppColors.primary,
                  markerColor: Color(0xFFA8C8C3),
                  highlighted: true,
                ),
                _ScheduleEntry(
                  time: '02:30 - 04:30 PM',
                  title: 'Professional Ethics',
                  room: 'Auditorium B',
                  instructor: 'Dr. Samuel',
                  badgeLabel: 'UPCOMING',
                  badgeTextColor: Color(0xFF63708A),
                  badgeBackground: Color(0xFFEAEFF8),
                  markerColor: Color(0xFFC7CECC),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionPanel(
                      icon: Icons.assignment_outlined,
                      title: 'View Tasks',
                      color: const Color(0xFFDAD3FF),
                      iconBackground: const Color(0xFFEFEAFF),
                      iconColor: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _ActionPanel(
                      icon: Icons.mail_outline,
                      title: 'Prof Chat',
                      color: const Color(0xFF8DE6DD),
                      iconBackground: const Color(0xFFCFF7F2),
                      iconColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: _ScheduleAlertCard(
                message:
                    "Lab 05 equipment is under maintenance. Please bring your own laptop for today's Software Engineering II session.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleTimeline extends StatelessWidget {
  const _ScheduleTimeline({
    required this.items,
  });

  final List<_ScheduleEntry> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          _TimelineRow(
            item: items[i],
            isFirst: i == 0,
            isLast: i == items.length - 1,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.item,
    required this.isFirst,
    required this.isLast,
  });

  final _ScheduleEntry item;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 34,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: isFirst ? Colors.transparent : AppColors.outlineVariant,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item.markerColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: item.highlighted ? 0.25 : 0.1),
                      width: 3,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : AppColors.outlineVariant,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 12, 16),
              child: _ScheduleCard(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.item,
  });

  final _ScheduleEntry item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.highlighted ? AppColors.primary : AppColors.borderSubtle,
          width: item.highlighted ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.time,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF6C4A17),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: item.badgeBackground,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  item.badgeLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: item.badgeTextColor,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item.room,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface,
                      ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.person_outline, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item.instructor,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface,
                      ),
                ),
              ),
            ],
          ),
          if (item.highlighted) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: 0.68,
                minHeight: 4,
                backgroundColor: const Color(0xFFDCE7F2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionPanel extends StatelessWidget {
  const _ActionPanel({
    required this.icon,
    required this.title,
    required this.color,
    required this.iconBackground,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final Color color;
  final Color iconBackground;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleAlertCard extends StatelessWidget {
  const _ScheduleAlertCard({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F0E5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5D2B4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.info_outline, color: AppColors.warningAmber),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF645A4A),
                    height: 1.35,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleEntry {
  const _ScheduleEntry({
    required this.time,
    required this.title,
    required this.room,
    required this.instructor,
    required this.badgeLabel,
    required this.badgeTextColor,
    required this.badgeBackground,
    required this.markerColor,
    this.highlighted = false,
  });

  final String time;
  final String title;
  final String room;
  final String instructor;
  final String badgeLabel;
  final Color badgeTextColor;
  final Color badgeBackground;
  final Color markerColor;
  final bool highlighted;
}
