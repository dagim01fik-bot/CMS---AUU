import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import '../providers/scanner_provider.dart';
import '../widgets/checkpoint_header.dart';
import '../widgets/offline_warning_banner.dart';
import 'verification_detail_screen.dart';

class IdVerificationScreen extends ConsumerStatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  ConsumerState<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends ConsumerState<IdVerificationScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
  );
  late final ProviderSubscription<ScannerState> _scannerSubscription;

  @override
  void initState() {
    super.initState();
    _scannerSubscription = ref.listenManual<ScannerState>(
      scannerProvider,
      (previous, next) {
        final previousId = previous?.lastResult?.studentId;
        final nextResult = next.lastResult;
        if (!mounted || nextResult == null || previousId == nextResult.studentId) {
          return;
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }

          context.push(
            '/verify/detail',
            extra: VerificationDetailRouteArgs(
              result: nextResult,
              scannedAt: nextResult.verifiedAtUtc.toLocal(),
            ),
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _scannerSubscription.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final scanState = ref.watch(scannerProvider);

    if (!authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/login');
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ID Verification'),
        leadingWidth: 96,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextButton(
            onPressed: () {
              context.push('/history');
            },
            child: const Text('History'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (!context.mounted) return;
              context.go('/login');
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckpointHeader(
                officerName: authState.officerName,
                officerBadge: authState.officerBadge,
                checkpointName: authState.checkpointName,
              ),
              const SizedBox(height: 16),
              Card(
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 320,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      MobileScanner(
                        controller: _controller,
                        onDetect: (capture) {
                          final value = capture.barcodes.firstOrNull?.rawValue;
                          if (value != null) {
                            ref.read(scannerProvider.notifier).handleScan(value);
                          }
                        },
                      ),
                      Center(
                        child: Container(
                          width: 230,
                          height: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: AppColors.white, width: 3),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.black.withValues(alpha: 0.56),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            scanState.isVerifying
                                ? 'Verifying student ID...'
                                : 'Align the student QR inside the frame',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (scanState.manualWarning != null) ...[
                OfflineWarningBanner(message: scanState.manualWarning!),
                const SizedBox(height: 16),
              ],
              if (scanState.errorMessage != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              scanState.errorTitle == 'UNVERIFIED'
                                  ? Icons.gpp_bad_rounded
                                  : Icons.error_outline_rounded,
                              color: scanState.errorTitle == 'UNVERIFIED'
                                  ? AppColors.warning
                                  : AppColors.danger,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              scanState.errorTitle ?? 'FAILED',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          scanState.errorMessage!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Scan a student ID to open the verification card. Use History to review previous scans.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
