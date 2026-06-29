import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/services/student_id_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_mode_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _profileImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuANrVMjDHvptcDK7WkrGi5N6TK1dU5R6KpmKDvpLOr44t-M4Fw_YXqu0n0xeQJfQxpnzy57NSDlF99BsaKazh3CurXA5QmlJ5lBlZNqCP4AjQqje45tZ5RWqh6SryrCRdY2HEpe5G2EzAL_IPSp1oVZWAL5WHoLg8JyXXelejhLjfXzQMWYfhtsrUdRJ36hX83y5MiJ4fc840hcBnSrJJPNpq7XwpqHGpVnO-JPaRrqKbeydGD9inC6M9iBgGOXioVT2NFJdGIeb0c';
  final _studentIdService = StudentIdService();

  int _currentIndex = 0;
  bool _showMoreClasses = false;
  bool _isIdFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? FloatingActionButton(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.white,
              onPressed: _showAiTutorSheet,
              child: const Icon(Icons.smart_toy_outlined),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  _buildHomeTab(),
                  _buildAcademicsTab(),
                  _buildServicesTab(),
                  _buildProfileTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(21),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              _profileImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.person),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.outline,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Mekdes Alemu',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          _HeaderIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: () => _showSnack('No new notifications'),
            badge: true,
          ),
          const SizedBox(width: 8),
          _HeaderIconButton(
            icon: Icons.settings_outlined,
            onTap: () => _showInfoSheet(
              context,
              title: 'Settings',
              message: 'Account and app settings will be added in the next step.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _buildStudentIdCard(),
        const SizedBox(height: 16),
        _buildIdActions(),
        const SizedBox(height: 24),
        _buildTodayClassesHeader(),
        const SizedBox(height: 12),
        _buildTodayClassesCard(),
        const SizedBox(height: 24),
        _buildSectionTitle('Quick Actions'),
        const SizedBox(height: 12),
        _buildQuickActionsGrid(),
      ],
    );
  }

  Widget _buildAcademicsTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        Text(
          'Academic Performance',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 16),
        _buildAcademicStats(),
        const SizedBox(height: 20),
        _buildAcademicActions(),
        const SizedBox(height: 24),
        _buildSectionTitle('Academic Timeline'),
        const SizedBox(height: 12),
        _buildTimelineCard(),
      ],
    );
  }

  Widget _buildServicesTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        Text(
          'Campus Services',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 16),
        _buildWalletCard(),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.95,
          children: [
            _ServiceTile(
              icon: Icons.payments_outlined,
              title: 'Payments',
              subtitle: 'Balance, invoices, receipts',
              color: AppColors.primary,
              onTap: () => _handleServiceTap('payments'),
            ),
            _ServiceTile(
              icon: Icons.description_outlined,
              title: 'Documents',
              subtitle: 'Transcript and letters',
              color: AppColors.secondary,
              onTap: () => _handleServiceTap('documents'),
            ),
            _ServiceTile(
              icon: Icons.map_outlined,
              title: 'Directory & Map',
              subtitle: 'Buildings, offices, labs',
              color: Color(0xFF924628),
              onTap: () => _handleServiceTap('directory'),
            ),
            _ServiceTile(
              icon: Icons.chat_outlined,
              title: 'Help Desk',
              subtitle: 'IT, registrar, finance',
              color: Color(0xFF3D4947),
              onTap: () => _handleServiceTap('helpdesk'),
            ),
            _ServiceTile(
              icon: Icons.feedback_outlined,
              title: 'Feedback',
              subtitle: 'Complaints and suggestions',
              color: AppColors.primary,
              onTap: () => _handleServiceTap('feedback'),
            ),
            _ServiceTile(
              icon: Icons.workspace_premium_outlined,
              title: 'Graduation',
              subtitle: 'Status, clearance, ceremony',
              color: AppColors.secondary,
              onTap: () => _handleServiceTap('graduation'),
            ),
            _ServiceTile(
              icon: Icons.meeting_room_outlined,
              title: 'Roll & Room',
              subtitle: 'Room assignments and seats',
              color: Color(0xFF924628),
              onTap: () => _handleServiceTap('roll-room'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 3),
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    _profileImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 42),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: InkWell(
                    onTap: () => _handleProfileAction('personal-details'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 14, color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Mekdes Alemu',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'mekdes.alemu@hu.edu.et',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.outline,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        _buildSettingsGroup(
          title: 'ACCOUNT SETTINGS',
          items: const [
            _ProfileRowData(
              icon: Icons.person_outline,
              title: 'Personal Details',
              actionKey: 'personal-details',
            ),
            _ProfileRowData(
              icon: Icons.security_outlined,
              title: 'Security & Password',
              actionKey: 'security-password',
            ),
            _ProfileRowData(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              actionKey: 'privacy-policy',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSettingsGroup(
          title: 'PREFERENCES',
          items: [
            _ProfileRowData(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Theme',
              trailing: isDarkMode ? 'On' : 'Off',
              actionKey: 'dark-theme',
            ),
            const _ProfileRowData(
              icon: Icons.translate_outlined,
              title: 'Language',
              trailing: 'English',
              actionKey: 'language',
            ),
          ],
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () => _showSnack('Sign out flow will be connected to backend auth'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.errorRose,
            side: BorderSide(color: AppColors.errorRose.withValues(alpha: 0.25)),
            backgroundColor: AppColors.errorRose.withValues(alpha: 0.05),
          ),
          child: const Text('Sign Out'),
        ),
      ],
    );
  }

  Widget _buildStudentIdCard() {
    return Container(
      height: 258,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondary, Color(0xFF645EFB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: _isIdFlipped ? _buildStudentIdBack() : _buildStudentIdFront(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentIdFront() {
    return Stack(
      key: const ValueKey('front-id'),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 44, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 84,
                height: 114,
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.white.withValues(alpha: 0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  _profileImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.white,
                    child: const Icon(Icons.person, color: AppColors.primary, size: 36),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: _buildUniversityMark(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Mekdes Alemu',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                            height: 1.0,
                          ),
                    ),
                    const SizedBox(height: 6),
                    _buildIdLine('Computer Science'),
                    _buildIdLine('Department'),
                    _buildIdLine('Female'),
                    _buildIdLine('Year of Education: Year 3'),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.white.withValues(alpha: 0.14)),
                      ),
                      child: Text(
                        '2024/2025',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              letterSpacing: 0.3,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Container(
            width: 32,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'STU-ET-00918372',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUniversityMark() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white.withValues(alpha: 0.9), width: 1.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school_outlined,
                size: 9,
                color: AppColors.white.withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'HAWASSA\nUNIVERSITY',
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                height: 0.9,
                fontSize: 10,
                letterSpacing: 0.4,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          'Education',
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
        ),
      ],
    );
  }

  Widget _buildStudentIdBack() {
    return Container(
      key: const ValueKey('back-id'),
      padding: const EdgeInsets.fromLTRB(16, 18, 42, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.14),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: const Center(
                    child: Icon(Icons.qr_code_2_rounded, color: AppColors.black, size: 64),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'CS-2024-8842',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 9,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBackInfo('Emergency Contact', 'Hanna Alemu', '+251 91 445 2200'),
                const SizedBox(height: 12),
                Text(
                  'LIBRARY BARCODE',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.72),
                        fontWeight: FontWeight.w800,
                        fontSize: 9,
                        letterSpacing: 0.7,
                      ),
                ),
                const SizedBox(height: 3),
                _buildLibraryBarcode(),
                const SizedBox(height: 10),
                Text(
                  'BLOOD GROUP',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.72),
                        fontWeight: FontWeight.w800,
                        fontSize: 9,
                        letterSpacing: 0.7,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'O+',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdLine(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        value,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.white.withValues(alpha: 0.92),
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 1.0,
            ),
      ),
    );
  }

  Widget _buildIdActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ActionCircle(
          icon: Icons.flip_camera_android_outlined,
          label: 'Flip',
          onTap: () {
            setState(() {
              _isIdFlipped = !_isIdFlipped;
            });
          },
        ),
        _ActionCircle(
          icon: Icons.download_outlined,
          label: 'Save',
          onTap: () => _showSnack('Digital ID save/export will be connected next'),
        ),
        _ActionCircle(
          icon: Icons.qr_code_scanner_rounded,
          label: 'Enlarge',
          onTap: _showQrSheet,
        ),
        _ActionCircle(
          icon: Icons.share_outlined,
          label: 'Share',
          onTap: () => _showSnack('Secure share flow will be connected next'),
        ),
      ],
    );
  }

  Widget _buildBackInfo(String label, String value, String subValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.white.withValues(alpha: 0.72),
                fontWeight: FontWeight.w800,
                fontSize: 9,
                letterSpacing: 0.7,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
        ),
        const SizedBox(height: 1),
        Text(
          subValue,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.white.withValues(alpha: 0.88),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
        ),
      ],
    );
  }

  Widget _buildLibraryBarcode() {
    return Container(
      width: double.infinity,
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: CustomPaint(
        painter: _BarcodePainter(),
      ),
    );
  }

  Widget _buildTodayClassesHeader() {
    return Row(
      children: [
        Text(
          'Today\'s Classes',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '3 Classes Today',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  Widget _buildTodayClassesCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            onTap: () {
              setState(() {
                _showMoreClasses = !_showMoreClasses;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.successGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ONGOING',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.successGreen,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        'Room A203',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.outline,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Database Systems',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '08:30 AM - 10:00 AM',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),
          if (_showMoreClasses) ...[
            const Divider(height: 1),
            const _UpcomingClassRow(
              title: 'Computer Networks',
              time: '10:00 AM - 11:30 AM',
              room: 'Room B105',
            ),
            const Divider(height: 1),
            const _UpcomingClassRow(
              title: 'Mobile Development',
              time: '02:00 PM - 03:30 PM',
              room: 'Room C201',
            ),
          ],
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.secondary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.schedule, size: 16, color: AppColors.white),
                const SizedBox(width: 8),
                Text(
                  'Next class starts in 35 minutes',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.push('/schedule'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(58),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  side: BorderSide(
                    color: AppColors.secondary.withValues(alpha: 0.7),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('View Full Schedule'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    const topRowHeight = 270.0;

    return Column(
      children: [
        SizedBox(
          height: topRowHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _SchoolActivitiesExpandedCard(
                  onTap: () => _handleQuickActionTap('school-activities'),
                  arrowCircleColor: const Color(0xFFD8CB66),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _QuickActionMiniCard(
                        title: 'Clubs',
                        subtitle: 'Join campus clubs',
                        color: const Color(0xFFB8E8C8),
                        arrowCircleColor: const Color(0xFFA8D2B4),
                        onTap: () => _handleQuickActionTap('clubs'),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: _QuickActionMiniCard(
                        title: 'Schedule',
                        subtitle: 'Classes & more',
                        color: const Color(0xFFF5C0CE),
                        arrowCircleColor: const Color(0xFFE6B0C2),
                        onTap: () => _handleQuickActionTap('schedule'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _QuickActionMiniCard(
          title: 'Announcements',
          subtitle: 'Critical alerts',
          color: const Color(0xFFC9C4F0),
          minHeight: 92,
          arrowCircleColor: const Color(0xFFA9A0D9),
          badgeText: '2 new',
          onTap: () => _handleQuickActionTap('announcements'),
        ),
      ],
    );
  }

  Widget _buildAcademicStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatBox(
                title: 'CUMULATIVE GPA',
                value: '3.82',
                color: AppColors.primary,
                background: AppColors.primary.withValues(alpha: 0.06),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatBox(
                title: 'SEM. CREDITS',
                value: '21/21',
                color: AppColors.secondary,
                background: AppColors.secondary.withValues(alpha: 0.06),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROGRAM PROGRESS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.outline,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '92 of 140 Credits Completed',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 4),
                ),
                child: Center(
                  child: Text(
                    '65%',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAcademicActions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.02,
      children: [
        _FeatureCard(
          icon: Icons.grade_outlined,
          title: 'Grades',
          subtitle: 'View semester results',
          color: AppColors.primary,
          onTap: () => _handleAcademicTap('grades'),
        ),
        _FeatureCard(
          icon: Icons.fact_check_outlined,
          title: 'Attendance',
          subtitle: 'Track your presence',
          color: AppColors.secondary,
          onTap: () => _handleAcademicTap('attendance'),
        ),
        _FeatureCard(
          icon: Icons.auto_stories_outlined,
          title: 'Curriculum',
          subtitle: 'Course descriptions',
          color: Color(0xFF924628),
          onTap: () => _handleAcademicTap('curriculum'),
        ),
        _FeatureCard(
          icon: Icons.psychology_alt_outlined,
          title: 'AI Tutor',
          subtitle: 'Personalized study aid',
          color: AppColors.secondary,
          filled: true,
          onTap: () => _handleAcademicTap('ai-tutor'),
        ),
        _FeatureCard(
          icon: Icons.library_books_outlined,
          title: 'Digital Library',
          subtitle: 'Access e-books & journals',
          color: AppColors.primary,
          onTap: () => _handleAcademicTap('digital-library'),
        ),
        _FeatureCard(
          icon: Icons.quiz_outlined,
          title: 'Self Test',
          subtitle: 'Practice assessments',
          color: AppColors.secondary,
          onTap: () => _handleAcademicTap('self-test'),
        ),
        _FeatureCard(
          icon: Icons.schedule_outlined,
          title: 'Timeline',
          subtitle: 'Self-study and library time',
          color: Color(0xFF924628),
          onTap: () => _handleAcademicTap('timeline'),
        ),
        _FeatureCard(
          icon: Icons.bolt_outlined,
          title: 'Real-time Test Result',
          subtitle: 'Instant assessment feedback',
          color: AppColors.primary,
          onTap: () => _handleAcademicTap('live-results'),
        ),
      ],
    );
  }

  Widget _buildTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: const Column(
        children: [
          _TimelineItem(
            color: AppColors.primary,
            date: 'Sep 15',
            title: 'Research Proposal Due',
            subtitle: 'Database Systems Research',
            showLine: true,
          ),
          SizedBox(height: 18),
          _TimelineItem(
            color: AppColors.secondary,
            date: 'Oct 02',
            title: 'Mid-term Project Review',
            subtitle: 'Software Engineering II',
            showLine: true,
          ),
          SizedBox(height: 18),
          _TimelineItem(
            color: Color(0xFF924628),
            date: 'Nov 20',
            title: 'Internship Application Week',
            subtitle: 'Career Development Center',
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return InkWell(
      onTap: () => _handleServiceTap('payments'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Wallet Balance',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.outline,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'NO DUES',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'ETB 0.00',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Last Transaction',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.outline,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      'INV-2026-0412',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<_ProfileRowData> items,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6, bottom: 10),
          child: Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.outline,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  ListTile(
                    leading: Icon(item.icon, color: colorScheme.outline),
                    title: Text(item.title),
                    trailing: item.trailing != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.trailing!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                      color: item.actionKey == 'dark-theme'
                                          ? (item.trailing == 'On'
                                              ? AppColors.successGreen
                                              : colorScheme.outline)
                                          : AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(width: 2),
                              Icon(Icons.chevron_right, color: colorScheme.outlineVariant),
                            ],
                          )
                        : Icon(Icons.chevron_right, color: colorScheme.outlineVariant),
                    onTap: () => _handleProfileAction(item.actionKey),
                  ),
                  if (index != items.length - 1)
                    Divider(
                      height: 1,
                      color: colorScheme.outlineVariant,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: 72,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.school_outlined,
            activeIcon: Icons.school,
            label: 'Academics',
            index: 1,
          ),
          _buildNavItem(
            icon: Icons.grid_view_outlined,
            activeIcon: Icons.grid_view_rounded,
            label: 'Services',
            index: 2,
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primary : const Color(0xFF888888),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive ? AppColors.primary : const Color(0xFF888888),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showInfoSheet(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.outline,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAiTutorSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.78,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.psychology_alt_outlined, color: AppColors.secondary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HU AI Academic Tutor',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'ONLINE & READY',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.successGreen,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _ChatBubble(
                        message:
                            'Hello Mekdes! I reviewed your Database Systems coursework. Would you like a summary of Chapter 4 before class starts?',
                        isUser: false,
                      ),
                      const SizedBox(height: 12),
                      _ChatBubble(
                        message: 'Yes, summarize normalization and key rules.',
                        isUser: true,
                      ),
                      const SizedBox(height: 12),
                      _ChatBubble(
                        message:
                            'Normalization organizes tables to reduce redundancy. The key levels you need today are 1NF, 2NF, and 3NF.',
                        isUser: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.gray,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Ask about your courses...',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.outline,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: AppColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showQrSheet() async {
    try {
      final qrData = await _studentIdService.fetchQr();
      if (!mounted) {
        return;
      }

      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        builder: (context) {
          return SafeArea(
            top: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final sheetWidth = constraints.maxWidth;
                final qrCardSize = math.min(sheetWidth - 76, 220.0);
                final qrImageSize = math.max(qrCardSize - 40, 140.0);

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    16,
                    24,
                    28 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.outlineVariant,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Campus Pass QR',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColors.borderSubtle),
                        ),
                        child: Container(
                          width: qrCardSize,
                          height: qrCardSize,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: QrImageView(
                              data: qrData.opaqueToken,
                              size: qrImageSize,
                              backgroundColor: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        qrData.displayName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        qrData.studentId,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.outline,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Show this QR code at campus entry points or library checkout counters for identification.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.outline,
                              height: 1.45,
                            ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Done'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      _showSnack('Sign in first and make sure the backend is available.');
    }
  }

  void _handleQuickActionTap(String key) {
    switch (key) {
      case 'clubs':
        context.push('/clubs');
        break;
      case 'school-activities':
        context.push('/school-activities');
        break;
      case 'announcements':
        context.push('/announcements');
        break;
      case 'schedule':
        context.push('/schedule');
        break;
      case 'payments':
        _handleServiceTap('payments');
        break;
    }
  }

  void _handleAcademicTap(String key) {
    switch (key) {
      case 'grades':
        context.push('/grades');
        break;
      case 'attendance':
        context.push('/attendance');
        break;
      case 'curriculum':
        context.push('/curriculum');
        break;
      case 'ai-tutor':
        _showAiTutorSheet();
        break;
      case 'digital-library':
        context.push('/digital-library');
        break;
      case 'self-test':
        context.push('/self-test');
        break;
      case 'timeline':
        context.push('/timeline');
        break;
      case 'live-results':
        context.push('/realtime-results');
        break;
    }
  }

  void _handleServiceTap(String key) {
    switch (key) {
      case 'payments':
        context.push('/payments');
        break;
      case 'documents':
        context.push('/documents');
        break;
      case 'directory':
        context.push('/directory');
        break;
      case 'helpdesk':
        context.push('/helpdesk');
        break;
      case 'feedback':
        context.push('/feedback');
        break;
      case 'graduation':
        context.push('/graduation');
        break;
      case 'roll-room':
        context.push('/roll-room');
        break;
    }
  }

  void _handleProfileAction(String key) {
    switch (key) {
      case 'personal-details':
        _showDetailSheet(
          title: 'Personal Details',
          subtitle: 'Your verified identity and registrar-managed profile data appear here for review.',
          icon: Icons.person_outline,
          color: AppColors.primary,
          ctaLabel: 'Review Profile',
          details: const [
            _DetailLineData(label: 'Student ID', value: 'STU-ET-00918372'),
            _DetailLineData(label: 'Department', value: 'Computer Science'),
            _DetailLineData(label: 'Email', value: 'mekdes.alemu@hu.edu.et'),
          ],
        );
        break;
      case 'security-password':
        _showDetailSheet(
          title: 'Security & Password',
          subtitle: 'Monitor session safety, password freshness, and trusted-device protection status.',
          icon: Icons.security_outlined,
          color: AppColors.secondary,
          ctaLabel: 'Security Review',
          details: const [
            _DetailLineData(label: 'Last Password Update', value: '29 days ago'),
            _DetailLineData(label: 'Trusted Devices', value: '1 Android device'),
            _DetailLineData(label: 'Account Protection', value: 'JWT session active and healthy'),
          ],
        );
        break;
      case 'privacy-policy':
        _showDetailSheet(
          title: 'Privacy Policy',
          subtitle: 'See how student data, audit logs, and service records are protected inside the CMS.',
          icon: Icons.privacy_tip_outlined,
          color: AppColors.primary,
          ctaLabel: 'Read Summary',
          details: const [
            _DetailLineData(label: 'Sensitive Data', value: 'Encrypted at rest'),
            _DetailLineData(label: 'Access Model', value: 'Role-based and auditable'),
            _DetailLineData(label: 'Data Sharing', value: 'Limited to approved campus workflows'),
          ],
        );
        break;
      case 'dark-theme':
        final notifier = ref.read(themeModeProvider.notifier);
        final isDarkMode = ref.read(themeModeProvider) == ThemeMode.dark;
        notifier.setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
        _showSnack(isDarkMode ? 'Light theme enabled' : 'Dark theme enabled');
        break;
      case 'language':
        _showDetailSheet(
          title: 'Language',
          subtitle: 'The student app is ready for language preferences and localized labels in future steps.',
          icon: Icons.translate_outlined,
          color: AppColors.primary,
          ctaLabel: 'Use English',
          details: const [
            _DetailLineData(label: 'Current Language', value: 'English'),
            _DetailLineData(label: 'Prepared Option', value: 'Amharic localization next'),
            _DetailLineData(label: 'Content Scope', value: 'Menus, forms, and alerts'),
          ],
        );
        break;
    }
  }

  void _showDetailSheet({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<_DetailLineData> details,
    required String ctaLabel,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.outlineVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 26),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.outline,
                        height: 1.45,
                      ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: details.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = details[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.borderSubtle),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 102,
                              child: Text(
                                item.label,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.outline,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    item.value,
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: AppColors.onSurface,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(ctaLabel),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.badge = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.surface,
            ),
            child: Icon(icon, color: AppColors.outline),
          ),
        ),
        if (badge)
          const Positioned(
            top: 8,
            right: 10,
            child: SizedBox(
              width: 8,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.errorRose,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionCircle extends StatelessWidget {
  const _ActionCircle({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(21),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(21),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Icon(icon, size: 20, color: AppColors.outline),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
    required this.isUser,
  });

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser ? AppColors.secondary : const Color(0xFFF1F4FA),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isUser ? AppColors.white : AppColors.onSurface,
                    height: 1.45,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Just now',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isUser
                        ? AppColors.white.withValues(alpha: 0.7)
                        : AppColors.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


class _UpcomingClassRow extends StatelessWidget {
  const _UpcomingClassRow({
    required this.title,
    required this.time,
    required this.room,
  });

  final String title;
  final String time;
  final String room;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Upcoming',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$time • $room',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.outline,
                ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: filled ? color : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: filled ? Colors.transparent : AppColors.borderSubtle,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: filled ? AppColors.white.withValues(alpha: 0.16) : color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: filled ? AppColors.white : color, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: filled ? AppColors.white : AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: filled
                        ? AppColors.white.withValues(alpha: 0.84)
                        : AppColors.outline,
                    height: 1.35,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.title,
    required this.value,
    required this.color,
    required this.background,
  });

  final String title;
  final String value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.color,
    required this.date,
    required this.title,
    required this.subtitle,
    this.showLine = false,
  });

  final Color color;
  final String date;
  final String title;
  final String subtitle;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 18,
          child: Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              if (showLine)
                Container(
                  width: 2,
                  height: 46,
                  color: AppColors.outlineVariant.withValues(alpha: 0.35),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.outline,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.outline,
                    height: 1.35,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SchoolActivitiesExpandedCard extends StatelessWidget {
  const _SchoolActivitiesExpandedCard({
    required this.onTap,
    required this.arrowCircleColor,
  });

  final VoidCallback onTap;
  final Color arrowCircleColor;

  static const _activities = [
    _ActivityData(
      icon: Icons.emoji_events_outlined,
      iconBg: Color(0xFFD4F5E4),
      iconColor: Color(0xFF2E6E42),
      name: 'Community Service',
      pts: '+50',
    ),
    _ActivityData(
      icon: Icons.laptop_outlined,
      iconBg: Color(0xFFDCEEFF),
      iconColor: Color(0xFF1A5FAD),
      name: 'Tech Talk Event',
      pts: '+30',
    ),
    _ActivityData(
      icon: Icons.favorite_outline,
      iconBg: Color(0xFFFFE0E0),
      iconColor: Color(0xFFB0323C),
      name: 'Blood Donation',
      pts: '+40',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFF9E87B),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E).withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 20,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'School\nActivities',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                            height: 1.25,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IgnorePointer(
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: arrowCircleColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_outward,
                        color: AppColors.black,
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ..._activities.asMap().entries.map((e) {
                final idx = e.key;
                final a = e.value;
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: a.iconBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(a.icon, color: a.iconColor, size: 14),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            a.name,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1A1A2E),
                                  height: 1.2,
                                ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${a.pts}\npts',
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2E6E42),
                                height: 1.15,
                              ),
                        ),
                      ],
                    ),
                    if (idx < _activities.length - 1)
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        color: const Color(0x14000000),
                      ),
                    if (idx == _activities.length - 1) const SizedBox(height: 8),
                  ],
                );
              }),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xB3FFFFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF7E0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.emoji_events, color: Color(0xFFD4A017), size: 14),
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL\nPOINTS',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: 8,
                                color: const Color(0xFF888888),
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                                letterSpacing: 0.3,
                              ),
                        ),
                        Text(
                          '480',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A1A2E),
                                height: 1.1,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'RANK',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: 8,
                                color: const Color(0xFF888888),
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                                letterSpacing: 0.3,
                              ),
                        ),
                        Text(
                          '#12',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A1A2E),
                                height: 1.1,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityData {
  const _ActivityData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.name,
    required this.pts,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String name;
  final String pts;
}

class _QuickActionMiniCard extends StatelessWidget {
  const _QuickActionMiniCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    required this.arrowCircleColor,
    this.minHeight = 130,
    this.badgeText,
  });

  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final Color arrowCircleColor;
  final double minHeight;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -28,
              right: -28,
              child: Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E).withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: 34,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E).withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A2E),
                              height: 1.2,
                            ),
                      ),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: arrowCircleColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_outward,
                        color: AppColors.black,
                        size: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: const Color(0xFF1A1A2E).withValues(alpha: 0.7),
                            height: 1.2,
                          ),
                    ),
                    if (badgeText != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE8E8),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          badgeText!,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color(0xFFB0323C),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRowData {
  const _ProfileRowData({
    required this.icon,
    required this.title,
    required this.actionKey,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String actionKey;
  final String? trailing;
}

class _DetailLineData {
  const _DetailLineData({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

class _BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.black;
    final bars = <double>[
      2, 1, 3, 1, 1, 2, 4, 1, 2, 1, 3, 2, 1, 1, 4, 2, 1, 3, 1, 2, 2, 1, 4,
      1, 1, 3, 2, 1, 2, 3, 1, 1, 4, 1, 2, 2, 3, 1, 1, 2, 4, 1, 2, 1, 3, 2,
    ];
    final totalUnits = bars.fold<double>(0, (sum, value) => sum + value);
    final unitWidth = size.width / totalUnits;
    var x = 0.0;

    for (var i = 0; i < bars.length; i++) {
      final width = bars[i] * unitWidth;
      if (i.isEven) {
        canvas.drawRect(Rect.fromLTWH(x, 0, width, size.height), paint);
      }
      x += width;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
