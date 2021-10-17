import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/utils/providers/auth_provider.dart';
import 'package:up_the_shelf/src/widgets/large_long_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: MaterialButton(
          elevation: 0.0,
          visualDensity: VisualDensity.compact,
          shape: const CircleBorder(),
          color: Colors.blueGrey.withOpacity(0.1),
          padding: const EdgeInsets.all(0),
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(Icons.chevron_left, color: Colors.white),
        ),
      ),
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/book-pattern.jpeg"),
                      fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: const Color.fromRGBO(99, 179, 211, 1.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: _buildForm(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.screenSignInTextSignUp,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  validator: (value) => value!.isEmpty
                      ? AppLocalizations.of(context)!
                          .screenSignInInputEmailValidation
                      : null,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    labelText: AppLocalizations.of(context)!
                        .screenSignInInputEmailLabel,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) => value!.isEmpty
                        ? AppLocalizations.of(context)!
                            .screenSignInInputPasswordLabel
                        : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      labelText: AppLocalizations.of(context)!
                          .screenSignInInputPasswordValidation,
                    ),
                  ),
                ),
                LargeLongButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();

                        final user =
                            await authProvider.registerWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text);

                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .screenSignInTextErrorSignIn),
                          ));
                        }

                        // In case of success
                        // AuthWidgetBuilder will handle authentication
                      }
                    },
                    loading: authProvider.status == Status.authenticating,
                    buttonText:
                        AppLocalizations.of(context)!.screenSignInTextSignUp),
              ],
            ),
          ),
        ));
  }
}
