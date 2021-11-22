import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/ui/auth/sign_up_screen.dart';
import 'package:up_the_shelf/src/utils/providers/auth_provider.dart';
import 'package:up_the_shelf/src/widgets/large_long_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  AppLocalizations.of(context)!.screenSignInTitle,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context)!.screenSignInSubTitle,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[500]),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.screenSignInTextNoAccount,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[500]),
                    ),
                    TextButton(
                      child: Text(
                          AppLocalizations.of(context)!.screenSignInTextSignUp),
                      onPressed: () {
                        if (authProvider.status == Status.unauthenticated ||
                            authProvider.status == Status.uninitialized) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const SignUpScreen();
                          }));
                        }
                      },
                    ),
                  ],
                ),
                LargeLongButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();

                        bool status =
                            await authProvider.signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text);

                        if (!status) {
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
                        AppLocalizations.of(context)!.screenSignInTextSignIn),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            AppLocalizations.of(context)!
                                .screenSignInTextSocialDivider,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[500]))
                      ]),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildSocialLogins(authProvider)),
              ],
            ),
          ),
        ));
  }

  List<Widget> _buildSocialLogins(AuthProvider authProvider) {
    return [
      MaterialButton(
        elevation: 0.0,
        shape: CircleBorder(
            side: BorderSide(
                color: AppTheme.greyColor!,
                width: 2,
                style: BorderStyle.solid)),
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(25),
        onPressed: () async {
          FocusScope.of(context).unfocus();

          bool status = await authProvider.signInWithGoogle();

          if (!status) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .screenSignInTextErrorSignInGoogle),
            ));
          }

          // In case of success
          // AuthWidgetBuilder will handle authentication
        },
        child: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/images/google-logo.png')),
      )
    ];
  }
}
