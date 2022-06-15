// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as i2;
import 'package:flutter/material.dart' as i31;

import '../screens/alarms_screens/alarms_add.dart' as i12;
import '../screens/alarms_screens/alarms_calculator.dart' as i11;
import '../screens/alarms_screens/alarms_change_theme.dart' as i13;
import '../screens/alarms_screens/alarms_edit.dart' as i14;
import '../screens/alarms_screens/alarms_screen.dart' as i10;
import '../screens/home_screen.dart' as i4;
import '../screens/planner_screens/planner_add.dart' as i29;
import '../screens/planner_screens/planner_change_date.dart' as i30;
import '../screens/planner_screens/planner_screen.dart' as i27;
import '../screens/planner_screens/planner_work_rythmn.dart' as i28;
import '../screens/social_screens/social_add_post.dart' as i17;
import '../screens/social_screens/social_edit_post.dart' as i18;
import '../screens/social_screens/social_edit_profile.dart' as i22;
import '../screens/social_screens/social_my_posts.dart' as i16;
import '../screens/social_screens/social_profile.dart' as i21;
import '../screens/social_screens/social_screen.dart' as i15;
import '../screens/social_screens/social_view_post.dart' as i19;
import '../screens/social_screens/social_view_user.dart' as i20;
import '../screens/tracker_screens/tracker_add.dart' as i25;
import '../screens/tracker_screens/tracker_change_date.dart' as i26;
import '../screens/tracker_screens/tracker_overview.dart' as i24;
import '../screens/tracker_screens/tracker_screen.dart' as i23;
import '../screens/welcome_screens/welcome_screen.dart' as i9;
import '../user_authentication/forgot_password/forgot_password_screen.dart'
    as i3;
import '../user_authentication/login/login_screen.dart' as i1;
import '../user_authentication/registration/register_email_screen.dart' as i6;
import '../user_authentication/registration/register_password_screen.dart'
    as i7;
import '../user_authentication/registration/register_username_screen.dart'
    as i5;
import '../user_authentication/registration/register_verify_screen.dart' as i8;

class AppRouter extends i2.RootStackRouter {
  AppRouter([i31.GlobalKey<i31.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, i2.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i1.LoginScreen());
    },
    RegisterRoute.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i2.EmptyRouterPage());
    },
    ForgotPasswordRoute.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i3.ForgotPasswordScreen());
    },
    HomeRoute.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i4.HomeScreen());
    },
    RegisterUsernameRoute.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i5.RegisterUsernameScreen());
    },
    RegisterEmailRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterEmailRouteArgs>();
      return i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              i6.RegisterEmailScreen(key: args.key, username: args.username));
    },
    RegisterPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterPasswordRouteArgs>();
      return i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: i7.RegisterPasswordScreen(
              key: args.key, username: args.username, email: args.email));
    },
    RegisterVerifyRoute.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i8.RegisterVerifyScreen());
    },
    WelcomeRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i9.WelcomeScreen());
    },
    AlarmsRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i2.EmptyRouterPage());
    },
    SocialRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i2.EmptyRouterPage());
    },
    TrackerRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i2.EmptyRouterPage());
    },
    PlannerRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i2.EmptyRouterPage());
    },
    AlarmsScreenRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i10.AlarmsScreen());
    },
    AlarmsCalculatorRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i11.AlarmsCalculator());
    },
    AlarmsAddRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i12.AlarmsAdd());
    },
    AlarmsChangeThemeRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i13.AlarmsChangeTheme());
    },
    AlarmsEditRouter.name: (routeData) {
      final args = routeData.argsAs<AlarmsEditRouterArgs>();
      return i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: i14.AlarmsEdit(key: args.key, alarmID: args.alarmID));
    },
    SocialScreenRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i15.SocialScreen());
    },
    SocialMyPostsRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i16.SocialMyPosts());
    },
    SocialAddPostRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i17.SocialAddPost());
    },
    SocialEditPostRouter.name: (routeData) {
      final args = routeData.argsAs<SocialEditPostRouterArgs>();
      return i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: i18.SocialEditPost(key: args.key, postID: args.postID));
    },
    SocialViewPostRouter.name: (routeData) {
      final args = routeData.argsAs<SocialViewPostRouterArgs>();
      return i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: i19.SocialViewPost(key: args.key, postID: args.postID));
    },
    SocialViewUserRouter.name: (routeData) {
      final args = routeData.argsAs<SocialViewUserRouterArgs>();
      return i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: i20.SocialViewUser(key: args.key, userID: args.userID));
    },
    SocialProfileRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i21.SocialProfile());
    },
    SocialEditProfileRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i22.SocialEditProfile());
    },
    TrackerScreenRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i23.TrackerScreen());
    },
    TrackerOverviewRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i24.TrackerOverview());
    },
    TrackerAddRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i25.TrackerAdd());
    },
    TrackerChangeDateRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i26.TrackerChangeDate());
    },
    PlannerScreenRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i27.PlannerScreen());
    },
    PlannerWorkRythmnRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i28.PlannerWorkRythmn());
    },
    PlannerAddRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i29.PlannerAdd());
    },
    PlannerChangeDateRouter.name: (routeData) {
      return i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const i30.PlannerChangeDate());
    }
  };

  @override
  List<i2.RouteConfig> get routes => [
        i2.RouteConfig('/#redirect',
            path: '/', redirectTo: 'login', fullMatch: true),
        i2.RouteConfig(LoginRoute.name, path: 'login'),
        i2.RouteConfig(RegisterRoute.name, path: 'register', children: [
          i2.RouteConfig('#redirect',
              path: '',
              parent: RegisterRoute.name,
              redirectTo: 'register_username',
              fullMatch: true),
          i2.RouteConfig(RegisterUsernameRoute.name,
              path: 'register_username', parent: RegisterRoute.name),
          i2.RouteConfig(RegisterEmailRoute.name,
              path: 'register_email', parent: RegisterRoute.name),
          i2.RouteConfig(RegisterPasswordRoute.name,
              path: 'register_password', parent: RegisterRoute.name),
          i2.RouteConfig(RegisterVerifyRoute.name,
              path: 'register_verify', parent: RegisterRoute.name)
        ]),
        i2.RouteConfig(ForgotPasswordRoute.name, path: 'forgot_password'),
        i2.RouteConfig(HomeRoute.name, path: 'home', children: [
          i2.RouteConfig(WelcomeRouter.name,
              path: 'welcome', parent: HomeRoute.name),
          i2.RouteConfig(AlarmsRouter.name,
              path: 'alarms',
              parent: HomeRoute.name,
              children: [
                i2.RouteConfig('#redirect',
                    path: '',
                    parent: AlarmsRouter.name,
                    redirectTo: 'alarms_screen',
                    fullMatch: true),
                i2.RouteConfig(AlarmsScreenRouter.name,
                    path: 'alarms_screen', parent: AlarmsRouter.name),
                i2.RouteConfig(AlarmsCalculatorRouter.name,
                    path: 'alarms_calculator', parent: AlarmsRouter.name),
                i2.RouteConfig(AlarmsAddRouter.name,
                    path: 'alarms_add', parent: AlarmsRouter.name),
                i2.RouteConfig(AlarmsChangeThemeRouter.name,
                    path: 'alarms_change_theme', parent: AlarmsRouter.name),
                i2.RouteConfig(AlarmsEditRouter.name,
                    path: 'alarms_edit', parent: AlarmsRouter.name)
              ]),
          i2.RouteConfig(SocialRouter.name,
              path: 'social',
              parent: HomeRoute.name,
              children: [
                i2.RouteConfig('#redirect',
                    path: '',
                    parent: SocialRouter.name,
                    redirectTo: 'social_screen',
                    fullMatch: true),
                i2.RouteConfig(SocialScreenRouter.name,
                    path: 'social_screen', parent: SocialRouter.name),
                i2.RouteConfig(SocialMyPostsRouter.name,
                    path: 'social_my_posts', parent: SocialRouter.name),
                i2.RouteConfig(SocialAddPostRouter.name,
                    path: 'social_add_post', parent: SocialRouter.name),
                i2.RouteConfig(SocialEditPostRouter.name,
                    path: 'social_edit_post', parent: SocialRouter.name),
                i2.RouteConfig(SocialViewPostRouter.name,
                    path: 'social_view_post', parent: SocialRouter.name),
                i2.RouteConfig(SocialViewUserRouter.name,
                    path: 'social_view_user', parent: SocialRouter.name),
                i2.RouteConfig(SocialProfileRouter.name,
                    path: 'social_profile', parent: SocialRouter.name),
                i2.RouteConfig(SocialEditProfileRouter.name,
                    path: 'social_edit_profile', parent: SocialRouter.name)
              ]),
          i2.RouteConfig(TrackerRouter.name,
              path: 'tracker',
              parent: HomeRoute.name,
              children: [
                i2.RouteConfig('#redirect',
                    path: '',
                    parent: TrackerRouter.name,
                    redirectTo: 'tracker_screen',
                    fullMatch: true),
                i2.RouteConfig(TrackerScreenRouter.name,
                    path: 'tracker_screen', parent: TrackerRouter.name),
                i2.RouteConfig(TrackerOverviewRouter.name,
                    path: 'tracker_overview', parent: TrackerRouter.name),
                i2.RouteConfig(TrackerAddRouter.name,
                    path: 'tracker_add', parent: TrackerRouter.name),
                i2.RouteConfig(TrackerChangeDateRouter.name,
                    path: 'tracker_change_date', parent: TrackerRouter.name),
                i2.RouteConfig(SocialViewPostRouter.name,
                    path: 'social_view_post', parent: TrackerRouter.name),
                i2.RouteConfig(SocialViewUserRouter.name,
                    path: 'social_view_user', parent: TrackerRouter.name)
              ]),
          i2.RouteConfig(PlannerRouter.name,
              path: 'planner',
              parent: HomeRoute.name,
              children: [
                i2.RouteConfig('#redirect',
                    path: '',
                    parent: PlannerRouter.name,
                    redirectTo: 'planner_screen',
                    fullMatch: true),
                i2.RouteConfig(PlannerScreenRouter.name,
                    path: 'planner_screen', parent: PlannerRouter.name),
                i2.RouteConfig(PlannerWorkRythmnRouter.name,
                    path: 'planner_work_rythmn', parent: PlannerRouter.name),
                i2.RouteConfig(PlannerAddRouter.name,
                    path: 'planner_add', parent: PlannerRouter.name),
                i2.RouteConfig(PlannerChangeDateRouter.name,
                    path: 'planner_change_date', parent: PlannerRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [i1.LoginScreen]
class LoginRoute extends i2.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [i2.EmptyRouterPage]
class RegisterRoute extends i2.PageRouteInfo<void> {
  const RegisterRoute({List<i2.PageRouteInfo>? children})
      : super(RegisterRoute.name, path: 'register', initialChildren: children);

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [i3.ForgotPasswordScreen]
class ForgotPasswordRoute extends i2.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: 'forgot_password');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [i4.HomeScreen]
class HomeRoute extends i2.PageRouteInfo<void> {
  const HomeRoute({List<i2.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [i5.RegisterUsernameScreen]
class RegisterUsernameRoute extends i2.PageRouteInfo<void> {
  const RegisterUsernameRoute()
      : super(RegisterUsernameRoute.name, path: 'register_username');

  static const String name = 'RegisterUsernameRoute';
}

/// generated route for
/// [i6.RegisterEmailScreen]
class RegisterEmailRoute extends i2.PageRouteInfo<RegisterEmailRouteArgs> {
  RegisterEmailRoute({i31.Key? key, required String username})
      : super(RegisterEmailRoute.name,
            path: 'register_email',
            args: RegisterEmailRouteArgs(key: key, username: username));

  static const String name = 'RegisterEmailRoute';
}

class RegisterEmailRouteArgs {
  const RegisterEmailRouteArgs({this.key, required this.username});

  final i31.Key? key;

  final String username;

  @override
  String toString() {
    return 'RegisterEmailRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [i7.RegisterPasswordScreen]
class RegisterPasswordRoute
    extends i2.PageRouteInfo<RegisterPasswordRouteArgs> {
  RegisterPasswordRoute(
      {i31.Key? key, required String username, required String email})
      : super(RegisterPasswordRoute.name,
            path: 'register_password',
            args: RegisterPasswordRouteArgs(
                key: key, username: username, email: email));

  static const String name = 'RegisterPasswordRoute';
}

class RegisterPasswordRouteArgs {
  const RegisterPasswordRouteArgs(
      {this.key, required this.username, required this.email});

  final i31.Key? key;

  final String username;

  final String email;

  @override
  String toString() {
    return 'RegisterPasswordRouteArgs{key: $key, username: $username, email: $email}';
  }
}

/// generated route for
/// [i8.RegisterVerifyScreen]
class RegisterVerifyRoute extends i2.PageRouteInfo<void> {
  const RegisterVerifyRoute()
      : super(RegisterVerifyRoute.name, path: 'register_verify');

  static const String name = 'RegisterVerifyRoute';
}

/// generated route for
/// [i9.WelcomeScreen]
class WelcomeRouter extends i2.PageRouteInfo<void> {
  const WelcomeRouter() : super(WelcomeRouter.name, path: 'welcome');

  static const String name = 'WelcomeRouter';
}

/// generated route for
/// [i2.EmptyRouterPage]
class AlarmsRouter extends i2.PageRouteInfo<void> {
  const AlarmsRouter({List<i2.PageRouteInfo>? children})
      : super(AlarmsRouter.name, path: 'alarms', initialChildren: children);

  static const String name = 'AlarmsRouter';
}

/// generated route for
/// [i2.EmptyRouterPage]
class SocialRouter extends i2.PageRouteInfo<void> {
  const SocialRouter({List<i2.PageRouteInfo>? children})
      : super(SocialRouter.name, path: 'social', initialChildren: children);

  static const String name = 'SocialRouter';
}

/// generated route for
/// [i2.EmptyRouterPage]
class TrackerRouter extends i2.PageRouteInfo<void> {
  const TrackerRouter({List<i2.PageRouteInfo>? children})
      : super(TrackerRouter.name, path: 'tracker', initialChildren: children);

  static const String name = 'TrackerRouter';
}

/// generated route for
/// [i2.EmptyRouterPage]
class PlannerRouter extends i2.PageRouteInfo<void> {
  const PlannerRouter({List<i2.PageRouteInfo>? children})
      : super(PlannerRouter.name, path: 'planner', initialChildren: children);

  static const String name = 'PlannerRouter';
}

/// generated route for
/// [i10.AlarmsScreen]
class AlarmsScreenRouter extends i2.PageRouteInfo<void> {
  const AlarmsScreenRouter()
      : super(AlarmsScreenRouter.name, path: 'alarms_screen');

  static const String name = 'AlarmsScreenRouter';
}

/// generated route for
/// [i11.AlarmsCalculator]
class AlarmsCalculatorRouter extends i2.PageRouteInfo<void> {
  const AlarmsCalculatorRouter()
      : super(AlarmsCalculatorRouter.name, path: 'alarms_calculator');

  static const String name = 'AlarmsCalculatorRouter';
}

/// generated route for
/// [i12.AlarmsAdd]
class AlarmsAddRouter extends i2.PageRouteInfo<void> {
  const AlarmsAddRouter() : super(AlarmsAddRouter.name, path: 'alarms_add');

  static const String name = 'AlarmsAddRouter';
}

/// generated route for
/// [i13.AlarmsChangeTheme]
class AlarmsChangeThemeRouter extends i2.PageRouteInfo<void> {
  const AlarmsChangeThemeRouter()
      : super(AlarmsChangeThemeRouter.name, path: 'alarms_change_theme');

  static const String name = 'AlarmsChangeThemeRouter';
}

/// generated route for
/// [i14.AlarmsEdit]
class AlarmsEditRouter extends i2.PageRouteInfo<AlarmsEditRouterArgs> {
  AlarmsEditRouter({i31.Key? key, required double alarmID})
      : super(AlarmsEditRouter.name,
            path: 'alarms_edit',
            args: AlarmsEditRouterArgs(key: key, alarmID: alarmID));

  static const String name = 'AlarmsEditRouter';
}

class AlarmsEditRouterArgs {
  const AlarmsEditRouterArgs({this.key, required this.alarmID});

  final i31.Key? key;

  final double alarmID;

  @override
  String toString() {
    return 'AlarmsEditRouterArgs{key: $key, alarmID: $alarmID}';
  }
}

/// generated route for
/// [i15.SocialScreen]
class SocialScreenRouter extends i2.PageRouteInfo<void> {
  const SocialScreenRouter()
      : super(SocialScreenRouter.name, path: 'social_screen');

  static const String name = 'SocialScreenRouter';
}

/// generated route for
/// [i16.SocialMyPosts]
class SocialMyPostsRouter extends i2.PageRouteInfo<void> {
  const SocialMyPostsRouter()
      : super(SocialMyPostsRouter.name, path: 'social_my_posts');

  static const String name = 'SocialMyPostsRouter';
}

/// generated route for
/// [i17.SocialAddPost]
class SocialAddPostRouter extends i2.PageRouteInfo<void> {
  const SocialAddPostRouter()
      : super(SocialAddPostRouter.name, path: 'social_add_post');

  static const String name = 'SocialAddPostRouter';
}

/// generated route for
/// [i18.SocialEditPost]
class SocialEditPostRouter extends i2.PageRouteInfo<SocialEditPostRouterArgs> {
  SocialEditPostRouter({i31.Key? key, required int postID})
      : super(SocialEditPostRouter.name,
            path: 'social_edit_post',
            args: SocialEditPostRouterArgs(key: key, postID: postID));

  static const String name = 'SocialEditPostRouter';
}

class SocialEditPostRouterArgs {
  const SocialEditPostRouterArgs({this.key, required this.postID});

  final i31.Key? key;

  final int postID;

  @override
  String toString() {
    return 'SocialEditPostRouterArgs{key: $key, postID: $postID}';
  }
}

/// generated route for
/// [i19.SocialViewPost]
class SocialViewPostRouter extends i2.PageRouteInfo<SocialViewPostRouterArgs> {
  SocialViewPostRouter({i31.Key? key, required String postID})
      : super(SocialViewPostRouter.name,
            path: 'social_view_post',
            args: SocialViewPostRouterArgs(key: key, postID: postID));

  static const String name = 'SocialViewPostRouter';
}

class SocialViewPostRouterArgs {
  const SocialViewPostRouterArgs({this.key, required this.postID});

  final i31.Key? key;

  final String postID;

  @override
  String toString() {
    return 'SocialViewPostRouterArgs{key: $key, postID: $postID}';
  }
}

/// generated route for
/// [i20.SocialViewUser]
class SocialViewUserRouter extends i2.PageRouteInfo<SocialViewUserRouterArgs> {
  SocialViewUserRouter({i31.Key? key, required String userID})
      : super(SocialViewUserRouter.name,
            path: 'social_view_user',
            args: SocialViewUserRouterArgs(key: key, userID: userID));

  static const String name = 'SocialViewUserRouter';
}

class SocialViewUserRouterArgs {
  const SocialViewUserRouterArgs({this.key, required this.userID});

  final i31.Key? key;

  final String userID;

  @override
  String toString() {
    return 'SocialViewUserRouterArgs{key: $key, userID: $userID}';
  }
}

/// generated route for
/// [i21.SocialProfile]
class SocialProfileRouter extends i2.PageRouteInfo<void> {
  const SocialProfileRouter()
      : super(SocialProfileRouter.name, path: 'social_profile');

  static const String name = 'SocialProfileRouter';
}

/// generated route for
/// [i22.SocialEditProfile]
class SocialEditProfileRouter extends i2.PageRouteInfo<void> {
  const SocialEditProfileRouter()
      : super(SocialEditProfileRouter.name, path: 'social_edit_profile');

  static const String name = 'SocialEditProfileRouter';
}

/// generated route for
/// [i23.TrackerScreen]
class TrackerScreenRouter extends i2.PageRouteInfo<void> {
  const TrackerScreenRouter()
      : super(TrackerScreenRouter.name, path: 'tracker_screen');

  static const String name = 'TrackerScreenRouter';
}

/// generated route for
/// [i24.TrackerOverview]
class TrackerOverviewRouter extends i2.PageRouteInfo<void> {
  const TrackerOverviewRouter()
      : super(TrackerOverviewRouter.name, path: 'tracker_overview');

  static const String name = 'TrackerOverviewRouter';
}

/// generated route for
/// [i25.TrackerAdd]
class TrackerAddRouter extends i2.PageRouteInfo<void> {
  const TrackerAddRouter() : super(TrackerAddRouter.name, path: 'tracker_add');

  static const String name = 'TrackerAddRouter';
}

/// generated route for
/// [i26.TrackerChangeDate]
class TrackerChangeDateRouter extends i2.PageRouteInfo<void> {
  const TrackerChangeDateRouter()
      : super(TrackerChangeDateRouter.name, path: 'tracker_change_date');

  static const String name = 'TrackerChangeDateRouter';
}

/// generated route for
/// [i27.PlannerScreen]
class PlannerScreenRouter extends i2.PageRouteInfo<void> {
  const PlannerScreenRouter()
      : super(PlannerScreenRouter.name, path: 'planner_screen');

  static const String name = 'PlannerScreenRouter';
}

/// generated route for
/// [i28.PlannerWorkRythmn]
class PlannerWorkRythmnRouter extends i2.PageRouteInfo<void> {
  const PlannerWorkRythmnRouter()
      : super(PlannerWorkRythmnRouter.name, path: 'planner_work_rythmn');

  static const String name = 'PlannerWorkRythmnRouter';
}

/// generated route for
/// [i29.PlannerAdd]
class PlannerAddRouter extends i2.PageRouteInfo<void> {
  const PlannerAddRouter() : super(PlannerAddRouter.name, path: 'planner_add');

  static const String name = 'PlannerAddRouter';
}

/// generated route for
/// [i30.PlannerChangeDate]
class PlannerChangeDateRouter extends i2.PageRouteInfo<void> {
  const PlannerChangeDateRouter()
      : super(PlannerChangeDateRouter.name, path: 'planner_change_date');

  static const String name = 'PlannerChangeDateRouter';
}
