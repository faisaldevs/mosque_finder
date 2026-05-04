// paginated_vm.dart
import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';

abstract class PaginatedBaseViewModel<T> extends ChangeNotifier {
  /// --- Common States ---
  bool _isInitialLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  List<T> _data = [];
  
  /// Pagination states
  int _currentPage = 1;
  bool _hasMore = true;
  int _totalItems = 0;
  
  /// Stream for reactive updates
  final BehaviorSubject<List<T>> _subject;

  PaginatedBaseViewModel()
      : _subject = BehaviorSubject<List<T>>.seeded([]);

  /// --- Getters ---
  bool get isLoading => _isInitialLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  List<T> get data => _data;
  Stream<List<T>> get stream => _subject.stream;
  
  /// Pagination getters
  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  int get totalItems => _totalItems;
  int get itemCount => _data.length;
  bool get hasError => _errorMessage != null;
  bool get isEmpty => _data.isEmpty && !_isInitialLoading;
  bool get isInitialLoading => _isInitialLoading && _data.isEmpty;
  bool get isLoadingAny => _isInitialLoading || _isLoadingMore;

  /// --- Core Methods ---
  
  /// Load initial data (first page)
  Future<void> fetchInitialData(Future<PaginatedResult<T>> Function() fetcher) async {
    _setInitialLoading(true);
    _setError(null);
    _currentPage = 1;
    _hasMore = true;

    try {
      final result = await fetcher();
      _data = result.items;
      _totalItems = result.total;
      _hasMore = result.hasMore;
      _currentPage = result.currentPage;
      _subject.add(_data);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setInitialLoading(false);
    }
  }

  /// Load more data (next page)
  Future<void> fetchMoreData(Future<PaginatedResult<T>> Function() fetcher) async {
    if (!_hasMore || _isLoadingMore || _isInitialLoading) return;

    _setLoadingMore(true);
    _setError(null);

    try {
      final result = await fetcher();
      _data = [..._data, ...result.items];
      _totalItems = result.total;
      _hasMore = result.hasMore;
      _currentPage = result.currentPage;
      _subject.add(_data);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoadingMore(false);
    }
  }

  /// Refresh data (reload first page)
  Future<void> refresh([Future<PaginatedResult<T>> Function()? fetcher]) async {
    if (fetcher != null) {
      return fetchInitialData(fetcher);
    } else {
      // If no fetcher provided, just reset to first page
      _currentPage = 1;
      _hasMore = true;
      notifyListeners();
    }
  }

  /// Clear all data
  void clearData() {
    _data = [];
    _currentPage = 1;
    _hasMore = true;
    _totalItems = 0;
    _subject.add(_data);
    notifyListeners();
  }

  /// --- State Setters ---
  void _setInitialLoading(bool value) {
    _isInitialLoading = value;
    notifyListeners();
  }

  void _setLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  /// Update data manually (for caching, etc.)
  void updateData(List<T> newData) {
    _data = newData;
    _subject.add(_data);
    notifyListeners();
  }

  @override
  void dispose() {
    _subject.close();
    super.dispose();
  }
}

/// Result model for paginated responses
class PaginatedResult<T> {
  final List<T> items;
  final int currentPage;
  final int total;
  final bool hasMore;

  PaginatedResult({
    required this.items,
    required this.currentPage,
    required this.total,
    required this.hasMore,
  });
}