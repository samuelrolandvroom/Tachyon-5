import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class SocialLoginButton extends StatelessComponent {
  const SocialLoginButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final SocialProvider provider;
  final void Function() onPressed;

  @override
  Component build(BuildContext context) {
    final config = _getProviderConfig(provider);

    return button(
      classes: 'social-button social-button-${config.className}',
      onClick: onPressed,
      [
        span(classes: 'social-icon', [text(config.icon)]),
        span(classes: 'social-text', [text('Continue with ${config.name}')]),
      ],
    );
  }

  _ProviderConfig _getProviderConfig(SocialProvider provider) {
    switch (provider) {
      case SocialProvider.google:
        return _ProviderConfig(
          name: 'Google',
          icon: 'G',
          className: 'google',
        );
      case SocialProvider.microsoft:
        return _ProviderConfig(
          name: 'Microsoft',
          icon: 'Ⓜ',
          className: 'microsoft',
        );
      case SocialProvider.apple:
        return _ProviderConfig(
          name: 'Apple',
          icon: '',
          className: 'apple',
        );
    }
  }
}

class _ProviderConfig {
  const _ProviderConfig({
    required this.name,
    required this.icon,
    required this.className,
  });

  final String name;
  final String icon;
  final String className;
}

enum SocialProvider {
  google,
  microsoft,
  apple,
}
