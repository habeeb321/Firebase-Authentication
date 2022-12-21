import 'package:firebase_authentication/controller/auth_provider.dart';
import 'package:firebase_authentication/core/const.dart';
import 'package:firebase_authentication/view/register_form/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  Future<void> signIn(AuthProvider provider) async {
    final msg = await provider.signIn(email.text, pass.text);
    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final cx = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/logo-logomark.svg'),
                    const Text(
                      'Firebase',
                      style: TextStyle(
                        color: clrText,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    height10,
                    const Text(
                      'Authentication',
                      style: TextStyle(
                        color: clrText,
                        fontSize: 36,
                      ),
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: clrText,
                        fontSize: 18,
                      ),
                    ),
                    height10,
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                    ),
                    height20,
                    TextField(
                      controller: pass,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Password'),
                      ),
                    ),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterForm())),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 14,
                              color: clrText,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              fontSize: 14,
                              color: clrText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (authProvider.loading)
                      const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    if (!authProvider.loading)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => signIn(authProvider),
                          child: const Text('Sign in'),
                        ),
                      ),
                    height10,
                    Row(
                      children: [
                        SizedBox(
                            width: (cx.width / 2) - 20, child: const Divider()),
                        const Text('Or', style: TextStyle(color: clrText)),
                        SizedBox(
                            width: (cx.width / 2) - 30, child: const Divider()),
                      ],
                    ),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFE4E7EA),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SvgPicture.asset('assets/icons8-google.svg'),
                                const Text(
                                  'Sign in wth Google',
                                  style: TextStyle(color: clrText),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF000000),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/Apple_logo_grey.svg',
                                  width: 40,
                                ),
                                const Text(
                                  'Sign in wth Apple',
                                  style: TextStyle(color: clrText),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
