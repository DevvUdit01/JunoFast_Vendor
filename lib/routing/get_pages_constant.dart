import 'package:get/get.dart';
import 'package:junofast_vendor/features/BookingPage/bookingpage_binding.dart';
import 'package:junofast_vendor/features/BookingPage/bookingpage_view.dart';
import 'package:junofast_vendor/features/Help&SupportPage/help_support_binding.dart';
import 'package:junofast_vendor/features/Help&SupportPage/help_support_view.dart';
import 'package:junofast_vendor/features/Forget%20Password/forgotpasswordpage_binding.dart';
import 'package:junofast_vendor/features/Forget%20Password/forgotpasswordpage_view.dart';
import 'package:junofast_vendor/features/NotificationPage/notificationPage_view.dart';
import 'package:junofast_vendor/features/NotificationPage/notificationpage_binding.dart';
import 'package:junofast_vendor/features/ProfilePage/profilepage_binding.dart';
import 'package:junofast_vendor/features/ProfilePage/profilepage_view.dart';
import 'package:junofast_vendor/features/ReportBugPage/reportBug_binding.dart';
import 'package:junofast_vendor/features/ReportBugPage/reportBug_view.dart';
import 'package:junofast_vendor/features/ChangePassword.dart/changepassword_binding.dart';
import 'package:junofast_vendor/features/ChangePassword.dart/changepassword_view.dart';
import 'package:junofast_vendor/features/signuppage/signuppage_binding.dart';
import 'package:junofast_vendor/features/signuppage/signuppage_view.dart';
import '../features/DashBord/dash_board_binding.dart';
import '../features/DashBord/dash_board_pageview.dart';
import '../features/HomePage/homepage_binding.dart';
import '../features/HomePage/homepage_view.dart';
import '../features/emailverificationpage/emailVerificationpage_binding.dart';
import '../features/emailverificationpage/emailVerificationpage_view.dart';
import '../features/login/login_page_binding.dart';
import '../features/login/login_page_view.dart';
import '../features/phone_authpage/phone_auth_binding.dart';
import '../features/phone_authpage/phone_auth_view.dart';
import '../features/settingspage/setting_page_binding.dart';
import '../features/settingspage/setting_page_view.dart';
import '../features/formpage/formpage_binding.dart';
import '../features/formpage/formpage_view.dart';
import '../features/splashScreen/splashpageView.dart';
import '../features/splashScreen/splashpage_binding.dart';
import 'routes_constant.dart';

List<GetPage> getPage = [
  GetPage( 
    name: RoutesConstant.loginpage,
     page: ()=> const LoginPageView(),
     binding: LoginPageBinding(),
     transition: Transition.rightToLeft,
     ),
     GetPage( 
    name: RoutesConstant.formPage,
     page: ()=>  const FormPageView(),
     binding: FormPageBinding(),
     transition: Transition.rightToLeft,
     ),
       GetPage( 
    name: RoutesConstant.homepage,
     page: ()=> const HomePageView(),
     binding: HomePageBinding(),
     transition: Transition.rightToLeft,
     ),
       GetPage( 
    name: RoutesConstant.splashPage,
     page: ()=> const SplashScreenView(),
     binding: SplashScreenBinding(),
     transition: Transition.rightToLeft,
     ),
        GetPage( 
    name: RoutesConstant.phoneAuth,
     page: ()=> const PhoneAuthenticationView(),
     binding: PhoneAuthenticationBinding(),
     transition: Transition.rightToLeft,
     ),
        GetPage( 
    name: RoutesConstant.dashpage,
     page: ()=> const DashBoardView(),
     binding: DashBoardBinding(),
     transition: Transition.rightToLeft,
     ),
        GetPage( 
    name: RoutesConstant.setting,
     page: ()=> const SettingPageView(),
     binding: SettingPageBinding(),
     transition: Transition.rightToLeft,
     ),
   

    GetPage( 
     name: RoutesConstant.bookingpage,
     page: ()=>  BookingPageView(),
     binding: BookingPageBinding(),
     transition: Transition.rightToLeft,
    ),
    GetPage( 
     name: RoutesConstant.verifyEmailOTP,
     page: ()=>  const EmailVerificationPageView(),
     binding: EmailVerificationPageBinding(),
     transition: Transition.rightToLeft,
    ),
    GetPage( 
     name: RoutesConstant.forgotPassword,
     page: ()=>  const ForgotPasswprdPageView(),
     binding: ForgotPasswprdPageBinding(),
     transition: Transition.rightToLeft,
    ),

    GetPage( 
    name: RoutesConstant.signuppage,
     page: ()=>  const SignUpPageView(),
     binding: SignUpPageBinding(),
     transition: Transition.rightToLeft,
     ),
     
   
    GetPage( 
    name: RoutesConstant.changePassword,
     page: ()=>   ChangePasswordView(),
     binding: ChangePasswordBinding(),
     transition: Transition.rightToLeft,
     ),
     GetPage( 
    name: RoutesConstant.helpSupport,
     page: ()=>  const HelpSupportView(),
     binding: HelpSupportBinding(),
     transition: Transition.rightToLeft,
     ),
    GetPage( 
    name: RoutesConstant.notificationPage,
     page: ()=>  const NotificationPageView(),
     binding: NotificationPageBinding(),
     transition: Transition.rightToLeft,
     ),
      GetPage( 
    name: RoutesConstant.reportBugPage,
     page: ()=>  const ReportBugView(),
     binding: ReportBugBinding(),
     transition: Transition.rightToLeft,
     ),
    GetPage( 
    name: RoutesConstant.profilepage,
     page: ()=> const ProfilePageView(),
     binding: ProfilePageBinding(),
     transition: Transition.rightToLeft,
     ),
];

