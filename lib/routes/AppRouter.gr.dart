// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../checkout/checkoutscreenpage.dart' as _i5;
import '../homescreen/homescreenpage.dart' as _i2;
import '../register/familydetailsscreenpage.dart' as _i3;
import '../register/familylistingscreenpage.dart' as _i6;
import '../register/familyregistrationscreenpage.dart' as _i4;
import '../splashscreen/splashscreenpage.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    HomeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.HomeScreenPage(key: args.key));
    },
    FamilyDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyDetailsScreenRouteArgs>(
          orElse: () => const FamilyDetailsScreenRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.FamilyDetailsScreenPage(key: args.key));
    },
    FamilyRegistrationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyRegistrationScreenRouteArgs>(
          orElse: () => const FamilyRegistrationScreenRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.FamilyRegistrationScreenPage(key: args.key));
    },
    CheckOutScreenRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.CheckOutScreenPage());
    },
    FamilyListingScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyListingScreenRouteArgs>(
          orElse: () => const FamilyListingScreenRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.FamilyListingScreenPage(key: args.key));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i7.RouteConfig(SplashScreenRoute.name, path: '/splash', children: [
          _i7.RouteConfig('*#redirect',
              path: '*',
              parent: SplashScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i7.RouteConfig(HomeScreenRoute.name, path: '/home', children: [
          _i7.RouteConfig('*#redirect',
              path: '*',
              parent: HomeScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i7.RouteConfig(FamilyDetailsScreenRoute.name,
            path: '/familydetails',
            children: [
              _i7.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyDetailsScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i7.RouteConfig(FamilyRegistrationScreenRoute.name,
            path: '/familyregistration',
            children: [
              _i7.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyRegistrationScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i7.RouteConfig(CheckOutScreenRoute.name, path: '/checkout', children: [
          _i7.RouteConfig('*#redirect',
              path: '*',
              parent: CheckOutScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i7.RouteConfig(FamilyListingScreenRoute.name,
            path: '/familylisting',
            children: [
              _i7.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyListingScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ])
      ];
}

/// generated route for [_i1.SplashScreenPage]
class SplashScreenRoute extends _i7.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(name, path: '/splash', initialChildren: children);

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.HomeScreenPage]
class HomeScreenRoute extends _i7.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({_i8.Key? key, List<_i7.PageRouteInfo>? children})
      : super(name,
            path: '/home',
            args: HomeScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'HomeScreenRouteArgs{key: $key}';
  }
}

/// generated route for [_i3.FamilyDetailsScreenPage]
class FamilyDetailsScreenRoute
    extends _i7.PageRouteInfo<FamilyDetailsScreenRouteArgs> {
  FamilyDetailsScreenRoute({_i8.Key? key, List<_i7.PageRouteInfo>? children})
      : super(name,
            path: '/familydetails',
            args: FamilyDetailsScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyDetailsScreenRoute';
}

class FamilyDetailsScreenRouteArgs {
  const FamilyDetailsScreenRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'FamilyDetailsScreenRouteArgs{key: $key}';
  }
}

/// generated route for [_i4.FamilyRegistrationScreenPage]
class FamilyRegistrationScreenRoute
    extends _i7.PageRouteInfo<FamilyRegistrationScreenRouteArgs> {
  FamilyRegistrationScreenRoute(
      {_i8.Key? key, List<_i7.PageRouteInfo>? children})
      : super(name,
            path: '/familyregistration',
            args: FamilyRegistrationScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyRegistrationScreenRoute';
}

class FamilyRegistrationScreenRouteArgs {
  const FamilyRegistrationScreenRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'FamilyRegistrationScreenRouteArgs{key: $key}';
  }
}

/// generated route for [_i5.CheckOutScreenPage]
class CheckOutScreenRoute extends _i7.PageRouteInfo<void> {
  const CheckOutScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(name, path: '/checkout', initialChildren: children);

  static const String name = 'CheckOutScreenRoute';
}

/// generated route for [_i6.FamilyListingScreenPage]
class FamilyListingScreenRoute
    extends _i7.PageRouteInfo<FamilyListingScreenRouteArgs> {
  FamilyListingScreenRoute({_i8.Key? key, List<_i7.PageRouteInfo>? children})
      : super(name,
            path: '/familylisting',
            args: FamilyListingScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyListingScreenRoute';
}

class FamilyListingScreenRouteArgs {
  const FamilyListingScreenRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'FamilyListingScreenRouteArgs{key: $key}';
  }
}
