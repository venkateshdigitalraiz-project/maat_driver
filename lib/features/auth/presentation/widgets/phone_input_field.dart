import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isReadOnly;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditPressed;
  final VoidCallback? onClearPressed;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.isReadOnly = false,
    this.errorText,
    this.onChanged,
    this.onEditPressed,
    this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mobile Number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isReadOnly ? const Color(0xFFF1F5F9) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: errorText != null
                  ? AppColors.error
                  : isReadOnly
                      ? AppColors.border
                      : AppColors.border,
              width: 1.2,
            ),
            boxShadow: isReadOnly
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Row(
            children: [
              // Country Code Prefix Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: AppColors.border,
                      width: 1.2,
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🇮🇳',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Phone Number Input
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: isReadOnly,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: isReadOnly ? AppColors.textSecondary : AppColors.textPrimary,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: 'Enter 10-digit number',
                    hintStyle: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    suffixIcon: isReadOnly
                        ? TextButton.icon(
                            onPressed: onEditPressed,
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            label: const Text(
                              'Change',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        : (controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  size: 18,
                                  color: AppColors.textMuted,
                                ),
                                onPressed: onClearPressed,
                              )
                            : null),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 14,
                  color: AppColors.error,
                ),
                const SizedBox(width: 4),
                Text(
                  errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
