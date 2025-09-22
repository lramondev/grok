import 'package:flutter/material.dart';

class AppLifecycleManager with WidgetsBindingObserver {
  static final AppLifecycleManager _instance = AppLifecycleManager._internal();
  factory AppLifecycleManager() => _instance;
  AppLifecycleManager._internal();

  final List<VoidCallback> _onResumedCallbacks = [];

  bool _isInitialized = false;

  void init() {
    if (!_isInitialized) {
      WidgetsBinding.instance.addObserver(this);
      _isInitialized = true;
    }
  }

  void dispose() {
    if (_isInitialized) {
      WidgetsBinding.instance.removeObserver(this);
      _isInitialized = false;
    }
  }

  void addResumedCallback(VoidCallback callback) {
    if (!_onResumedCallbacks.contains(callback)) {
      _onResumedCallbacks.add(callback);
    }
  }

  void removeResumedCallback(VoidCallback callback) {
    _onResumedCallbacks.remove(callback);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      for (var callback in _onResumedCallbacks) {
        callback();
      }
    }
  }
}