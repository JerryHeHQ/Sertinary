// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i9;

import '../screens/home_screen.dart' as _i4;
import '../user_authentication/forgot_password/forgot_password_screen.dart'
    as _i3;
import '../user_authentication/login/login_screen.dart' as _i1;
import '../user_authentication/registration/register_email_screen.dart' as _i6;
import '../user_authentication/registration/register_password_screen.dart'
    as _i7;
import '../user_authentication/registration/register_username_screen.dart'
    as _i5;
import '../user_authentication/registration/register_verify_screen.dart' as _i8;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    RegisterRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.ForgotPasswordScreen());
    },
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.HomeScreen());
    },
    RegisterUsernameRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.RegisterUsernameScreen());
    },
    RegisterEmailRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterEmailRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i6.RegisterEmailScreen(key: args.key, username: args.username));
    },
    RegisterPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterPasswordRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.RegisterPasswordScreen(
              key: args.key, username: args.username, email: args.email));
    },
    RegisterVerifyRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.RegisterVerifyScreen());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig('/#redirect',
            path: '/', redirectTo: 'login', fullMatch: true),
        _i2.RouteConfig(LoginRoute.name, path: 'login'),
        _i2.RouteConfig(RegisterRoute.name, path: 'register', children: [
          _i2.RouteConfig('#redirect',
              path: '',
              parent: RegisterRoute.name,
              redirectTo: 'register_username',
              fullMatch: true),
          _i2.RouteConfig(RegisterUsernameRoute.name,
              path: 'register_username', parent: RegisterRoute.name),
          _i2.RouteConfig(RegisterEmailRoute.name,
              path: 'register_email', parent: RegisterRoute.name),
          _i2.RouteConfig(RegisterPasswordRoute.name,
              path: 'register_password', parent: RegisterRoute.name),
          _i2.RouteConfig(RegisterVerifyRoute.name,
              path: 'register_verify', parent: RegisterRoute.name)
        ]),
        _i2.RouteConfig(ForgotPasswordRoute.name, path: 'forgot_password'),
        _i2.RouteConfig(HomeRoute.name, path: 'home')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class RegisterRoute extends _i2.PageRouteInfo<void> {
  const RegisterRoute({List<_i2.PageRouteInfo>? children})
      : super(RegisterRoute.name, path: 'register', initialChildren: children);

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i2.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: 'forgot_password');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.RegisterUsernameScreen]
class RegisterUsernameRoute extends _i2.PageRouteInfo<void> {
  const RegisterUsernameRoute()
      : super(RegisterUsernameRoute.name, path: 'register_username');

  static const String name = 'RegisterUsernameRoute';
}

/// generated route for
/// [_i6.RegisterEmailScreen]
class RegisterEmailRoute extends _i2.PageRouteInfo<RegisterEmailRouteArgs> {
  RegisterEmailRoute({_i9.Key? key, required String username})
      : super(RegisterEmailRoute.name,
            path: 'register_email',
            args: RegisterEmailRouteArgs(key: key, username: username));

  static const String name = 'RegisterEmailRoute';
}

class RegisterEmailRouteArgs {
  const RegisterEmailRouteArgs({this.key, required this.username});

  final _i9.Key? key;

  final String username;

  @override
  String toString() {
    return 'RegisterEmailRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i7.RegisterPasswordScreen]
class RegisterPasswordRoute
    extends _i2.PageRouteInfo<RegisterPasswordRouteArgs> {
  RegisterPasswordRoute(
      {_i9.Key? key, required String username, required String email})
      : super(RegisterPasswordRoute.name,
            path: 'register_password',
            args: RegisterPasswordRouteArgs(
                key: key, username: username, email: email));

  static const String name = 'RegisterPasswordRoute';
}

class RegisterPasswordRouteArgs {
  const RegisterPasswordRouteArgs(
      {this.key, required this.username, required this.email});

  final _i9.Key? key;

  final String username;

  final String email;

  @override
  String toString() {
    return 'RegisterPasswordRouteArgs{key: $key, username: $username, email: $email}';
  }
}

/// generated route for
/// [_i8.RegisterVerifyScreen]
class RegisterVerifyRoute extends _i2.PageRouteInfo<void> {
  const RegisterVerifyRoute()
      : super(RegisterVerifyRoute.name, path: 'register_verify');

  static const String name = 'RegisterVerifyRoute';
}
