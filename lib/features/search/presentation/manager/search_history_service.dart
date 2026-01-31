import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage local search history using SharedPreferences.
class SearchHistoryService {
  static const String _historyKey = 'search_history';
  static const int _maxHistory = 5;

  /// Gets the list of recent search queries.
  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historyKey) ?? [];
  }

  /// Adds a new query to the history, maintaining the max limit and uniqueness.
  Future<void> addQuery(String query) async {
    if (query.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey) ?? [];

    // Remove if already exists to move it to the top
    history.remove(query);

    // Add to the beginning
    history.insert(0, query);

    // Limit to max history
    if (history.length > _maxHistory) {
      history.removeRange(_maxHistory, history.length);
    }

    await prefs.setStringList(_historyKey, history);
  }

  /// Clears the entire search history.
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
