import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class ToastNotification extends StatefulComponent {
  const ToastNotification({
    required this.message,
    required this.type,
    this.duration = 4000,
    super.key,
  });

  final String message;
  final NotificationType type;
  final int duration;

  @override
  State<ToastNotification> createState() => _ToastNotificationState();
}

class _ToastNotificationState extends State<ToastNotification> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    // Auto-dismiss after duration
    Future.delayed(Duration(milliseconds: component.duration), () {
      if (mounted) {
        setState(() => _visible = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    if (!_visible) {
      return div([]);
    }

    final typeClass = component.type == NotificationType.success ? 'notification-success' : 'notification-error';

    final icon = component.type == NotificationType.success ? '✓' : '⚠';

    return div(
      classes: 'notification $typeClass',
      [
        span(classes: 'notification-icon', [text(icon)]),
        span(classes: 'notification-message', [text(component.message)]),
      ],
    );
  }
}

enum NotificationType {
  success,
  error,
}
