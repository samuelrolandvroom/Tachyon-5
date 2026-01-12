import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:tachyon_api_client/tachyon_api_client.dart';
import '../components/notification.dart' as toast;
import '../components/social_login_button.dart';

class LoginPage extends StatefulComponent {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _identifier = '';
  String _password = '';
  bool _isLoading = false;
  String? _error;
  bool _showSuccess = false;

  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _showSuccess = false;
    });

    try {
      final authRepo = context.read(authRepositoryProvider);
      await authRepo.login(_identifier, _password);
      if (mounted) {
        setState(() => _showSuccess = true);
        await Future.delayed(const Duration(milliseconds: 1500));
        if (mounted) {
          Router.of(context).push('/onboarding');
        }
      }
    } catch (e) {
      setState(() => _error = _formatError(e.toString()));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSocialLogin(BuildContext context, SocialProvider provider) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _showSuccess = false;
    });

    try {
      final authRepo = context.read(authRepositoryProvider);
      final providerName = provider.name;

      // For development, use mock token
      final mockToken = 'mock_${providerName}_${DateTime.now().millisecondsSinceEpoch}';

      final response = await authRepo.socialLogin(providerName, mockToken);

      if (mounted) {
        if (response.isProfileComplete ?? true) {
          // Existing user - redirect to onboarding
          setState(() => _showSuccess = true);
          await Future.delayed(const Duration(milliseconds: 1500));
          if (mounted) {
            Router.of(context).push('/onboarding');
          }
        } else {
          // New user - needs profile completion
          // TODO: Navigate to profile completion page
          setState(() => _error = 'Profile completion not yet implemented');
        }
      }
    } catch (e) {
      setState(() => _error = _formatError(e.toString()));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _formatError(String error) {
    if (error.contains('Invalid credentials')) {
      return 'Invalid email, username, or password';
    }
    if (error.contains('Failed to fetch')) {
      return 'Unable to connect to server';
    }
    return 'An error occurred. Please try again.';
  }

  @override
  Component build(BuildContext context) {
    return div([
      if (_error != null)
        toast.ToastNotification(
          message: _error!,
          type: toast.NotificationType.error,
        ),
      if (_showSuccess)
        toast.ToastNotification(
          message: 'Welcome back! Redirecting...',
          type: toast.NotificationType.success,
        ),
      div(classes: 'auth-container', [
        h1(classes: 'logo-text', [text('TACHYON-5')]),
        p(classes: 'tagline', [text('LOGICAL VELOCITY')]),
        div(classes: 'auth-form', [
          h2([text('Sign In')]),
          p([text('Enter your email, username, or phone')]),
          input(
            classes: 'atlantis-input',
            type: InputType.text,
            attributes: {'placeholder': 'Identifier'},
            onInput: (value) => _identifier = value as String,
          ),
          input(
            classes: 'atlantis-input',
            type: InputType.password,
            attributes: {'placeholder': 'Password'},
            onInput: (value) => _password = value as String,
          ),
          button(
            classes: 'atlantis-button',
            onClick: () => _login(context),
            [text(_isLoading ? 'Processing...' : 'Continue')],
          ),

          // Social Login Section
          div(classes: 'social-divider', [text('or continue with')]),

          div(classes: 'social-buttons', [
            SocialLoginButton(
              provider: SocialProvider.google,
              onPressed: () => _handleSocialLogin(context, SocialProvider.google),
            ),
            SocialLoginButton(
              provider: SocialProvider.microsoft,
              onPressed: () => _handleSocialLogin(context, SocialProvider.microsoft),
            ),
            SocialLoginButton(
              provider: SocialProvider.apple,
              onPressed: () => _handleSocialLogin(context, SocialProvider.apple),
            ),
          ]),

          p([
            text("Don't have an account? "),
            a(href: '/signup', [text('Sign Up')]),
          ]),
        ]),
      ]),
    ]);
  }
}
