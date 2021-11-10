// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../homescreen/homescreenpage.dart' as _i2;
import '../register/familydetailsscreenpage.dart' as _i3;
import '../register/familyregistrationscreenpage.dart' as _i4;
import '../splashscreen/splashscreenpage.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    HomeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.HomeScreenPage(key: args.key));
    },
    FamilyDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyDetailsScreenRouteArgs>(
          orElse: () => const FamilyDetailsScreenRouteArgs());
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.FamilyDetailsScreenPage(key: args.key));
    },
    FamilyRegistrationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyRegistrationScreenRouteArgs>(
          orElse: () => const FamilyRegistrationScreenRouteArgs());
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.FamilyRegistrationScreenPage(key: args.key));
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i5.RouteConfig(SplashScreenRoute.name, path: '/splash', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: SplashScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(HomeScreenRoute.name, path: '/home', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: HomeScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(FamilyDetailsScreenRoute.name,
            path: '/familydetails',
            children: [
              _i5.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyDetailsScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        _i5.RouteConfig(FamilyRegistrationScreenRoute.name,
            path: '/familyregistration',
            children: [
              _i5.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyRegistrationScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ])
      ];
}

/// generated route for [_i1.SplashScreenPage]
class SplashScreenRoute extends _i5.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i5.PageRouteInfo>? children})
      : super(name, path: '/splash', initialChildren: children);

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.HomeScreenPage]
class HomeScreenRoute extends _i5.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({_i6.Key? key, List<_i5.PageRouteInfo>? children})
      : super(name,
            path: '/home',
            args: HomeScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i6.Key? key;
}

/// generated route for [_i3.FamilyDetailsScreenPage]
class FamilyDetailsScreenRoute
    extends _i5.PageRouteInfo<FamilyDetailsScreenRouteArgs> {
  FamilyDetailsScreenRoute({_i6.Key? key, List<_i5.PageRouteInfo>? children})
      : super(name,
            path: '/familydetails',
            args: FamilyDetailsScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyDetailsScreenRoute';
}

class FamilyDetailsScreenRouteArgs {
  const FamilyDetailsScreenRouteArgs({this.key});

  final _i6.Key? key;
}

/// generated route for [_i4.FamilyRegistrationScreenPage]
class FamilyRegistrationScreenRoute
    extends _i5.PageRouteInfo<FamilyRegistrationScreenRouteArgs> {
  FamilyRegistrationScreenRoute(
      {_i6.Key? key, List<_i5.PageRouteInfo>? children})
      : super(name,
            path: '/familyregistration',
            args: FamilyRegistrationScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyRegistrationScreenRoute';
}

class FamilyRegistrationScreenRouteArgs {
  const FamilyRegistrationScreenRouteArgs({this.key});

  final _i6.Key? key;
}
