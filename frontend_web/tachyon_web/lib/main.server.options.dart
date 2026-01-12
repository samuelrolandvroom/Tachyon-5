// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:tachyon_web/pages/login_page.dart' as _login_page;
import 'package:tachyon_web/pages/onboarding_page.dart' as _onboarding_page;
import 'package:tachyon_web/pages/signup_page.dart' as _signup_page;
import 'package:tachyon_web/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {_app.App: ClientTarget<_app.App>('app')},
  styles: () => [
    ..._login_page.LoginPage.styles,
    ..._onboarding_page.OnboardingPage.styles,
    ..._signup_page.SignupPage.styles,
  ],
);
