enum Category {
  afterSchool,
  camps,
  sports,
  arts,
  multicultural,
  childcare,
  enrichment,
  dropIn,
}

enum AgeGroup {
  infant, // 0-1
  toddler, // 1-3
  preschool, // 3-5
  elementary, // 5-12
  teen, // 13-18
}

enum Season {
  spring,
  summer,
  fall,
  winter,
  yearRound,
}

class Activity {
  final String id;
  final String name;
  final String description;
  final Category category;
  final List<AgeGroup> ageGroups;
  final String location;
  final String address;
  final Season season;
  final bool isDiverse;
  final bool isFree;
  final double? price;
  final String? priceDescription;
  final String phoneNumber;
  final String email;
  final String? website;
  final List<String> inclusionHighlights;
  final double latitude;
  final double longitude;
  int viewCount;
  final DateTime createdAt;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.ageGroups,
    required this.location,
    required this.address,
    required this.season,
    this.isDiverse = false,
    this.isFree = false,
    this.price,
    this.priceDescription,
    required this.phoneNumber,
    required this.email,
    this.website,
    this.inclusionHighlights = const [],
    required this.latitude,
    required this.longitude,
    this.viewCount = 0,
    required this.createdAt,
  });

  String get categoryName {
    switch (category) {
      case Category.afterSchool:
        return 'After School';
      case Category.camps:
        return 'Camps';
      case Category.sports:
        return 'Sports';
      case Category.arts:
        return 'Arts';
      case Category.multicultural:
        return 'Multicultural';
      case Category.childcare:
        return 'Childcare';
      case Category.enrichment:
        return 'Enrichment';
      case Category.dropIn:
        return 'Drop-In';
    }
  }

  String get ageGroupsDisplay {
    return ageGroups.map((age) {
      switch (age) {
        case AgeGroup.infant:
          return 'Infant (0-1)';
        case AgeGroup.toddler:
          return 'Toddler (1-3)';
        case AgeGroup.preschool:
          return 'Preschool (3-5)';
        case AgeGroup.elementary:
          return 'Elementary (5-12)';
        case AgeGroup.teen:
          return 'Teen (13-18)';
      }
    }).join(', ');
  }

  String get seasonDisplay {
    switch (season) {
      case Season.spring:
        return 'Spring';
      case Season.summer:
        return 'Summer';
      case Season.fall:
        return 'Fall';
      case Season.winter:
        return 'Winter';
      case Season.yearRound:
        return 'Year-Round';
    }
  }

  String get priceDisplay {
    if (isFree) return 'Free';
    if (price != null) return '\$${price!.toStringAsFixed(2)}';
    return priceDescription ?? 'Contact for pricing';
  }

  void incrementViewCount() {
    viewCount++;
  }
}
