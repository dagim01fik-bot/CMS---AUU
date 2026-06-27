import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AuthFlowStepper extends StatelessWidget {
  const AuthFlowStepper({
    super.key,
    required this.activeStep,
  });

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AuthStepItem(
            number: '1',
            label: 'ACTIVATION',
            isActive: activeStep == 1,
            isCompleted: activeStep > 1,
          ),
        ),
        Expanded(
          child: _AuthStepItem(
            number: '2',
            label: 'LOGIN',
            isActive: activeStep == 2,
            isCompleted: activeStep > 2,
          ),
        ),
        Expanded(
          child: _AuthStepItem(
            number: '3',
            label: 'CONFIRM',
            isActive: activeStep == 3,
            isLast: true,
          ),
        ),
      ],
    );
  }
}

class _AuthStepItem extends StatelessWidget {
  const _AuthStepItem({
    required this.number,
    required this.label,
    this.isActive = false,
    this.isCompleted = false,
    this.isLast = false,
  });

  final String number;
  final String label;
  final bool isActive;
  final bool isCompleted;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = isActive || isCompleted;
    final circleColor = isHighlighted ? AppColors.secondary : const Color(0xFFDDE2EF);
    final lineColor = isCompleted ? AppColors.secondary.withValues(alpha: 0.45) : const Color(0xFFDDE2EF);
    final textColor = isHighlighted ? AppColors.secondary : AppColors.outline;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
                height: 2,
                color: Colors.transparent,
              ),
            ),
            AnimatedScale(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutBack,
              scale: isActive ? 1.06 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
                height: 2,
                margin: EdgeInsets.only(right: isLast ? 0 : 6, left: 6),
                color: isLast ? Colors.transparent : lineColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOut,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: textColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
          child: Text(label),
        ),
      ],
    );
  }
}
