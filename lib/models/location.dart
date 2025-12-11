class MetroArea {
  final String id;
  final String name;
  final String state;
  final String stateAbbr;
  final double latitude;
  final double longitude;
  final bool isFeatured;

  MetroArea({
    required this.id,
    required this.name,
    required this.state,
    required this.stateAbbr,
    required this.latitude,
    required this.longitude,
    this.isFeatured = false,
  });

  String get displayName => '$name, $stateAbbr';
  String get fullDisplayName => '$name, $state';

  // Predefined major metro areas
  static final List<MetroArea> featuredMetros = [
    MetroArea(
      id: 'charlotte_nc',
      name: 'Charlotte',
      state: 'North Carolina',
      stateAbbr: 'NC',
      latitude: 35.2271,
      longitude: -80.8431,
      isFeatured: true,
    ),
    MetroArea(
      id: 'atlanta_ga',
      name: 'Atlanta',
      state: 'Georgia',
      stateAbbr: 'GA',
      latitude: 33.7490,
      longitude: -84.3880,
      isFeatured: true,
    ),
    MetroArea(
      id: 'chicago_il',
      name: 'Chicago',
      state: 'Illinois',
      stateAbbr: 'IL',
      latitude: 41.8781,
      longitude: -87.6298,
      isFeatured: true,
    ),
    MetroArea(
      id: 'dallas_tx',
      name: 'Dallas',
      state: 'Texas',
      stateAbbr: 'TX',
      latitude: 32.7767,
      longitude: -96.7970,
      isFeatured: true,
    ),
    MetroArea(
      id: 'houston_tx',
      name: 'Houston',
      state: 'Texas',
      stateAbbr: 'TX',
      latitude: 29.7604,
      longitude: -95.3698,
      isFeatured: true,
    ),
    MetroArea(
      id: 'los_angeles_ca',
      name: 'Los Angeles',
      state: 'California',
      stateAbbr: 'CA',
      latitude: 34.0522,
      longitude: -118.2437,
      isFeatured: true,
    ),
    MetroArea(
      id: 'miami_fl',
      name: 'Miami',
      state: 'Florida',
      stateAbbr: 'FL',
      latitude: 25.7617,
      longitude: -80.1918,
      isFeatured: true,
    ),
    MetroArea(
      id: 'new_york_ny',
      name: 'New York',
      state: 'New York',
      stateAbbr: 'NY',
      latitude: 40.7128,
      longitude: -74.0060,
      isFeatured: true,
    ),
    MetroArea(
      id: 'phoenix_az',
      name: 'Phoenix',
      state: 'Arizona',
      stateAbbr: 'AZ',
      latitude: 33.4484,
      longitude: -112.0740,
      isFeatured: true,
    ),
    MetroArea(
      id: 'philadelphia_pa',
      name: 'Philadelphia',
      state: 'Pennsylvania',
      stateAbbr: 'PA',
      latitude: 39.9526,
      longitude: -75.1652,
      isFeatured: true,
    ),
    MetroArea(
      id: 'san_antonio_tx',
      name: 'San Antonio',
      state: 'Texas',
      stateAbbr: 'TX',
      latitude: 29.4241,
      longitude: -98.4936,
      isFeatured: true,
    ),
    MetroArea(
      id: 'san_diego_ca',
      name: 'San Diego',
      state: 'California',
      stateAbbr: 'CA',
      latitude: 32.7157,
      longitude: -117.1611,
      isFeatured: true,
    ),
  ];

  static MetroArea? findById(String id) {
    try {
      return featuredMetros.firstWhere((metro) => metro.id == id);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'state': state,
        'stateAbbr': stateAbbr,
        'latitude': latitude,
        'longitude': longitude,
        'isFeatured': isFeatured,
      };

  factory MetroArea.fromJson(Map<String, dynamic> json) => MetroArea(
        id: json['id'] as String,
        name: json['name'] as String,
        state: json['state'] as String,
        stateAbbr: json['stateAbbr'] as String,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        isFeatured: json['isFeatured'] as bool? ?? false,
      );
}

class UserLocation {
  final String metroId;
  final String displayName;
  final double? latitude;
  final double? longitude;
  final bool isCustom;

  UserLocation({
    required this.metroId,
    required this.displayName,
    this.latitude,
    this.longitude,
    this.isCustom = false,
  });

  Map<String, dynamic> toJson() => {
        'metroId': metroId,
        'displayName': displayName,
        'latitude': latitude,
        'longitude': longitude,
        'isCustom': isCustom,
      };

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        metroId: json['metroId'] as String,
        displayName: json['displayName'] as String,
        latitude: json['latitude'] as double?,
        longitude: json['longitude'] as double?,
        isCustom: json['isCustom'] as bool? ?? false,
      );
}
