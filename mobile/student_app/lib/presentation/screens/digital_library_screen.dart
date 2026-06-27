import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class DigitalLibraryScreen extends StatelessWidget {
  const DigitalLibraryScreen({super.key});

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
                      'Digital Library',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border_rounded, color: AppColors.onSurface),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFB96F48), Color(0xFF29485D)],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDCE3ED)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.outline),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Search books, journals, authors...',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF7D8796),
                            ),
                      ),
                    ),
                    const Icon(Icons.tune_rounded, color: AppColors.onSurface),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Continue Reading',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    'View All',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _ContinueReadingCard(
                    wide: true,
                    title: 'Advanced\nAlgorithms',
                    author: 'Dr. Elena Rostova',
                    progress: 0.65,
                    progressLabel: '65%',
                    accent: Color(0xFF58D0D1),
                  ),
                  SizedBox(width: 12),
                  _ContinueReadingCard(
                    title: 'Library\nAccess',
                    author: 'Premium Shelf',
                    progress: 0.35,
                    progressLabel: '35%',
                    accent: Color(0xFF2BAEC4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Browse Subjects',
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
                  Row(
                    children: [
                      Expanded(
                        child: _SubjectTile(
                          title: 'Computer\nScience',
                          background: AppColors.primary,
                          foreground: AppColors.white,
                          icon: Icons.computer_outlined,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _SubjectTile(
                          title: 'Mathematics',
                          background: Color(0xFFDDE7F8),
                          foreground: AppColors.onSurface,
                          icon: Icons.calculate_outlined,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _SubjectTile(
                          title: 'Literature',
                          background: Color(0xFFDDE7F8),
                          foreground: AppColors.onSurface,
                          icon: Icons.menu_book_outlined,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _SubjectTile(
                          title: 'Law & Ethics',
                          background: AppColors.secondary,
                          foreground: AppColors.white,
                          icon: Icons.gavel_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'New Arrivals',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _FeaturedArrivalCard(),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CompactArrivalCard(),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Library Access',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _LibraryAccessCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueReadingCard extends StatelessWidget {
  const _ContinueReadingCard({
    required this.title,
    required this.author,
    required this.progress,
    required this.progressLabel,
    required this.accent,
    this.wide = false,
  });

  final String title;
  final String author;
  final double progress;
  final String progressLabel;
  final Color accent;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? 196 : 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: wide
          ? Row(
              children: [
                _BookCover(accent: accent),
                const SizedBox(width: 12),
                Expanded(
                  child: _ContinueTextBlock(
                    title: title,
                    author: author,
                    progress: progress,
                    progressLabel: progressLabel,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _BookCover(accent: accent, narrow: true),
                ),
                const SizedBox(height: 12),
                _ContinueTextBlock(
                  title: title,
                  author: author,
                  progress: progress,
                  progressLabel: progressLabel,
                ),
              ],
            ),
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({
    required this.accent,
    this.narrow = false,
  });

  final Color accent;
  final bool narrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: narrow ? 54 : 58,
      height: narrow ? 84 : 86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent,
            const Color(0xFF1A566B),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              height: 2,
              color: AppColors.white.withValues(alpha: 0.55),
            ),
          ),
          Center(
            child: Icon(
              Icons.menu_book_rounded,
              color: AppColors.white.withValues(alpha: 0.9),
              size: narrow ? 22 : 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueTextBlock extends StatelessWidget {
  const _ContinueTextBlock({
    required this.title,
    required this.author,
    required this.progress,
    required this.progressLabel,
  });

  final String title;
  final String author;
  final double progress;
  final String progressLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          author,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurface.withValues(alpha: 0.78),
              ),
        ),
        const SizedBox(height: 10),
        Text(
          progressLabel,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: const Color(0xFFDCE6F2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _SubjectTile extends StatelessWidget {
  const _SubjectTile({
    required this.title,
    required this.background,
    required this.foreground,
    required this.icon,
  });

  final String title;
  final Color background;
  final Color foreground;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -6,
            bottom: -10,
            child: Icon(
              icon,
              size: 34,
              color: foreground.withValues(alpha: 0.16),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: foreground, size: 20),
              const SizedBox(height: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w800,
                          height: 1.05,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeaturedArrivalCard extends StatelessWidget {
  const _FeaturedArrivalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 148,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF718284), Color(0xFF071A1F), Color(0xFF0CA4AA)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 22,
                    top: 18,
                    bottom: 18,
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF091A24), Color(0xFF0E5C61)],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.psychology_alt_rounded, color: Color(0xFF68F4EB), size: 62),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 12,
                    left: 58,
                    child: Text(
                      'ETHICS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4FFF2),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'JOURNAL',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.successGreen,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '2024 Edition',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.outline,
                          ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE3DE),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'ACADEMIC CHOICE',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: const Color(0xFFC13B17),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Ethics in Artificial Intelligence:\nGlobal Perspectives',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.08,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A comprehensive study on the sociopolitical impacts of generative models and the necessity of ethical AI governance.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.78),
                        height: 1.35,
                      ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          minimumSize: const Size(0, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.menu_book_outlined, size: 18),
                        label: const Text('Read Now'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(48, 44),
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Icon(Icons.download_outlined, color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactArrivalCard extends StatelessWidget {
  const _CompactArrivalCard();

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
          const _BookCover(accent: Color(0xFF0F7481), narrow: true),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantum Computing\nBasics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Prof. Alan Turing Jr.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.78),
                      ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Free Download',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward, color: AppColors.primary),
        ],
      ),
    );
  }
}

class _LibraryAccessCard extends StatelessWidget {
  const _LibraryAccessCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1C9E95), Color(0xFF0A8078)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'UNIVERSITY STUDENT ID',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.82),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
              ),
              const Spacer(),
              const Icon(Icons.contactless_rounded, color: AppColors.white),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Julian Henderson',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Library Access Tier',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.82),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Premium Research',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.qr_code_2_rounded, color: AppColors.white, size: 34),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
