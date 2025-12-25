part of 'app_pages.dart';

// DO NOT EDIT names manually, follow GetX pattern

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const MAIN = _Paths.MAIN;
  static const SEARCH_PRODUCT = _Paths.SEARCH_PRODUCT;
  static const CART = _Paths.CART;
  static const PROFILE = _Paths.PROFILE;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
  static const PRODUCT_DETAIL = _Paths.PRODUCT_DETAIL;
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const MAIN = '/main';
  static const SEARCH_PRODUCT = '/search-product';
  static const CART = '/cart';
  static const PROFILE = '/profile';
  static const EDIT_PROFILE = '/edit-profile';
  static const PRODUCT_DETAIL = '/product-detail';
}
