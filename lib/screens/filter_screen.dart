import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activities_provider.dart';
import '../models/activity.dart';
import '../theme/app_theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double? _minPrice;
  double? _maxPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          Consumer<ActivitiesProvider>(
            builder: (context, provider, child) {
              return TextButton(
                onPressed: () {
                  provider.clearAllFilters();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ActivitiesProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Category',
                    _buildCategoryFilters(provider),
                  ),
                  const Divider(height: 1),
                  _buildSection(
                    'Age Group',
                    _buildAgeGroupFilters(provider),
                  ),
                  const Divider(height: 1),
                  _buildSection(
                    'Timeframe',
                    _buildSeasonFilters(provider),
                  ),
                  const Divider(height: 1),
                  _buildSection(
                    'Location',
                    _buildLocationFilters(provider),
                  ),
                  const Divider(height: 1),
                  _buildSection(
                    'Special Filters',
                    _buildSpecialFilters(provider),
                  ),
                  const Divider(height: 1),
                  _buildSection(
                    'Price Range',
                    _buildPriceRangeFilter(provider),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -2),
              blurRadius: 4,
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply Filters'),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(ActivitiesProvider provider) {
    final categories = [
      {'value': Category.afterSchool, 'label': 'After School'},
      {'value': Category.camps, 'label': 'Camps'},
      {'value': Category.sports, 'label': 'Sports'},
      {'value': Category.arts, 'label': 'Arts'},
      {'value': Category.multicultural, 'label': 'Multicultural'},
      {'value': Category.childcare, 'label': 'Childcare'},
      {'value': Category.enrichment, 'label': 'Enrichment'},
      {'value': Category.dropIn, 'label': 'Drop-In'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((cat) {
        final isSelected =
            provider.selectedCategories.contains(cat['value'] as Category);
        return FilterChip(
          label: Text(cat['label'] as String),
          selected: isSelected,
          onSelected: (_) =>
              provider.toggleCategory(cat['value'] as Category),
          backgroundColor: AppTheme.cardBackground,
          selectedColor: AppTheme.primaryBlue,
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textDark,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAgeGroupFilters(ActivitiesProvider provider) {
    final ageGroups = [
      {'value': AgeGroup.infant, 'label': 'Infant (0-1)'},
      {'value': AgeGroup.toddler, 'label': 'Toddler (1-3)'},
      {'value': AgeGroup.preschool, 'label': 'Preschool (3-5)'},
      {'value': AgeGroup.elementary, 'label': 'Elementary (5-12)'},
      {'value': AgeGroup.teen, 'label': 'Teen (13-18)'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ageGroups.map((age) {
        final isSelected =
            provider.selectedAgeGroups.contains(age['value'] as AgeGroup);
        return FilterChip(
          label: Text(age['label'] as String),
          selected: isSelected,
          onSelected: (_) => provider.toggleAgeGroup(age['value'] as AgeGroup),
          backgroundColor: AppTheme.cardBackground,
          selectedColor: AppTheme.primaryBlue,
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textDark,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSeasonFilters(ActivitiesProvider provider) {
    final seasons = [
      {'value': Season.yearRound, 'label': 'Year-Round'},
      {'value': Season.spring, 'label': 'Spring'},
      {'value': Season.summer, 'label': 'Summer'},
      {'value': Season.fall, 'label': 'Fall'},
      {'value': Season.winter, 'label': 'Winter'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: seasons.map((season) {
        final isSelected =
            provider.selectedSeasons.contains(season['value'] as Season);
        return FilterChip(
          label: Text(season['label'] as String),
          selected: isSelected,
          onSelected: (_) => provider.toggleSeason(season['value'] as Season),
          backgroundColor: AppTheme.cardBackground,
          selectedColor: AppTheme.primaryBlue,
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textDark,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLocationFilters(ActivitiesProvider provider) {
    final locations = provider.availableLocations;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: locations.map((location) {
        final isSelected = provider.selectedLocations.contains(location);
        return FilterChip(
          label: Text(location),
          selected: isSelected,
          onSelected: (_) => provider.toggleLocation(location),
          backgroundColor: AppTheme.cardBackground,
          selectedColor: AppTheme.primaryBlue,
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textDark,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSpecialFilters(ActivitiesProvider provider) {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Diverse/Multicultural Programs'),
          subtitle: const Text('Programs celebrating diverse cultures'),
          value: provider.isDiverseFilter ?? false,
          onChanged: (value) {
            provider.setDiverseFilter(value == true ? true : null);
          },
          activeColor: AppTheme.accentGreen,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          title: const Text('Free Programs'),
          subtitle: const Text('No cost activities'),
          value: provider.isFreeFilter ?? false,
          onChanged: (value) {
            provider.setFreeFilter(value == true ? true : null);
          },
          activeColor: AppTheme.accentGreen,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildPriceRangeFilter(ActivitiesProvider provider) {
    _minPrice ??= provider.minPrice;
    _maxPrice ??= provider.maxPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Min Price',
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _minPrice = double.tryParse(value);
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Max Price',
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _maxPrice = double.tryParse(value);
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            provider.setPriceRange(_minPrice, _maxPrice);
          },
          child: const Text('Apply Price Range'),
        ),
      ],
    );
  }
}
