import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? label; // old usage
  final String? text;  // new usage
  final VoidCallback onPressed;
  final bool loading;
  final IconData? icon;
  final double? width;
  final double? height;

  const PrimaryButton({
    Key? key,
    this.label,
    this.text,
    required this.onPressed,
    this.loading = false,
    this.icon,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Prefer `text` if available, otherwise fallback to `label`
    final displayText = text ?? label ?? "";

    final child = loading
        ? const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
        ],
        Text(
          displayText,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: loading ? null : onPressed,
        child: child,
      ),
    );
  }
}
