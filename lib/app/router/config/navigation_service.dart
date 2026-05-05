import 'package:go_router/go_router.dart';

class NavigationService {
  late GoRouter _router;

  void setRouter(GoRouter router) => _router = router;
  GoRouter get router => _router;

  // Basic
  void push(String path) => _router.push(path);
  void go(String path) => _router.go(path);
  void pop<T extends Object?>([T? result]) => _router.pop(result);
  void refresh() => _router.refresh();

  // Go with extra
  void goWithExtra(String path, {Object? extra}) =>
      _router.go(path, extra: extra);

  // Named Routes
  void pushNamed(
    String name, {
    Map<String, String> params = const {},
    Map<String, String> queryParams = const {},
  }) {
    push(_router.namedLocation(
      name,
      pathParameters: params,
      queryParameters: queryParams,
    ));
  }

  void goNamed(
    String name, {
    Map<String, String> params = const {},
    Map<String, String> queryParams = const {},
  }) {
    go(_router.namedLocation(
      name,
      pathParameters: params,
      queryParameters: queryParams,
    ));
  }

  void pushNamedWithExtra(
    String name, {
    Map<String, String> params = const {},
    Map<String, String> queryParams = const {},
    Object? extra,
  }) {
    _router.pushNamed(
      name,
      pathParameters: params,
      queryParameters: queryParams,
      extra: extra,
    );
  }

  void goNamedWithExtra(
    String name, {
    Map<String, String> params = const {},
    Map<String, String> queryParams = const {},
    Object? extra,
  }) {
    _router.goNamed(
      name,
      pathParameters: params,
      queryParameters: queryParams,
      extra: extra,
    );
  }

  // Replace
  void replace(String path) => _router.replace(path);

  void replaceNamed(
    String name, {
    Map<String, String> params = const {},
    Map<String, String> queryParams = const {},
    Object? extra,
  }) {
    _router.replaceNamed(
      name,
      pathParameters: params,
      queryParameters: queryParams,
      extra: extra,
    );
  }

  // History
  bool canPop() => _router.canPop();

  void popUntilHome() {
    while (_router.canPop()) {
      _router.pop();
    }
  }


}

// class NavigationService {
//   late GoRouter _router;

//   void setRouter(GoRouter router) => _router = router;

//   // Basic navigation
//   void push(String path) => _router.push(path);
//   void go(String path) => _router.go(path);
//   void pop<T extends Object?>([T? result]) => _router.pop(result);
//   bool canPop() => _router.canPop();

//   // Named routes
//   void pushNamed(String name,
//           {Map<String, String> params = const {}, Object? extra}) =>
//       _router.pushNamed(name, pathParameters: params, extra: extra);

//   void goNamed(String name,
//           {Map<String, String> params = const {}, Object? extra}) =>
//       _router.goNamed(name, pathParameters: params, extra: extra);

//   // Replace routes
//   void replace(String path) => _router.replace(path);

//   void replaceNamed(String name,
//           {Map<String, String> params = const {}, Object? extra}) =>
//       _router.replaceNamed(name, pathParameters: params, extra: extra);

//   // Pop until root
//   void popUntilHome() {
//     while (_router.canPop()) {
//       _router.pop();
//     }
//   }
// }
