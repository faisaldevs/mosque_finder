import 'package:flutter/foundation.dart';

abstract class BaseViewModel<T> extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  T? _data;

  bool get isLoading => _isLoading;
  String? get error => _error;
  T? get data => _data;

  Future<void> execute(Future<T> Function() task) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await task();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setData(T value) {
    _data = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}