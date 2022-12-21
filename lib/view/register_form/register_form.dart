import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/controller/auth_provider.dart';
import 'package:firebase_authentication/core/const.dart';
import 'package:firebase_authentication/view/home_page/home_page.dart';
import 'package:firebase_authentication/view/login_screen/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  Future<void> signUp(AuthProvider provider) async {
    final msg = await provider.signUp(email.text, pass.text);
    if (msg == '') return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final cx = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();
    return StreamBuilder<User?>(
        stream: authProvider.stream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          }
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
                            'Register',
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
                                        builder: (_) => const LoginForm())),
                                child: const Text(
                                  'Login',
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
                                onPressed: () => signUp(authProvider),
                                child: const Text('Sign Up'),
                              ),
                            ),
                          height10,
                          Row(
                            children: [
                              SizedBox(
                                  width: (cx.width / 2) - 20,
                                  child: const Divider()),
                              const Text('Or',
                                  style: TextStyle(color: clrText)),
                              SizedBox(
                                  width: (cx.width / 2) - 30,
                                  child: const Divider()),
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
                                      SvgPicture.asset(
                                          'assets/icons8-google.svg'),
                                      const Text(
                                        'Sign up wth Google',
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
                                        'Sign up wth Apple',
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
        });
  }
}
