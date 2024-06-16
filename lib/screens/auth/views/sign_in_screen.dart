import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_burgers/component/my_text_field.dart';
import 'package:my_burgers/screens/auth/blocks/sign_in_bloc/sign_in_bloc.dart';
import 'package:my_burgers/screens/auth/blocks/sign_up_bloc/sign_up_bloc.dart';
import 'package:my_burgers/screens/auth/views/sign_up_screen.dart';
import 'package:my_burgers/utilities/constants.dart';
import 'package:my_burgers/blocks/authentication_bloc/authentication_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = Icons.visibility;
  bool obscurePassword = true;
  String? _errorMsg;
  bool _rememberMe = false;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: MyTextField(
            controller: emailController,
            hintText: 'Enter your Email',
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            errorMsg: _errorMsg,
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please fill in this field';
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: MyTextField(
            controller: passwordController,
            hintText: 'Enter your Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            errorMsg: _errorMsg,
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please fill in this field';
              } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                return 'Please enter a valid password';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                  iconPassword = obscurePassword ? Icons.visibility : Icons.visibility_off;
                });
              },
              icon: Icon(iconPassword),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        style: TextButton.styleFrom(padding: const EdgeInsets.only(right: 0.0)),
        child: const Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return state is! SignInProcess
              ? ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInBloc>().add(SignInRequired(
                            emailController.text,
                            passwordController.text,
                          ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15.0), backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                )
              : const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildSignInWithText() {
    return const Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(void Function()? onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            const AssetImage(
              'assets/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            const AssetImage(
              'assets/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(
                context.read<AuthenticationBloc>().userRepository,
              ),
              child: const SignUpScreen(),
            ),
          ),
        );
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            setState(() {
              signInRequired = false;
            });
          } else if (state is SignInProcess) {
            setState(() {
              signInRequired = true;
            });
          } else if (state is SignInFailure) {
            setState(() {
              signInRequired = false;
              _errorMsg = 'Invalid email or password';
            });
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color(0xFF398AE5),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          _buildEmailTF(),
                          const SizedBox(
                            height: 30.0,
                          ),
                          _buildPasswordTF(),
                          _buildForgotPasswordBtn(),
                          _buildRememberMeCheckbox(),
                          _buildLoginBtn(),
                          _buildSignInWithText(),
                          _buildSocialBtnRow(),
                          _buildSignupBtn(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
