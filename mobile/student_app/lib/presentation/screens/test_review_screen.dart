import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class TestReviewScreen extends StatelessWidget {
  const TestReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 28),
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
                      'Test Review',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  Text(
                    'Mekdes Alemu',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 34,
                    height: 34,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFBC7B55), Color(0xFF1B5962)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: const Icon(Icons.person, size: 18, color: AppColors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _TestReviewSummaryCard(),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Performance by Category',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _CategoryResultCard(
                    title: 'SQL Queries',
                    percent: '100%',
                    progress: 1.0,
                    progressColor: AppColors.primary,
                  ),
                  SizedBox(height: 12),
                  _CategoryResultCard(
                    title: 'Normalization',
                    percent: '80%',
                    progress: 0.80,
                    progressColor: AppColors.warningAmber,
                  ),
                  SizedBox(height: 12),
                  _CategoryResultCard(
                    title: 'DB Design',
                    percent: '90%',
                    progress: 0.90,
                    progressColor: AppColors.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Questions Review',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '20 Questions Total',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.outline,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _DetailedReviewCard(
                questionNumber: 'QUESTION 01',
                status: 'Correct',
                correct: true,
                prompt:
                    'Which SQL join returns all records when there is a match in either left or right table?',
                userAnswer: 'FULL OUTER JOIN',
                correctAnswer: 'FULL OUTER JOIN',
                explanationLabel: 'View Explanation',
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _DetailedReviewCard(
                questionNumber: 'QUESTION 02',
                status: 'Incorrect',
                correct: false,
                prompt:
                    'In a 3NF normalized database, a non-key attribute must NOT be dependent on another non-key attribute. What is this dependency called?',
                userAnswer: 'Partial Dependency',
                correctAnswer: 'Transitive Dependency',
                explanationTitle: 'DETAILED EXPLANATION',
                explanationBody:
                    'A Transitive Dependency occurs when a non-key attribute depends on another non-key attribute. For Third Normal Form (3NF), a table must already be in 2NF and contain no transitive dependencies.\n\nExample: If StudentID -> CampusID and CampusID -> CampusName, then CampusName is transitively dependent on StudentID through CampusID. To fix this, CampusID and CampusName should be moved to a separate table.',
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CollapsedReviewCard(
                questionNumber: 'QUESTION 03',
                title: 'ACID properties in Transaction Management...',
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size(180, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Text('Load 17 More Questions'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestReviewSummaryCard extends StatelessWidget {
  const _TestReviewSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FINAL SCORE',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.outline,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '92%',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                TextSpan(
                  text: ' (18 of 20 Correct)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _SummaryPill(
                icon: Icons.access_time_rounded,
                label: '15:00 mins',
                textColor: AppColors.secondary,
                background: const Color(0xFFEAF0FF),
              ),
              const SizedBox(width: 10),
              _SummaryPill(
                label: 'Excellent',
                textColor: AppColors.successGreen,
                background: const Color(0xFFE5FFF2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({
    required this.label,
    required this.textColor,
    required this.background,
    this.icon,
  });

  final String label;
  final Color textColor;
  final Color background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: textColor),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _CategoryResultCard extends StatelessWidget {
  const _CategoryResultCard({
    required this.title,
    required this.percent,
    required this.progress,
    required this.progressColor,
  });

  final String title;
  final String percent;
  final double progress;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Text(
                percent,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: progressColor,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFDDE7F2),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailedReviewCard extends StatelessWidget {
  const _DetailedReviewCard({
    required this.questionNumber,
    required this.status,
    required this.correct,
    required this.prompt,
    required this.userAnswer,
    required this.correctAnswer,
    this.explanationLabel,
    this.explanationTitle,
    this.explanationBody,
  });

  final String questionNumber;
  final String status;
  final bool correct;
  final String prompt;
  final String userAnswer;
  final String correctAnswer;
  final String? explanationLabel;
  final String? explanationTitle;
  final String? explanationBody;

  @override
  Widget build(BuildContext context) {
    final statusColor = correct ? AppColors.successGreen : AppColors.errorRose;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: correct ? AppColors.borderSubtle : const Color(0xFFF2D0D8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  correct ? Icons.check : Icons.close,
                  color: statusColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          questionNumber,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.outline,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.7,
                              ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      prompt,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _AnswerBox(
            label: 'Your Answer',
            value: userAnswer,
            background: correct ? const Color(0xFFEAF0FF) : const Color(0xFFFFF0F3),
            labelColor: correct ? AppColors.outline : AppColors.errorRose,
          ),
          const SizedBox(height: 12),
          _AnswerBox(
            label: 'Correct Answer',
            value: correctAnswer,
            background: const Color(0xFFEFF8F3),
            labelColor: AppColors.successGreen,
          ),
          if (explanationLabel != null) ...[
            const SizedBox(height: 12),
            Text(
              '$explanationLabel  v',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
          if (explanationTitle != null && explanationBody != null) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F9FD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDCE6F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        explanationTitle!,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    explanationBody!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.onSurface.withValues(alpha: 0.86),
                          height: 1.45,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AnswerBox extends StatelessWidget {
  const _AnswerBox({
    required this.label,
    required this.value,
    required this.background,
    required this.labelColor,
  });

  final String label;
  final String value;
  final Color background;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: labelColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _CollapsedReviewCard extends StatelessWidget {
  const _CollapsedReviewCard({
    required this.questionNumber,
    required this.title,
  });

  final String questionNumber;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.successGreen.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 14, color: AppColors.successGreen),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questionNumber,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.outline,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.72),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: AppColors.outline),
        ],
      ),
    );
  }
}
