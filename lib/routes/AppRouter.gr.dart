// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../homescreen/homescreenpage.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.HomeScreenPage(key: args.key));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i2.RouteConfig(HomeScreenRoute.name, path: '/home')
      ];
}

/// generated route for [_i1.HomeScreenPage]
class HomeScreenRoute extends _i2.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({_i3.Key? key})
      : super(name, path: '/home', args: HomeScreenRouteArgs(key: key));

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i3.Key? key;
}
