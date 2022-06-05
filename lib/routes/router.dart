import 'package:auto_route/auto_route.dart';
import 'package:sertinary/screens/alarms_screens/alarms_add.dart';
import 'package:sertinary/screens/alarms_screens/alarms_calculator.dart';
import 'package:sertinary/screens/alarms_screens/alarms_change_theme.dart';
import 'package:sertinary/screens/alarms_screens/alarms_screen.dart';
import 'package:sertinary/screens/home_screen.dart';
import 'package:sertinary/screens/planner_screens/planner_add.dart';
import 'package:sertinary/screens/planner_screens/planner_change_date.dart';
import 'package:sertinary/screens/planner_screens/planner_screen.dart';
import 'package:sertinary/screens/planner_screens/planner_work_rythmn.dart';
import 'package:sertinary/screens/social_screens/social_add.dart';
import 'package:sertinary/screens/social_screens/social_profile.dart';
import 'package:sertinary/screens/social_screens/social_saved.dart';
import 'package:sertinary/screens/social_screens/social_screen.dart';
import 'package:sertinary/screens/tracker_screens/tracker_add.dart';
import 'package:sertinary/screens/tracker_screens/tracker_change_date.dart';
import 'package:sertinary/screens/tracker_screens/tracker_overview.dart';
import 'package:sertinary/screens/tracker_screens/tracker_screen.dart';
import 'package:sertinary/screens/welcome_screens/welcome_screen.dart';
import 'package:sertinary/user_authentication/forgot_password/forgot_password_screen.dart';
import 'package:sertinary/user_authentication/login/login_screen.dart';
import 'package:sertinary/user_authentication/registration/register_email_screen.dart';
import 'package:sertinary/user_authentication/registration/register_password_screen.dart';
import 'package:sertinary/user_authentication/registration/register_username_screen.dart';
import 'package:sertinary/user_authentication/registration/register_verify_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    //Login
    AutoRoute(
      path: 'login',
      name: 'LoginRoute',
      page: LoginScreen,
      initial: true,
    ),
    //Register
    AutoRoute(
      path: 'register',
      name: 'RegisterRoute',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: 'register_username',
          name: 'RegisterUsernameRoute',
          page: RegisterUsernameScreen,
          initial: true,
        ),
        AutoRoute(
          path: 'register_email',
          name: 'RegisterEmailRoute',
          page: RegisterEmailScreen,
        ),
        AutoRoute(
          path: 'register_password',
          name: 'RegisterPasswordRoute',
          page: RegisterPasswordScreen,
        ),
        AutoRoute(
          path: 'register_verify',
          name: 'RegisterVerifyRoute',
          page: RegisterVerifyScreen,
        ),
      ],
    ),
    //Reset Password
    AutoRoute(
      path: 'forgot_password',
      name: 'ForgotPasswordRoute',
      page: ForgotPasswordScreen,
    ),
    //Home
    AutoRoute(
      path: 'home',
      name: 'HomeRoute',
      page: HomeScreen,
      children: [
        //Welcome
        AutoRoute(
          path: 'welcome',
          name: 'WelcomeRouter',
          page: WelcomeScreen,
        ),
        //Alarms
        AutoRoute(
          path: 'alarms',
          name: 'AlarmsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: 'alarms_screen',
              name: 'AlarmsScreenRouter',
              page: AlarmsScreen,
              initial: true,
            ),
            AutoRoute(
              path: 'alarms_calculator',
              name: 'AlarmsCalculatorRouter',
              page: AlarmsCalculator,
            ),
            AutoRoute(
              path: 'alarms_add',
              name: 'AlarmsAddRouter',
              page: AlarmsAdd,
            ),
            AutoRoute(
              path: 'alarms_change_theme',
              name: 'AlarmsChangeThemeRouter',
              page: AlarmsChangeTheme,
            ),
          ],
        ),
        //Social
        AutoRoute(
          path: 'social',
          name: 'SocialRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: 'social_screen',
              name: 'SocialScreenRouter',
              page: SocialScreen,
              initial: true,
            ),
            AutoRoute(
              path: 'social_saved',
              name: 'SocialSavedRouter',
              page: SocialSaved,
            ),
            AutoRoute(
              path: 'social_add',
              name: 'SocialAddRouter',
              page: SocialAdd,
            ),
            AutoRoute(
              path: 'social_profile',
              name: 'SocialProfileRouter',
              page: SocialProfile,
            ),
          ],
        ),
        //Tracker
        AutoRoute(
          path: 'tracker',
          name: 'TrackerRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: 'tracker_screen',
              name: 'TrackerScreenRouter',
              page: TrackerScreen,
              initial: true,
            ),
            AutoRoute(
              path: 'tracker_overview',
              name: 'TrackerOverviewRouter',
              page: TrackerOverview,
            ),
            AutoRoute(
              path: 'tracker_add',
              name: 'TrackerAddRouter',
              page: TrackerAdd,
            ),
            AutoRoute(
              path: 'tracker_change_date',
              name: 'TrackerChangeDateRouter',
              page: TrackerChangeDate,
            ),
          ],
        ),
        //Planner
        AutoRoute(
          path: 'planner',
          name: 'PlannerRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: 'planner_screen',
              name: 'PlannerScreenRouter',
              page: PlannerScreen,
              initial: true,
            ),
            AutoRoute(
              path: 'planner_work_rythmn',
              name: 'PlannerWorkRythmnRouter',
              page: PlannerWorkRythmn,
            ),
            AutoRoute(
              path: 'planner_add',
              name: 'PlannerAddRouter',
              page: PlannerAdd,
            ),
            AutoRoute(
              path: 'planner_change_date',
              name: 'PlannerChangeDateRouter',
              page: PlannerChangeDate,
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
