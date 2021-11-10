// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../checkout/checkoutscreenpage.dart' as _i5;
import '../homescreen/homescreenpage.dart' as _i2;
import '../register/familydetailsscreenpage.dart' as _i3;
import '../register/familyregistrationscreenpage.dart' as _i4;
import '../splashscreen/splashscreenpage.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    HomeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.HomeScreenPage(key: args.key));
    },
    FamilyDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyDetailsScreenRouteArgs>(
          orElse: () => const FamilyDetailsScreenRouteArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.FamilyDetailsScreenPage(key: args.key));
    },
    FamilyRegistrationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyRegistrationScreenRouteArgs>(
          orElse: () => const FamilyRegistrationScreenRouteArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.FamilyRegistrationScreenPage(key: args.key));
    },
    CheckOutScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.CheckOutScreenPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i6.RouteConfig(SplashScreenRoute.name, path: '/splash', children: [
          _i6.RouteConfig('*#redirect',
              path: '*',
              parent: SplashScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i6.RouteConfig(HomeScreenRoute.name, path: '/home', children: [
          _i6.RouteConfig('*#redirect',
              path: '*',
              parent: HomeScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i6.RouteConfig(FamilyDetailsScreenRoute.name,
            path: '/familydetails',
            children: [
              _i6.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyDetailsScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i6.RouteConfig(FamilyRegistrationScreenRoute.name,
            path: '/familyregistration',
            children: [
              _i6.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyRegistrationScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i6.RouteConfig(CheckOutScreenRoute.name, path: '/checkout', children: [
          _i6.RouteConfig('*#redirect',
              path: '*',
              parent: CheckOutScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ])
      ];
}

/// generated route for [_i1.SplashScreenPage]
class SplashScreenRoute extends _i6.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i6.PageRouteInfo>? children})
      : super(name, path: '/splash', initialChildren: children);

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.HomeScreenPage]
class HomeScreenRoute extends _i6.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({_i7.Key? key, List<_i6.PageRouteInfo>? children})
      : super(name,
            path: '/home',
            args: HomeScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i7.Key? key;
}

/// generated route for [_i3.FamilyDetailsScreenPage]
class FamilyDetailsScreenRoute
    extends _i6.PageRouteInfo<FamilyDetailsScreenRouteArgs> {
  FamilyDetailsScreenRoute({_i7.Key? key, List<_i6.PageRouteInfo>? children})
      : super(name,
            path: '/familydetails',
            args: FamilyDetailsScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyDetailsScreenRoute';
}

class FamilyDetailsScreenRouteArgs {
  const FamilyDetailsScreenRouteArgs({this.key});

  final _i7.Key? key;
}

/// generated route for [_i4.FamilyRegistrationScreenPage]
class FamilyRegistrationScreenRoute
    extends _i6.PageRouteInfo<FamilyRegistrationScreenRouteArgs> {
  FamilyRegistrationScreenRoute(
      {_i7.Key? key, List<_i6.PageRouteInfo>? children})
      : super(name,
            path: '/familyregistration',
            args: FamilyRegistrationScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyRegistrationScreenRoute';
}

class FamilyRegistrationScreenRouteArgs {
  const FamilyRegistrationScreenRouteArgs({this.key});

  final _i7.Key? key;
}

/// generated route for [_i5.CheckOutScreenPage]
class CheckOutScreenRoute extends _i6.PageRouteInfo<void> {
  const CheckOutScreenRoute({List<_i6.PageRouteInfo>? children})
      : super(name, path: '/checkout', initialChildren: children);

  static const String name = 'CheckOutScreenRoute';
}
