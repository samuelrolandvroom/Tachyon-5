import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:tachyon_api_client/tachyon_api_client.dart';

import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/onboarding_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return ProviderScope(
      overrides: [
        apiBaseUrlProvider.overrideWithValue('http://localhost:8183'),
      ],
      child: Router(
        routes: [
          Route(path: '/', builder: (context, state) => const LoginPage()),
          Route(path: '/login', builder: (context, state) => const LoginPage()),
          Route(path: '/signup', builder: (context, state) => const SignupPage()),
          Route(path: '/onboarding', builder: (context, state) => const OnboardingPage()),
        ],
      ),
    );
  }
}
