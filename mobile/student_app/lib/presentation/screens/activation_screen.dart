import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/auth_flow_stepper.dart';

class ActivationScreen extends ConsumerStatefulWidget {
  const ActivationScreen({super.key});

  @override
  ConsumerState<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends ConsumerState<ActivationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _activationController = TextEditingController();
  int _activeStep = 1;

  @override
  void dispose() {
    _activationController.dispose();
    super.dispose();
  }

  void _formatActivationCode(String value) {
    final sanitized = value.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();
    final buffer = StringBuffer();

    for (var i = 0; i < sanitized.length && i < 16; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write('-');
      }
      buffer.write(sanitized[i]);
    }

    final formatted = buffer.toString();
    if (formatted != _activationController.text) {
      _activationController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  Future<bool> _verifyActivation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _activeStep = 2;
      });
      await Future<void>.delayed(const Duration(milliseconds: 320));
      if (!mounted) {
        return false;
      }
      context.go('/login');
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMd,
            vertical: AppConstants.paddingSm,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                  const Icon(
                    Icons.lock_rounded,
                    size: 22,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Secure Access',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.outlineVariant),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.question_mark_rounded,
                      size: 16,
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderSubtle),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthFlowStepper(activeStep: _activeStep),
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Initialize Account',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 220),
                          child: Text(
                            'Enter your corporate activation key to verify your identity.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.outline,
                                  height: 1.45,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Activation Key',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _activationController,
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9-]')),
                          LengthLimitingTextInputFormatter(19),
                        ],
                        onChanged: _formatActivationCode,
                        decoration: InputDecoration(
                          hintText: 'XXXX-XXXX-XXXX-XXXX',
                          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.outlineVariant,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                              ),
                          prefixIcon: const Icon(
                            Icons.key_outlined,
                            color: AppColors.outline,
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Activation code is required';
                          }
                          if (value.trim().length != 19) {
                            return 'Enter a valid activation code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F4FB),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const SizedBox(height: 20),
                      ),
                      const SizedBox(height: 18),
                      _VerifySliderButton(
                        onTap: _verifyActivation,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Icon(
                  Icons.key,
                  size: 20,
                  color: AppColors.black.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

class _VerifySliderButton extends StatelessWidget {
  const _VerifySliderButton({required this.onTap});

  final Future<bool> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return _VerifySlider(onComplete: onTap);
  }
}

class _VerifySlider extends StatefulWidget {
  const _VerifySlider({required this.onComplete});

  final Future<bool> Function() onComplete;

  @override
  State<_VerifySlider> createState() => _VerifySliderState();
}

class _VerifySliderState extends State<_VerifySlider>
    with SingleTickerProviderStateMixin {
  static const double _trackHeight = 60;
  static const double _thumbSize = 52;
  static const double _horizontalPadding = 4;

  double _dragPosition = 0;
  bool _isDragging = false;
  bool _isCompleting = false;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details, double maxDrag) {
    if (_isCompleting) return;
    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(0.0, maxDrag);
    });
  }

  void _handleDragEnd(double maxDrag) {
    if (_isCompleting) return;
    setState(() => _isDragging = false);

    final isVerified = _dragPosition >= maxDrag * 0.85;
    if (isVerified) {
      setState(() {
        _isCompleting = true;
        _dragPosition = maxDrag;
      });
      HapticFeedback.mediumImpact();

      Future<void>.delayed(const Duration(milliseconds: 220), () async {
        if (!mounted) return;
        final didPass = await widget.onComplete();
        if (!didPass && mounted) {
          setState(() {
            _isCompleting = false;
            _dragPosition = 0;
          });
        }
      });
      return;
    }

    setState(() => _dragPosition = 0);
  }

  Widget _buildTrackChevrons() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.14;
            final raw = (_pulseController.value - delay) % 1.0;
            final progress = Curves.easeInOut.transform(raw.clamp(0.0, 1.0));
            final opacity = progress <= 0 ? 0.25 : (0.25 + progress * 0.75);
            final translateX = -6 + (progress * 18);

            return Transform.translate(
              offset: Offset(translateX, 0),
              child: Opacity(
                opacity: opacity,
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFA5B4FC),
                  size: 24,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildThumbContent() {
    if (_isCompleting) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 350),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.white,
              size: 26,
            ),
          );
        },
      );
    }

    return const Icon(
      Icons.chevron_right_rounded,
      color: AppColors.white,
      size: 28,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxDrag = constraints.maxWidth - (_horizontalPadding * 2) - _thumbSize;
        final progress = maxDrag == 0 ? 0.0 : _dragPosition / maxDrag;
        final labelOpacity = (1 - progress * 1.8).clamp(0.0, 1.0);

        return Container(
          height: _trackHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: labelOpacity.toDouble(),
                    child: Text(
                      _isCompleting ? 'Verifying...' : 'Slide to Confirm',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _horizontalPadding + _dragPosition - 54,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: (progress * 3.0).clamp(0.0, 1.0),
                    child: _buildTrackChevrons(),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                left: _horizontalPadding + _dragPosition,
                child: GestureDetector(
                  onHorizontalDragStart: (_) => setState(() => _isDragging = true),
                  onHorizontalDragUpdate: (details) => _handleDragUpdate(details, maxDrag),
                  onHorizontalDragEnd: (_) => _handleDragEnd(maxDrag),
                  child: AnimatedScale(
                    scale: _isDragging ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOut,
                    child: Container(
                      width: _thumbSize,
                      height: _thumbSize,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF6366F1),
                            Color(0xFF4F46E5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withValues(alpha: 0.5),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                          if (_isDragging)
                            BoxShadow(
                              color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                              blurRadius: 24,
                              spreadRadius: 4,
                            ),
                        ],
                      ),
                      child: Center(child: _buildThumbContent()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
