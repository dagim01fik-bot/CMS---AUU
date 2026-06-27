import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

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
                      'Attendance History',
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(32, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.chevron_left, color: AppColors.onSurface),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'September 2024',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(32, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.chevron_right, color: AppColors.onSurface),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _HistoryCalendarCard(),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Monthly Summary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      label: 'Present',
                      value: '18',
                      valueColor: AppColors.successGreen,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Absent',
                      value: '2',
                      valueColor: AppColors.errorRose,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Late',
                      value: '1',
                      valueColor: AppColors.warningAmber,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Course Breakdown',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _HistoryCourseCard(
                icon: Icons.functions,
                iconBackground: Color(0xFFE4F0EE),
                iconColor: AppColors.primary,
                course: 'Advanced Mathematics',
                detailLineOne: 'Semester A • Dr. Sarah',
                detailLineTwo: 'Jenkins',
                percentage: '94%',
                status: 'Excellent',
                statusColor: AppColors.successGreen,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _HistoryCourseCard(
                icon: Icons.storage_rounded,
                iconBackground: Color(0xFFE9E4FB),
                iconColor: Color(0xFF6A5CE6),
                course: 'Data Structures',
                detailLineOne: 'Semester A • Prof. Alan',
                detailLineTwo: 'Turing',
                percentage: '82%',
                status: 'Good',
                statusColor: AppColors.warningAmber,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _HistoryCourseCard(
                icon: Icons.history_edu_outlined,
                iconBackground: Color(0xFFF7E8E2),
                iconColor: Color(0xFFA35F42),
                course: 'World History II',
                detailLineOne: 'Semester A • Dr. Emma',
                detailLineTwo: 'Watson',
                percentage: '68%',
                status: 'Low',
                statusColor: AppColors.errorRose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCalendarCard extends StatelessWidget {
  const _HistoryCalendarCard();

  @override
  Widget build(BuildContext context) {
    const days = [
      'M',
      'T',
      'W',
      'T',
      'F',
      'S',
      'S',
    ];

    const entries = [
      _HistoryDay(date: 26, muted: true),
      _HistoryDay(date: 27, muted: true),
      _HistoryDay(date: 28, muted: true),
      _HistoryDay(date: 29, muted: true),
      _HistoryDay(date: 30, muted: true),
      _HistoryDay(date: 31, muted: true),
      _HistoryDay(date: 1),
      _HistoryDay(date: 2, status: AppColors.successGreen),
      _HistoryDay(date: 3, status: AppColors.successGreen),
      _HistoryDay(date: 4, status: AppColors.errorRose),
      _HistoryDay(date: 5, status: AppColors.warningAmber, selected: true),
      _HistoryDay(date: 6, status: AppColors.successGreen),
      _HistoryDay(date: 7),
      _HistoryDay(date: 8),
      _HistoryDay(date: 9, status: AppColors.successGreen),
      _HistoryDay(date: 10, status: AppColors.successGreen),
      _HistoryDay(date: 11, status: AppColors.successGreen),
      _HistoryDay(date: 12, status: AppColors.successGreen),
      _HistoryDay(date: 13, status: AppColors.errorRose),
      _HistoryDay(date: 14),
      _HistoryDay(date: 15),
      _HistoryDay(date: 16, status: AppColors.successGreen),
      _HistoryDay(date: 17, status: AppColors.successGreen),
      _HistoryDay(date: 18, status: AppColors.successGreen),
      _HistoryDay(date: 19, status: AppColors.successGreen),
      _HistoryDay(date: 20, status: AppColors.successGreen),
      _HistoryDay(date: 21),
      _HistoryDay(date: 22),
      _HistoryDay(date: 23, status: AppColors.successGreen),
      _HistoryDay(date: 24, status: AppColors.successGreen),
      _HistoryDay(date: 25),
      _HistoryDay(date: 26),
      _HistoryDay(date: 27),
      _HistoryDay(date: 28),
      _HistoryDay(date: 29),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (final day in days)
                Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entries.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 34,
            ),
            itemBuilder: (context, index) => _HistoryDayCell(day: entries[index]),
          ),
          const SizedBox(height: 14),
          const Divider(color: AppColors.borderSubtle, height: 1),
          const SizedBox(height: 14),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(color: AppColors.successGreen, label: 'Present'),
              SizedBox(width: 18),
              _LegendDot(color: AppColors.errorRose, label: 'Absent'),
              SizedBox(width: 18),
              _LegendDot(color: AppColors.warningAmber, label: 'Late'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryDay {
  const _HistoryDay({
    required this.date,
    this.status,
    this.muted = false,
    this.selected = false,
  });

  final int date;
  final Color? status;
  final bool muted;
  final bool selected;
}

class _HistoryDayCell extends StatelessWidget {
  const _HistoryDayCell({
    required this.day,
  });

  final _HistoryDay day;

  @override
  Widget build(BuildContext context) {
    final borderColor = day.selected ? AppColors.primary : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7FB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1.4),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              '${day.date}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: day.muted ? const Color(0xFFB9C1CC) : AppColors.onSurface,
                    fontWeight: day.selected ? FontWeight.w700 : FontWeight.w600,
                  ),
            ),
          ),
          if (day.status != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: day.status,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurface.withValues(alpha: 0.82),
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCourseCard extends StatelessWidget {
  const _HistoryCourseCard({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.course,
    required this.detailLineOne,
    required this.detailLineTwo,
    required this.percentage,
    required this.status,
    required this.statusColor,
  });

  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String course;
  final String detailLineOne;
  final String detailLineTwo;
  final String percentage;
  final String status;
  final Color statusColor;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  detailLineOne,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.82),
                      ),
                ),
                Text(
                  detailLineTwo,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.82),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                percentage,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurface.withValues(alpha: 0.82),
              ),
        ),
      ],
    );
  }
}
