import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_burgers/blocks/authentication_bloc/authentication_bloc.dart';
import 'package:my_burgers/screens/auth/blocks/sign_in_bloc/sign_in_bloc.dart';
import 'package:my_burgers/screens/auth/blocks/sign_up_bloc/sign_up_bloc.dart';
import 'package:my_burgers/screens/auth/views/sign_in_screen.dart';
import 'package:my_burgers/screens/auth/views/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              _buildContent(context),
              if (tabController.index == 0)
                _buildSignInScreen(context),
            ],
          ),
        ),
      ),
    );
  }


 Widget _buildContent(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
            context.read<AuthenticationBloc>().userRepository,
          ),
          child: const SignInScreen(),
        ),
      ),
    ],
  );
}


  Widget _buildSignInScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(
          context.read<AuthenticationBloc>().userRepository,
        ),
        child: const SignInScreen(),
      ),
    );
  }
}

Widget _buildSignUpScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        context.read<AuthenticationBloc>().userRepository,
      ),
      child: const SignUpScreen(),
    ),
  );
}

