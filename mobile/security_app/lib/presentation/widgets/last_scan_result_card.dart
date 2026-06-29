import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/verify_student_id_response.dart';

class LastScanResultCard extends StatelessWidget {
  const LastScanResultCard({
    super.key,
    required this.result,
    this.onVerifyTap,
  });

  final VerifyStudentIdResponse result;
  final VoidCallback? onVerifyTap;

  @override
  Widget build(BuildContext context) {
    final isOffline = result.isOffline;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isOffline ? Icons.warning_amber_rounded : Icons.verified_rounded,
                  color: isOffline ? AppColors.warning : AppColors.success,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isOffline
                        ? 'OFFLINE — VERIFY MANUALLY'
                        : 'VERIFIED • just now',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 68,
                    height: 68,
                    child: result.photoThumbnailUrl == null ||
                            result.photoThumbnailUrl!.isEmpty
                        ? Container(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            child: const Icon(
                              Icons.person_rounded,
                              color: AppColors.primary,
                              size: 34,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: result.photoThumbnailUrl!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              child: const Icon(
                                Icons.person_rounded,
                                color: AppColors.primary,
                                size: 34,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.studentName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      if (onVerifyTap != null) ...[
                        const SizedBox(height: 14),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: onVerifyTap,
                            icon: const Icon(Icons.verified_user_rounded),
                            label: const Text('Verify'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(156, 46),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Student ID: ${result.studentId}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _line(context, '${result.program} • Year ${result.yearOfStudy}'),
                      _line(context, 'Status: ${result.enrollmentStatus}'),
                      _line(context, 'Academic year ${result.academicYear}'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
