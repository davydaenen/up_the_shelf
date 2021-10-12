import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_the_shelf/src/utils/providers/auth_provider.dart';
import 'package:up_the_shelf/src/widgets/large_long_button.dart';

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
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
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
              color: Colors.grey[200],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
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
                const Text(
                  'Let\s sign in.',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Welcome back.',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[500]),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      labelText: 'Enter your email',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    obscureText: true,
                    maxLength: 12,
                    controller: _passwordController,
                    validator: (value) => value!.length < 6
                        ? 'Length must be between 6 and 12'
                        : null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        labelText: 'Enter your password',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                authProvider.status == Status.authenticating
                    ? const Center(
                        child: null,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[500]),
                          ),
                          TextButton(
                            child: const Text('Sign up'),
                            onPressed: () {
                              // Navigator.of(context)
                              //     .pushReplacementNamed(Routes.register);
                            },
                          ),
                        ],
                      ),
                authProvider.status == Status.authenticating
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : LargeLongButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context)
                                .unfocus(); //to hide the keyboard - if any

                            bool status =
                                await authProvider.signInWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);

                            if (!status) {
                              _scaffoldKey.currentState!
                                  .showSnackBar(const SnackBar(
                                content: Text('error logging in'),
                              ));
                            } else {
                              // Navigator.of(context)
                              //     .pushReplacementNamed(Routes.home);
                            }
                          }
                        },
                        buttonText: 'Sign in'),
              ],
            ),
          ),
        ));
  }
}
