import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/verify_student_id_response.dart';

class VerificationDetailRouteArgs {
  const VerificationDetailRouteArgs({
    required this.result,
    this.scannedAt,
  });

  final VerifyStudentIdResponse result;
  final DateTime? scannedAt;
}

class VerificationDetailScreen extends StatelessWidget {
  const VerificationDetailScreen({
    super.key,
    required this.args,
  });

  final VerificationDetailRouteArgs args;

  @override
  Widget build(BuildContext context) {
    final result = args.result;
    final scannedAt = args.scannedAt ?? result.verifiedAtUtc.toLocal();
    final statusColor = result.isOffline ? AppColors.warning : AppColors.success;
    final statusLabel =
        result.isOffline ? 'OFFLINE - VERIFY MANUALLY' : 'VERIFIED FOR ENTRY';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Verification'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.16),
                        ),
                      ),
                      child: Text(
                        'UniGate Security Pass',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _StudentPhoto(photoUrl: result.photoThumbnailUrl),
                    const SizedBox(height: 18),
                    Text(
                      result.studentName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        result.studentId,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                            ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Text(
                            statusLabel,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            result.enrollmentStatus,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailRow(label: 'Program', value: result.program),
                      _DetailRow(
                        label: 'Year of Study',
                        value: 'Year ${result.yearOfStudy}',
                      ),
                      _DetailRow(label: 'Academic Year', value: result.academicYear),
                      _DetailRow(
                        label: 'Verified At',
                        value: _formatDateTime(scannedAt.toLocal()),
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
              if (result.warningMessage != null && result.warningMessage!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.warning.withValues(alpha: 0.28),
                    ),
                  ),
                  child: Text(
                    result.warningMessage!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime value) {
    final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final minute = value.minute.toString().padLeft(2, '0');
    final suffix = value.hour >= 12 ? 'PM' : 'AM';
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$day/$month/${value.year}  $hour:$minute $suffix';
  }
}

class _StudentPhoto extends StatelessWidget {
  const _StudentPhoto({
    required this.photoUrl,
  });

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: AppColors.white.withValues(alpha: 0.18),
      ),
      clipBehavior: Clip.antiAlias,
      child: photoUrl == null || photoUrl!.isEmpty
          ? const Icon(
              Icons.person_rounded,
              size: 64,
              color: AppColors.white,
            )
          : CachedNetworkImage(
              imageUrl: photoUrl!,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(
                Icons.person_rounded,
                size: 64,
                color: AppColors.white,
              ),
            ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
