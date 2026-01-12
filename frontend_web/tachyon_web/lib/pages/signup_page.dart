import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:tachyon_api_client/tachyon_api_client.dart';
import 'package:tachyon_core/tachyon_core.dart';

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
    css('.error-text').styles(
      color: Color(TachyonColors.hexError),
      padding: .all(10.px),
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

  Future<void> _signup(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _error = null;
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
        Router.of(context).push('/login');
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
        h2([text('Create Account')]),

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

        if (_error != null) p(classes: 'error-text', [text(_error!)]),

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
    ]);
  }
}
