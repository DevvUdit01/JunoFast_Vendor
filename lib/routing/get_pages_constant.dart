import 'package:get/get.dart';
import 'package:junofast_vendor/features/BookingPage/booking_binding.dart';
import 'package:junofast_vendor/features/BookingPage/booking_view.dart';
import '../features/DashBord/dash_board_binding.dart';
import '../features/DashBord/dash_board_pageview.dart';
import '../features/From_DetailsPage/form_binding.dart';
import '../features/From_DetailsPage/form_view.dart';
import '../features/HomePage/homepage_binding.dart';
import '../features/HomePage/homepage_view.dart';
import '../features/login/login_page_binding.dart';
import '../features/login/login_page_view.dart';
import '../features/phone_authpage/phone_auth_binding.dart';
import '../features/phone_authpage/phone_auth_view.dart';
import '../features/settingspage/setting_page_binding.dart';
import '../features/settingspage/setting_page_view.dart';
import '../features/signuppage/signup_binding.dart';
import '../features/signuppage/signup_view.dart';
import '../features/splashScreen/splashScreenView.dart';
import '../features/splashScreen/splash_binding.dart';
import 'routes_constant.dart';

List<GetPage> getPage = [
  GetPage( 
    name: RoutesConstant.loginpage,
     page: ()=> const LoginPageView(),
     binding: LoginPageBinding(),
     transition: Transition.rightToLeft,
     ),
     GetPage( 
    name: RoutesConstant.signuppage,
     page: ()=> const SignUpPageView(),
     binding: SignUpPageBinding(),
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
    name: RoutesConstant.formPage,
     page: ()=> const FormPageView(),
     binding: FormPageBinding(),
     transition: Transition.rightToLeft,
     ),

    GetPage( 
     name: RoutesConstant.bookingpage,
     page: ()=> BookingPageView(),
     binding: BookingPageBinding(),
     transition: Transition.rightToLeft,
    ),
];

