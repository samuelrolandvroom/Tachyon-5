import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:tachyon_api_client/tachyon_api_client.dart';
import '../components/notification.dart' as toast;
import '../components/social_login_button.dart';

class SignupPage extends StatefulComponent {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();

  @css
  static List<StyleRule> get styles => [
    css('.name-row').styles(
      display: .flex,
      justifyContent: .spaceBetween,
    ),
    css('.name-row input').styles(
      width: 48.percent,
    ),
  ];
}

class _SignupPageState extends State<SignupPage> {
  String _email = '';
  String _password = '';
  String _username = '';
  String _firstName = '';
  String _lastName = '';

  bool _isLoading = false;
  String? _error;
  bool _showSuccess = false;

  Future<void> _signup(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _showSuccess = false;
    });

    try {
      final authRepo = context.read(authRepositoryProvider);
      await authRepo.signup(
        email: _email,
        password: _password,
        username: _username,
        firstName: _firstName,
        lastName: _lastName,
      );
      if (mounted) {
        setState(() => _showSuccess = true);
        await Future.delayed(const Duration(milliseconds: 2000));
        if (mounted) {
          Router.of(context).push('/login');
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
        if (response.status == 'complete') {
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
    if (error.contains('email already exists')) {
      return 'This email is already registered';
    }
    if (error.contains('username already exists')) {
      return 'This username is taken';
    }
    if (error.contains('phone number already exists')) {
      return 'This phone number is already registered';
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
          message: 'Account created successfully! Redirecting to login...',
          type: toast.NotificationType.success,
          duration: 2000,
        ),
      div(classes: 'auth-container', [
        h1(classes: 'logo-text', [text('TACHYON-5')]),
        p(classes: 'tagline', [text('LOGICAL VELOCITY')]),
        div(classes: 'auth-form', [
          h2([text('Create Account')]),

          // Social Login Section (at top for signup)
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

          div(classes: 'social-divider', [text('or sign up with email')]),

          div(classes: 'name-row', [
            input(
              classes: 'atlantis-input',
              type: InputType.text,
              attributes: {'placeholder': 'First Name'},
              onInput: (value) => _firstName = value as String,
            ),
            input(
              classes: 'atlantis-input',
              type: InputType.text,
              attributes: {'placeholder': 'Last Name'},
              onInput: (value) => _lastName = value as String,
            ),
          ]),
          input(
            classes: 'atlantis-input',
            type: InputType.text,
            attributes: {'placeholder': 'Username'},
            onInput: (value) => _username = value as String,
          ),
          input(
            classes: 'atlantis-input',
            type: InputType.email,
            attributes: {'placeholder': 'Email'},
            onInput: (value) => _email = value as String,
          ),
          input(
            classes: 'atlantis-input',
            type: InputType.password,
            attributes: {'placeholder': 'Password'},
            onInput: (value) => _password = value as String,
          ),
          button(
            classes: 'atlantis-button',
            onClick: () => _signup(context),
            [text(_isLoading ? 'Creating...' : 'Create Account')],
          ),
          p([
            text("Already have an account? "),
            a(href: '/login', [text('Sign In')]),
          ]),
        ]),
      ]),
    ]);
  }
}
