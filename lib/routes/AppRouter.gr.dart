// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../homescreen/homescreenpage.dart' as _i2;
import '../register/familydetailsscreenpage.dart' as _i3;
import '../splashscreen/splashscreenpage.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    HomeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.HomeScreenPage(key: args.key));
    },
    FamilyDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FamilyDetailsScreenRouteArgs>(
          orElse: () => const FamilyDetailsScreenRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.FamilyDetailsScreenPage(key: args.key));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i4.RouteConfig(SplashScreenRoute.name, path: '/splash', children: [
          _i4.RouteConfig('*#redirect',
              path: '*',
              parent: SplashScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i4.RouteConfig(HomeScreenRoute.name, path: '/home', children: [
          _i4.RouteConfig('*#redirect',
              path: '*',
              parent: HomeScreenRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i4.RouteConfig(FamilyDetailsScreenRoute.name,
            path: '/familydetails',
            children: [
              _i4.RouteConfig('*#redirect',
                  path: '*',
                  parent: FamilyDetailsScreenRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ])
      ];
}

/// generated route for [_i1.SplashScreenPage]
class SplashScreenRoute extends _i4.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(name, path: '/splash', initialChildren: children);

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.HomeScreenPage]
class HomeScreenRoute extends _i4.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({_i5.Key? key, List<_i4.PageRouteInfo>? children})
      : super(name,
            path: '/home',
            args: HomeScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i5.Key? key;
}

/// generated route for [_i3.FamilyDetailsScreenPage]
class FamilyDetailsScreenRoute
    extends _i4.PageRouteInfo<FamilyDetailsScreenRouteArgs> {
  FamilyDetailsScreenRoute({_i5.Key? key, List<_i4.PageRouteInfo>? children})
      : super(name,
            path: '/familydetails',
            args: FamilyDetailsScreenRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'FamilyDetailsScreenRoute';
}

class FamilyDetailsScreenRouteArgs {
  const FamilyDetailsScreenRouteArgs({this.key});

  final _i5.Key? key;
}
