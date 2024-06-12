import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:burger_repository/burger_repository.dart';
import 'package:my_burgers/blocks/authentication_bloc/authentication_bloc.dart';
import 'package:my_burgers/screens/auth/blocks/sign_in_bloc/sign_in_bloc.dart';
import 'package:my_burgers/screens/home/blocks/get_burger_bloc/get_burger_bloc.dart';

import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Burger Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.light(background: Colors.grey.shade200, onBackground: Colors.black, primary: Colors.blue, onPrimary: Colors.white)),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
                  ),
                  BlocProvider(
                    create: (context) => GetBurgerBloc(
                      FirebaseBurgerRepo()
                    )..add(GetBurger()),
                  ),
                ],
                child: const HomeScreen()
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        ));
  }
}