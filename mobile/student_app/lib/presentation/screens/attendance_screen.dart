import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

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
                      'Attendance Tracking',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _OverallAttendanceCard(),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'September 2024',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => context.push('/attendance-history'),
                    borderRadius: BorderRadius.circular(8),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFB6CDFB)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Full View',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.open_in_full, size: 14, color: AppColors.secondary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _AttendanceCalendarCard(),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LegendDot(color: AppColors.successGreen, label: 'Present'),
                  SizedBox(width: 18),
                  _LegendDot(color: AppColors.errorRose, label: 'Absent'),
                  SizedBox(width: 18),
                  _LegendDot(color: AppColors.warningAmber, label: 'Late'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Course Breakdown',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CourseAttendanceCard(
                course: 'Database Systems',
                attended: 23,
                total: 25,
                percentage: 92,
                accent: AppColors.primary,
                pillBackground: Color(0xFFE6F4FA),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CourseAttendanceCard(
                course: 'Software Engineering II',
                attended: 20,
                total: 24,
                percentage: 85,
                accent: AppColors.primary,
                pillBackground: Color(0xFFE6F4FA),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CourseAttendanceCard(
                course: 'Professional Ethics',
                attended: 24,
                total: 25,
                percentage: 96,
                accent: AppColors.primary,
                pillBackground: Color(0xFFE6F4FA),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CourseAttendanceCard(
                course: 'Mobile Development',
                attended: 18,
                total: 23,
                percentage: 78,
                accent: AppColors.error,
                pillBackground: Color(0xFFFAD9D8),
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _AttendanceInfoCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverallAttendanceCard extends StatelessWidget {
  const _OverallAttendanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OVERALL ATTENDANCE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF654126),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  '88%',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  '124 attended / 142 total',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.outline,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 92,
            height: 92,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 78,
                  height: 78,
                  child: CircularProgressIndicator(
                    value: 0.88,
                    strokeWidth: 6,
                    color: AppColors.primary,
                    backgroundColor: const Color(0xFFD9E7F2),
                  ),
                ),
                const Icon(Icons.fact_check_outlined, color: AppColors.primary, size: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceCalendarCard extends StatelessWidget {
  const _AttendanceCalendarCard();

  @override
  Widget build(BuildContext context) {
    final items = <_CalendarDayData>[
      const _CalendarDayData(dayLabel: 'M', date: '26', muted: true),
      const _CalendarDayData(dayLabel: 'T', date: '27', muted: true),
      const _CalendarDayData(dayLabel: 'W', date: '28', muted: true),
      const _CalendarDayData(dayLabel: 'T', date: '29', muted: true),
      const _CalendarDayData(dayLabel: 'F', date: '30', muted: true),
      const _CalendarDayData(dayLabel: 'S', date: '1', statusColor: AppColors.successGreen),
      const _CalendarDayData(dayLabel: 'S', date: '2'),
      const _CalendarDayData(dayLabel: '', date: '3', statusColor: AppColors.successGreen),
      const _CalendarDayData(dayLabel: '', date: '4', statusColor: AppColors.errorRose),
      const _CalendarDayData(dayLabel: '', date: '5', statusColor: AppColors.successGreen),
      const _CalendarDayData(dayLabel: '', date: '6', statusColor: AppColors.warningAmber),
      const _CalendarDayData(dayLabel: '', date: '7', statusColor: AppColors.successGreen),
      const _CalendarDayData(dayLabel: '', date: '8', statusColor: AppColors.successGreen),
      const _CalendarDayData(dayLabel: '', date: '9'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 4,
          mainAxisExtent: 52,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return _CalendarDayCell(item: item);
        },
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    required this.item,
  });

  final _CalendarDayData item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16,
          child: item.dayLabel.isNotEmpty
              ? Text(
                  item.dayLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF4A556B),
                        fontWeight: FontWeight.w700,
                      ),
                )
              : null,
        ),
        const SizedBox(height: 4),
        Text(
          item.date,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: item.muted ? const Color(0xFFB4BDC9) : AppColors.onSurface,
                fontWeight: item.muted ? FontWeight.w500 : FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: item.statusColor ?? Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _CalendarDayData {
  const _CalendarDayData({
    required this.dayLabel,
    required this.date,
    this.statusColor,
    this.muted = false,
  });

  final String dayLabel;
  final String date;
  final Color? statusColor;
  final bool muted;
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.outline,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _CourseAttendanceCard extends StatelessWidget {
  const _CourseAttendanceCard({
    required this.course,
    required this.attended,
    required this.total,
    required this.percentage,
    required this.accent,
    required this.pillBackground,
  });

  final String course;
  final int attended;
  final int total;
  final int percentage;
  final Color accent;
  final Color pillBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  course,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: pillBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$percentage%',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$attended / $total classes',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.outline,
                ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 5,
              backgroundColor: const Color(0xFFDDE8F4),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceInfoCard extends StatelessWidget {
  const _AttendanceInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE7F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.info_outline, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Attendance reports are updated every 24 hours. If you find a discrepancy, please contact your course coordinator.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4C5A73),
                    height: 1.35,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
