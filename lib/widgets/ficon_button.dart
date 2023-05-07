import 'package:flutter/material.dart';

import 'ftap_effect.dart';

class FIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double size;
  final Color? iconColor;
  final EdgeInsets padding;
  final String? tooltip;
  final Color? backgroundColor;

  const FIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.onLongPress,
    this.size = 20,
    this.iconColor,
    this.padding = const EdgeInsets.all(8),
    this.tooltip,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  Widget _buildIcon(BuildContext context) {
    return IconTheme.merge(
      data: IconThemeData(color: iconColor ?? Theme.of(context).colorScheme.primary, size: size),
      child: icon,
    );
  }

  Widget _buildButton(BuildContext context) {
    final btn = Material(
      type: backgroundColor == null ? MaterialType.transparency : MaterialType.circle,
      color: backgroundColor,
      child: _buildPlatformWrapper(
        context: context,
        child: _buildIcon(context),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip ?? '',
        child: btn,
      );
    }
    return btn;
  }

  Widget _buildPlatformWrapper({
    required Widget child,
    required BuildContext context,
  }) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          onLongPress: onLongPress,
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return FTapEffect(
          onTap: onPressed,
          onLongPressed: onLongPress,
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: _buildButton(context),
    );
  }
}