import 'dart:developer';
import 'package:rxdart/rxdart.dart';

/// Base Response with RxDart for reactive UI updates.
/// Works for both single-shot and list-based APIs.
abstract class RxResponseInt<T> {
  final T empty;
  final BehaviorSubject<T> dataFetcher;
  final Map? map;
  final BehaviorSubject? dataFetcher2;

  RxResponseInt({
    required this.empty,
    BehaviorSubject<T>? dataFetcher,
    this.map,
    this.dataFetcher2,
  }) : dataFetcher = dataFetcher ?? BehaviorSubject.seeded(empty);

  /// Current value
  T get current => dataFetcher.value;

  /// Push success data into stream
  dynamic handleSuccessWithReturn(T data) {
    dataFetcher.add(data);
    return data;
  }

  /// Push error into stream
  dynamic handleErrorWithReturn(dynamic error) {
    log(error.toString());
    dataFetcher.addError(error);
    throw error;
  }

  /// Reset stream to empty state
  void clean() {
    dataFetcher.add(empty);
  }

  /// Close all streams
  void dispose() {
    dataFetcher.close();
    dataFetcher2?.close();
  }
}

/// Enum for representing pagination states
enum PaginationState { initial, loading, success, error }

/// Advanced paginated Rx class
abstract class PaginatedRx<T> extends RxResponseInt<List<T>> {
  int page = 1;
  bool hasMore = true;
  final int pageSize;

  final BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  final BehaviorSubject<String?> _error = BehaviorSubject.seeded(null);
  final BehaviorSubject<PaginationState> _state =
      BehaviorSubject.seeded(PaginationState.initial);

  PaginatedRx({this.pageSize = 20})
      : super(
          empty: [],
          dataFetcher: BehaviorSubject.seeded([]),
        );

  /// Exposed streams
  Stream<List<T>> get itemsStream => dataFetcher.stream;
  Stream<bool> get loadingStream => _isLoading.stream;
  Stream<String?> get errorStream => _error.stream;
  Stream<PaginationState> get stateStream => _state.stream;

  bool get isLoading => _isLoading.value;
  String? get error => _error.value;
  PaginationState get state => _state.value;
  List<T> get items => current;

  /// Must be implemented by child class
  Future<List<T>> loadPage(int page, int pageSize);

  /// Fetch first page and reset state
  Future<void> fetchInitial() async {
    page = 1;
    hasMore = true;
    _error.add(null);
    _isLoading.add(true);
    _state.add(PaginationState.loading);

    try {
      final result = await loadPage(page, pageSize);
      handleSuccessWithReturn(result);
      hasMore = result.length == pageSize;
      _state.add(PaginationState.success);
    } catch (e) {
      log('Pagination fetchInitial error: $e');
      _error.add(e.toString());
      _state.add(PaginationState.error);
      handleErrorWithReturn(e);
    } finally {
      _isLoading.add(false);
    }
  }

  /// Fetch next page
  Future<void> fetchMore() async {
    if (!hasMore || isLoading) return;

    page++;
    _isLoading.add(true);
    _error.add(null);

    try {
      final result = await loadPage(page, pageSize);
      final combined = [...items, ...result];
      handleSuccessWithReturn(combined);
      hasMore = result.length == pageSize;
      _state.add(PaginationState.success);
    } catch (e) {
      log('Pagination fetchMore error: $e');
      _error.add(e.toString());
      _state.add(PaginationState.error);
      page--; // rollback page
      handleErrorWithReturn(e);
    } finally {
      _isLoading.add(false);
    }
  }

  /// Refresh (reload first page)
  Future<void> refresh() async => fetchInitial();

  /// Cleanup
  @override
  void dispose() {
    _isLoading.close();
    _error.close();
    _state.close();
    super.dispose();
  }
}
