import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/location.dart';
import '../providers/activities_provider.dart';
import '../theme/app_theme.dart';

class LocationSelectionScreen extends StatefulWidget {
  final bool isInitialSetup;

  const LocationSelectionScreen({
    super.key,
    this.isInitialSetup = true,
  });

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _customLocationController =
      TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _customLocationController.dispose();
    super.dispose();
  }

  void _selectMetro(BuildContext context, MetroArea metro) {
    final provider = context.read<ActivitiesProvider>();
    provider.setUserLocation(UserLocation(
      metroId: metro.id,
      displayName: metro.displayName,
      latitude: metro.latitude,
      longitude: metro.longitude,
      isCustom: false,
    ));

    if (widget.isInitialSetup) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pop(context);
    }
  }

  void _selectCustomLocation(BuildContext context, String locationName) {
    if (locationName.trim().isEmpty) return;

    final provider = context.read<ActivitiesProvider>();
    provider.setUserLocation(UserLocation(
      metroId: 'custom_${locationName.toLowerCase().replaceAll(' ', '_')}',
      displayName: locationName,
      isCustom: true,
    ));

    if (widget.isInitialSetup) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isInitialSetup
          ? null
          : AppBar(
              title: const Text('Change Location'),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isInitialSetup) ...[
                  const SizedBox(height: 32),
                  Center(
                    child: Image.asset(
                      'assets/icon/app_icon.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to KidsList!',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find activities for your kids across the nation',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                ],
                Text(
                  'Select Your Location',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a metro area to see local activities',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for your city...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _customLocationController.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  controller: _customLocationController,
                ),
                const SizedBox(height: 32),
                if (_searchQuery.isEmpty) ...[
                  Text(
                    'Featured Metro Areas',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildFeaturedMetros(context),
                ] else ...[
                  _buildSearchResults(context),
                ],
                const SizedBox(height: 32),
                if (_searchQuery.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryBlue.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppTheme.primaryBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Custom Location',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Don\'t see your city? Type any location in the search box above to get started.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedMetros(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: MetroArea.featuredMetros.length,
      itemBuilder: (context, index) {
        final metro = MetroArea.featuredMetros[index];
        return _buildMetroCard(context, metro);
      },
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final filteredMetros = MetroArea.featuredMetros
        .where((metro) =>
            metro.name.toLowerCase().contains(_searchQuery) ||
            metro.state.toLowerCase().contains(_searchQuery) ||
            metro.stateAbbr.toLowerCase().contains(_searchQuery))
        .toList();

    if (filteredMetros.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 32),
          Icon(
            Icons.location_searching,
            size: 64,
            color: AppTheme.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            'No matching metro areas',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Use "${_customLocationController.text}" as custom location?',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _selectCustomLocation(
              context,
              _customLocationController.text,
            ),
            child: const Text('Use Custom Location'),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${filteredMetros.length} metro area${filteredMetros.length == 1 ? '' : 's'} found',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: filteredMetros.length,
          itemBuilder: (context, index) {
            return _buildMetroCard(context, filteredMetros[index]);
          },
        ),
        if (_customLocationController.text.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton.icon(
              onPressed: () => _selectCustomLocation(
                context,
                _customLocationController.text,
              ),
              icon: const Icon(Icons.add_location),
              label: Text('Use "${_customLocationController.text}"'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMetroCard(BuildContext context, MetroArea metro) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.borderLight, width: 1.5),
      ),
      child: InkWell(
        onTap: () => _selectMetro(context, metro),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    size: 20,
                    color: AppTheme.primaryBlue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      metro.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Text(
                  metro.stateAbbr,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
