import 'package:flutter/material.dart';
import 'package:nearest_shops/core/base/model/add_product_view_arg.dart';
import 'package:nearest_shops/core/base/model/home_dashboard_navigation_arg.dart';
import 'package:nearest_shops/view/authentication/change_password/view/change_password_view.dart';
import 'package:nearest_shops/view/authentication/login/view/login_view.dart';
import 'package:nearest_shops/view/authentication/onboard/view/on_board_option_view.dart';
import 'package:nearest_shops/view/authentication/register/view/register_view.dart';
import 'package:nearest_shops/view/authentication/reset_password/view/reset_password_view.dart';
import 'package:nearest_shops/view/authentication/shop_owner_register/view/shop_owner_register_view.dart';
import 'package:nearest_shops/view/home/comment/view/product_comment_view.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';
import 'package:nearest_shops/view/home/product_detail/view/product_detail_view.dart';
import 'package:nearest_shops/view/home/user_change_location/view/user_change_location_view.dart';
import 'package:nearest_shops/view/home/user_profile/view/user_profile_view.dart';
import 'package:nearest_shops/view/shop_owner/add_product/view/add_product_view.dart';
import 'package:nearest_shops/view/shop_owner/profile/view/owner_profile_view.dart';

import '../../../view/authentication/onboard/view/onboard_view.dart';
import '../../../view/home/dashboard/view/home_dashboard_navigation_view.dart';
import '../../../view/product/exception/navigate_model_not_found.dart';
import '../model/product_detail_view_arg.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoardViewRoute:
        return MaterialPageRoute(builder: (_) => OnBoardView());
      case onBoardOptionViewRoute:
        return MaterialPageRoute(builder: (_) => OnBoardOptionView());
      case resetPasswordViewRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordView());
      case shopOwnerRegisterViewRoute:
        return MaterialPageRoute(builder: (_) => ShopOwnerRegisterView());
      case registerViewRoute:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case loginViewRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case productDetailViewRoute:
        if (settings.arguments is ProductDetailViewArguments) {
          return MaterialPageRoute(
              builder: (_) => ProductDetailView(
                    productDetailViewArguments: settings.arguments as ProductDetailViewArguments,
                  ));
        }
        throw NavigateException<ProductDetailViewArguments>(settings.arguments);

      case userProfileViewRoute:
        return MaterialPageRoute(builder: (_) => UserProfileView());
      case userChangeLocationViewRoute:
        return MaterialPageRoute(builder: (_) => UserChangeLocationView());
      case changePasswordViewRoute:
        return MaterialPageRoute(builder: (_) => ChangePasswordView());
      case ownerProfileViewRoute:
        return MaterialPageRoute(builder: (_) => OwnerProfileView());
      case addProductViewRoute:
        if (settings.arguments is AddProductViewArguments) {
          return MaterialPageRoute(
              builder: (_) => AddProductView(
                    addProductViewArguments: settings.arguments as AddProductViewArguments,
                  ));
        }
        throw NavigateException<AddProductViewArguments>(settings.arguments);

      case homeNavigationDashboardViewRoute:
        if (settings.arguments is HomeDashboardNavigationArg) {
          return MaterialPageRoute(
              builder: (_) => HomeDashboardNavigationView(
                    homeDashboardNavigationArg: settings.arguments as HomeDashboardNavigationArg,
                  ));
        }
        throw NavigateException<HomeDashboardNavigationArg>(settings.arguments);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Ters giden birşeyler oldu'),
            ),
          ),
        );
    }
  }
}

const String onBoardViewRoute = '/onBoardView';
const String onBoardOptionViewRoute = '/onBoardOptionView';
const String resetPasswordViewRoute = '/resetPasswordView';
const String shopOwnerRegisterViewRoute = '/shopOwnerRegisterView';
const String registerViewRoute = '/registerView';
const String loginViewRoute = '/loginView';
const String productDetailViewRoute = '/productDetailView';
const String userProfileViewRoute = '/userProfileView';
const String userChangeLocationViewRoute = '/userChangeLocationView';
const String productCommentViewRoute = '/productCommentView';
const String changePasswordViewRoute = '/changePasswordView';
const String ownerProfileViewRoute = '/ownerProfileView';
const String addProductViewRoute = '/addProductView';
const String homeNavigationDashboardViewRoute = '/homeNavigationDashboardView';
