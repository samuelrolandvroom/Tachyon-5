import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:tachyon_api_client/tachyon_api_client.dart';
import 'package:tachyon_core/tachyon_core.dart';

class LoginPage extends StatefulComponent {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  @css
  static List<StyleRule> get styles => [
    css('.error-text').styles(
      color: Color(TachyonColors.hexError),
      padding: .all(10.px),
    ),
  ];
}

class _LoginPageState extends State<LoginPage> {
  String _identifier = '';
  String _password = '';
  bool _isLoading = false;
  String? _error;

  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final authRepo = context.read(authRepositoryProvider);
      await authRepo.login(_identifier, _password);
      if (mounted) {
        Router.of(context).push('/onboarding');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'auth-container', [
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

        if (_error != null) p(classes: 'error-text', [text(_error!)]),

        button(
          classes: 'atlantis-button',
          onClick: () => _login(context),
          [text(_isLoading ? 'Processing...' : 'Continue')],
        ),

        p([
          text("Don't have an account? "),
          a(href: '/signup', [text('Sign Up')]),
        ]),
      ]),
    ]);
  }
}
