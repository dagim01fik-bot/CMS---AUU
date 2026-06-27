import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            'My Clubs',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: AppColors.outline),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(108),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  const _ClubsSearchField(),
                  const SizedBox(height: 12),
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.outline,
                    labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    tabs: const [
                      Tab(text: 'My Clubs'),
                      Tab(text: 'Discover'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          onPressed: () {},
          label: const Text('Start a Club'),
          icon: const Icon(Icons.add),
        ),
        body: const TabBarView(
          children: [
            _MyClubsTab(),
            _DiscoverTab(),
          ],
        ),
      ),
    );
  }
}

class _ClubsSearchField extends StatelessWidget {
  const _ClubsSearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, size: 18, color: AppColors.outline),
          const SizedBox(width: 10),
          Text(
            'Search clubs or interests...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.outline,
                ),
          ),
        ],
      ),
    );
  }
}

class _MyClubsTab extends StatelessWidget {
  const _MyClubsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
      children: [
        const _SectionHeader(
          title: 'Joined Communities',
          badgeLabel: '3 Active',
        ),
        const SizedBox(height: 12),
        const _JoinedCommunityCard(
          icon: Icons.code,
          iconBackground: Color(0xFF007F7A),
          title: 'Coding Club',
          role: 'PRESIDENT',
          statusLabel: 'Active',
          statusColor: Color(0xFFE4F6E8),
          statusTextColor: AppColors.successGreen,
          scheduleLabel: 'Next Meeting: Tomorrow, 4:00 PM',
        ),
        const SizedBox(height: 12),
        const _JoinedCommunityCard(
          icon: Icons.palette_outlined,
          iconBackground: Color(0xFF5A50E6),
          title: 'Art Society',
          role: 'MEMBER',
          statusLabel: 'Pending Event',
          statusColor: Color(0xFFFFF1D6),
          statusTextColor: AppColors.warningAmber,
          scheduleLabel: 'Next Workshop: Friday, 2:30 PM',
        ),
        const SizedBox(height: 24),
        Text(
          'Featured to Join',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 262,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const _FeaturedClubCard(
                accentStart: Color(0xFF7451F8),
                accentEnd: Color(0xFF0E7C86),
                heroIcon: Icons.camera_alt_outlined,
                title: 'Photography',
                description:
                    'Explore visual storytelling and sharpen your camera eye with fellow creators.',
                membersLabel: '124 Members',
                tagLabel: 'Arts',
              ),
              const SizedBox(width: 14),
              const _FeaturedClubCard(
                accentStart: Color(0xFF0A7E74),
                accentEnd: Color(0xFF65B96A),
                heroIcon: Icons.eco_outlined,
                title: 'Eco-Warriors',
                description:
                    'Champion sustainability projects and campus green initiatives with peers.',
                membersLabel: '89 Members',
                tagLabel: 'Social',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Explore by Category',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 14),
        const Row(
          children: [
            Expanded(
              child: _CategoryTile(
                icon: Icons.sports_basketball_outlined,
                title: 'Sports',
                accent: Color(0xFFB9E9F4),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _CategoryTile(
                icon: Icons.school_outlined,
                title: 'Academic',
                accent: Color(0xFFD5D1FF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: _CategoryTile(
                icon: Icons.music_note_outlined,
                title: 'Music',
                accent: Color(0xFFFFD8C8),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _CategoryTile(
                icon: Icons.volunteer_activism_outlined,
                title: 'Charity',
                accent: Color(0xFFFFD0DA),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DiscoverTab extends StatelessWidget {
  const _DiscoverTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
      children: [
        Text(
          'Recommended for You',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        const _FeaturedClubCard(
          accentStart: Color(0xFF0A7E74),
          accentEnd: Color(0xFF65B96A),
          heroIcon: Icons.eco_outlined,
          title: 'Eco-Warriors',
          description:
              'Join sustainability campaigns, garden projects, and cleanup drives around campus.',
          membersLabel: '89 Members',
          tagLabel: 'Social',
          wide: true,
        ),
        const SizedBox(height: 14),
        const _FeaturedClubCard(
          accentStart: Color(0xFF7451F8),
          accentEnd: Color(0xFF0E7C86),
          heroIcon: Icons.camera_alt_outlined,
          title: 'Photography',
          description:
              'Build your portfolio through campus photo walks and collaborative storytelling.',
          membersLabel: '124 Members',
          tagLabel: 'Arts',
          wide: true,
        ),
        const SizedBox(height: 24),
        const _SectionHeader(
          title: 'Popular Categories',
          badgeLabel: '8 Open',
        ),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _CompactCategoryChip(label: 'Technology'),
            _CompactCategoryChip(label: 'Leadership'),
            _CompactCategoryChip(label: 'Debate'),
            _CompactCategoryChip(label: 'Environment'),
            _CompactCategoryChip(label: 'Community'),
            _CompactCategoryChip(label: 'Innovation'),
          ],
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.badgeLabel,
  });

  final String title;
  final String badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFD8FFF6),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            badgeLabel,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }
}

class _JoinedCommunityCard extends StatelessWidget {
  const _JoinedCommunityCard({
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.role,
    required this.statusLabel,
    required this.statusColor,
    required this.statusTextColor,
    required this.scheduleLabel,
  });

  final IconData icon;
  final Color iconBackground;
  final String title;
  final String role;
  final String statusLabel;
  final Color statusColor;
  final Color statusTextColor;
  final String scheduleLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.white, size: 20),
              ),
              const SizedBox(width: 12),
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
                    Text(
                      role,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: statusTextColor,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.borderSubtle,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.outline),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  scheduleLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurface,
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

class _FeaturedClubCard extends StatelessWidget {
  const _FeaturedClubCard({
    required this.accentStart,
    required this.accentEnd,
    required this.heroIcon,
    required this.title,
    required this.description,
    required this.membersLabel,
    required this.tagLabel,
    this.wide = false,
  });

  final Color accentStart;
  final Color accentEnd;
  final IconData heroIcon;
  final String title;
  final String description;
  final String membersLabel;
  final String tagLabel;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wide ? double.infinity : 188,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 106,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [accentStart, accentEnd],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -10,
                    right: -6,
                    child: Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 18,
                    left: 14,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.white.withValues(alpha: 0.18)),
                      ),
                      child: Icon(heroIcon, color: AppColors.white, size: 24),
                    ),
                  ),
                  Positioned(
                    left: 74,
                    right: 12,
                    bottom: 22,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurface.withValues(alpha: 0.78),
                          height: 1.3,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          membersLabel,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAE7FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tagLabel,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Join Community'),
                    ),
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

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.icon,
    required this.title,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.onSurface, size: 18),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _CompactCategoryChip extends StatelessWidget {
  const _CompactCategoryChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
