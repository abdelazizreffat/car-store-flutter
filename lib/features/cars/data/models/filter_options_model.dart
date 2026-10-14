class FilterOptionsModel {
  final List<String> brands;
  final List<String> cities;
  final List<String> conditions;

  const FilterOptionsModel({
    this.brands = const [],
    this.cities = const [],
    this.conditions = const [],
  });

  // Parsed defensively: the actual response shape is not confirmed.
  // Tries common key names and falls back to empty lists gracefully.
  factory FilterOptionsModel.fromJson(Map<String, dynamic> json) {
    List<String> extract(List<String> keys) {
      for (final k in keys) {
        final v = json[k];
        if (v is List) return v.whereType<String>().toList();
        // Sometimes values are objects: [{name: "BMW"}, ...]
        if (v is List) {
          return v
              .whereType<Map>()
              .map((e) => e['name']?.toString() ?? '')
              .where((s) => s.isNotEmpty)
              .toList();
        }
      }
      return [];
    }

    // Try to unwrap a top-level data key
    final d = json['data'];
    final src = d is Map<String, dynamic> ? d : json;

    List<String> extractSrc(List<String> keys) {
      for (final k in keys) {
        final v = src[k];
        if (v is List<dynamic>) {
          if (v.isNotEmpty && v.first is String) {
            return v.whereType<String>().toList();
          }
          if (v.isNotEmpty && v.first is Map) {
            return v
                .whereType<Map>()
                .map((e) =>
                    (e['name'] ?? e['value'] ?? e['label'])?.toString() ?? '')
                .where((s) => s.isNotEmpty)
                .toList();
          }
        }
      }
      return extract(keys);
    }

    return FilterOptionsModel(
      brands: extractSrc(['brands', 'brand']),
      cities: extractSrc(['cities', 'city', 'locations']),
      conditions: extractSrc(['conditions', 'condition']),
    );
  }
}