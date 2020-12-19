import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceState {
  final bool isLargeSearch;
  final bool isDarkMode;

  const PreferenceState({this.isLargeSearch, this.isDarkMode});
}

class PreferenceManager {
  final _currentPerfs = BehaviorSubject<PreferenceState>.seeded(
    PreferenceState(isLargeSearch: false, isDarkMode: true),
  );

  final _isLargeSearchPref = StreamController<bool>();
  final _isDarkModePref = StreamController<bool>();

  PreferenceManager() {
    _loadSharedPrefs();
    _isLargeSearchPref.stream.listen((prefValue) {
      // _saveNewPrefs(PreferenceState(isLargeSearch: prefValue));
      _saveSearchPref(PreferenceState(isLargeSearch: prefValue));
    });
    _isDarkModePref.stream.listen((prefValue) {
      // _saveNewPrefs(PreferenceState(isDarkMode: prefValue));
      _saveDarkPref(PreferenceState(isDarkMode: prefValue));
    });
  }

  Stream<PreferenceState> get currentPrefs => _currentPerfs.stream;
  Sink<bool> get isLargeSearchPref => _isLargeSearchPref.sink;
  Sink<bool> get isDarkModePref => _isDarkModePref.sink;

  void close() {
    _currentPerfs.close();
    _isLargeSearchPref.close();
    _isDarkModePref.close();
  }

  Future<void> _loadSharedPrefs() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final isLargeSearch = sharedPrefs.getBool('isLargeSearch') ?? false;
    final isDarkMode = sharedPrefs.getBool('isDarkMode') ?? true;
    _currentPerfs.add(PreferenceState(isLargeSearch: isLargeSearch, isDarkMode: isDarkMode));
  }

  //TODO : Refactor this to work with less duplicate code. Remove functions _saveSearchPref &  _saveDarkPref
  Future<void> _saveNewPrefs(PreferenceState preferenceState) async {
    final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool('isDarkMode', preferenceState.isDarkMode);
      sharedPrefs.setBool('isLargeSearch', preferenceState.isLargeSearch);
    _currentPerfs.add(preferenceState);
  }

  Future<void> _saveSearchPref(PreferenceState preferenceState) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final isDarkMode = sharedPrefs.getBool('isDarkMode') ?? true;
    sharedPrefs.setBool('isLargeSearch', preferenceState.isLargeSearch);
    _currentPerfs.add(PreferenceState(isLargeSearch: preferenceState.isLargeSearch, isDarkMode: isDarkMode));
  }

  Future<void> _saveDarkPref(PreferenceState preferenceState) async {
    print("Saving Dark Mode");
    final sharedPrefs = await SharedPreferences.getInstance();
    final isLargeSearch = sharedPrefs.getBool('isLargeSearch') ?? false;
    sharedPrefs.setBool('isDarkMode', preferenceState.isDarkMode);
    _currentPerfs.add(PreferenceState(isLargeSearch: isLargeSearch, isDarkMode: preferenceState.isDarkMode));
  }
}
