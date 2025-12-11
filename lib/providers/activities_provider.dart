import 'dart:convert';
import 'package:flutter/foundation.dart' hide Category;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity.dart';
import '../models/location.dart';
import '../data/sample_activities.dart';

enum SortOption {
  alphabetical,
  priceAsc,
  priceDesc,
  mostViewed,
  newest,
}

class ActivitiesProvider with ChangeNotifier {
  List<Activity> _allActivities = [];
  List<Activity> _filteredActivities = [];
  String _searchQuery = '';
  UserLocation? _userLocation;
  bool _isLocationSet = false;
  
  // Filters
  Set<Category> _selectedCategories = {};
  Set<AgeGroup> _selectedAgeGroups = {};
  Set<Season> _selectedSeasons = {};
  List<String> _selectedLocations = [];
  bool? _isDiverseFilter;
  bool? _isFreeFilter;
  double? _minPrice;
  double? _maxPrice;
  
  SortOption _sortOption = SortOption.newest;

  ActivitiesProvider() {
    _loadUserLocation();
  }

  // Getters
  List<Activity> get allActivities => _allActivities;
  List<Activity> get filteredActivities => _filteredActivities;
  String get searchQuery => _searchQuery;
  UserLocation? get userLocation => _userLocation;
  bool get isLocationSet => _isLocationSet;
  Set<Category> get selectedCategories => _selectedCategories;
  Set<AgeGroup> get selectedAgeGroups => _selectedAgeGroups;
  Set<Season> get selectedSeasons => _selectedSeasons;
  List<String> get selectedLocations => _selectedLocations;
  bool? get isDiverseFilter => _isDiverseFilter;
  bool? get isFreeFilter => _isFreeFilter;
  double? get minPrice => _minPrice;
  double? get maxPrice => _maxPrice;
  SortOption get sortOption => _sortOption;

  // Get unique locations from all activities
  List<String> get availableLocations {
    return _allActivities.map((a) => a.location).toSet().toList()..sort();
  }

  Future<void> _loadUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final locationJson = prefs.getString('user_location');
    
    if (locationJson != null) {
      try {
        final locationMap = jsonDecode(locationJson) as Map<String, dynamic>;
        _userLocation = UserLocation.fromJson(locationMap);
        _isLocationSet = true;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error loading user location: $e');
        }
      }
    }
    
    _loadActivities();
    notifyListeners();
  }

  void _loadActivities() {
    _allActivities = List.from(sampleActivities);
    _applyFiltersAndSort();
  }

  Future<void> setUserLocation(UserLocation location) async {
    _userLocation = location;
    _isLocationSet = true;
    
    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_location', jsonEncode(location.toJson()));
    
    // Reload activities for the new location
    _loadActivities();
    notifyListeners();
  }

  Future<void> clearUserLocation() async {
    _userLocation = null;
    _isLocationSet = false;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_location');
    
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFiltersAndSort();
  }

  void toggleCategory(Category category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _applyFiltersAndSort();
  }

  void toggleAgeGroup(AgeGroup ageGroup) {
    if (_selectedAgeGroups.contains(ageGroup)) {
      _selectedAgeGroups.remove(ageGroup);
    } else {
      _selectedAgeGroups.add(ageGroup);
    }
    _applyFiltersAndSort();
  }

  void toggleSeason(Season season) {
    if (_selectedSeasons.contains(season)) {
      _selectedSeasons.remove(season);
    } else {
      _selectedSeasons.add(season);
    }
    _applyFiltersAndSort();
  }

  void toggleLocation(String location) {
    if (_selectedLocations.contains(location)) {
      _selectedLocations.remove(location);
    } else {
      _selectedLocations.add(location);
    }
    _applyFiltersAndSort();
  }

  void setDiverseFilter(bool? value) {
    _isDiverseFilter = value;
    _applyFiltersAndSort();
  }

  void setFreeFilter(bool? value) {
    _isFreeFilter = value;
    _applyFiltersAndSort();
  }

  void setPriceRange(double? min, double? max) {
    _minPrice = min;
    _maxPrice = max;
    _applyFiltersAndSort();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    _applyFiltersAndSort();
  }

  void clearAllFilters() {
    _searchQuery = '';
    _selectedCategories.clear();
    _selectedAgeGroups.clear();
    _selectedSeasons.clear();
    _selectedLocations.clear();
    _isDiverseFilter = null;
    _isFreeFilter = null;
    _minPrice = null;
    _maxPrice = null;
    _sortOption = SortOption.newest;
    _applyFiltersAndSort();
  }

  bool get hasActiveFilters {
    return _searchQuery.isNotEmpty ||
        _selectedCategories.isNotEmpty ||
        _selectedAgeGroups.isNotEmpty ||
        _selectedSeasons.isNotEmpty ||
        _selectedLocations.isNotEmpty ||
        _isDiverseFilter != null ||
        _isFreeFilter != null ||
        _minPrice != null ||
        _maxPrice != null;
  }

  void _applyFiltersAndSort() {
    _filteredActivities = _allActivities.where((activity) {
      // Search query
      if (_searchQuery.isNotEmpty) {
        final matchesSearch = activity.name.toLowerCase().contains(_searchQuery) ||
            activity.description.toLowerCase().contains(_searchQuery) ||
            activity.location.toLowerCase().contains(_searchQuery);
        if (!matchesSearch) return false;
      }

      // Category filter
      if (_selectedCategories.isNotEmpty &&
          !_selectedCategories.contains(activity.category)) {
        return false;
      }

      // Age group filter
      if (_selectedAgeGroups.isNotEmpty) {
        final hasMatchingAge = activity.ageGroups
            .any((age) => _selectedAgeGroups.contains(age));
        if (!hasMatchingAge) return false;
      }

      // Season filter
      if (_selectedSeasons.isNotEmpty &&
          !_selectedSeasons.contains(activity.season)) {
        return false;
      }

      // Location filter
      if (_selectedLocations.isNotEmpty &&
          !_selectedLocations.contains(activity.location)) {
        return false;
      }

      // Diverse filter
      if (_isDiverseFilter == true && !activity.isDiverse) {
        return false;
      }

      // Free filter
      if (_isFreeFilter == true && !activity.isFree) {
        return false;
      }

      // Price range filter
      if (_minPrice != null || _maxPrice != null) {
        if (activity.isFree) {
          // Free activities match if min price is 0 or null
          if (_minPrice != null && _minPrice! > 0) return false;
        } else if (activity.price != null) {
          if (_minPrice != null && activity.price! < _minPrice!) return false;
          if (_maxPrice != null && activity.price! > _maxPrice!) return false;
        }
      }

      return true;
    }).toList();

    // Apply sorting
    switch (_sortOption) {
      case SortOption.alphabetical:
        _filteredActivities.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.priceAsc:
        _filteredActivities.sort((a, b) {
          final priceA = a.isFree ? 0.0 : (a.price ?? double.infinity);
          final priceB = b.isFree ? 0.0 : (b.price ?? double.infinity);
          return priceA.compareTo(priceB);
        });
        break;
      case SortOption.priceDesc:
        _filteredActivities.sort((a, b) {
          final priceA = a.isFree ? 0.0 : (a.price ?? 0.0);
          final priceB = b.isFree ? 0.0 : (b.price ?? 0.0);
          return priceB.compareTo(priceA);
        });
        break;
      case SortOption.mostViewed:
        _filteredActivities.sort((a, b) => b.viewCount.compareTo(a.viewCount));
        break;
      case SortOption.newest:
        _filteredActivities.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    notifyListeners();
  }

  Future<void> trackActivityView(String activityId) async {
    final activity = _allActivities.firstWhere((a) => a.id == activityId);
    activity.incrementViewCount();
    
    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt('view_$activityId') ?? 0;
    await prefs.setInt('view_$activityId', currentCount + 1);
    
    notifyListeners();
  }

  Future<void> trackWebsiteClick(String activityId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt('click_$activityId') ?? 0;
    await prefs.setInt('click_$activityId', currentCount + 1);
  }
}
