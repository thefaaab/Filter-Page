class FilterData {
  FilterData({
    required this.name,
    required this.slug,
    required this.taxonomies,
  });

  String name;
  String slug;
  List<Taxonomy> taxonomies;

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
        name: json["name"],
        slug: json["slug"],
        taxonomies: List<Taxonomy>.from(
            json["taxonomies"].map((x) => Taxonomy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "taxonomies": List<dynamic>.from(taxonomies.map((x) => x.toJson())),
      };

  get taxonomyCounnt => taxonomies.where((element) => element.isChecked).length;
}

class Taxonomy {
  Taxonomy({
    this.id,
    this.guid,
    this.slug,
    this.name,
    this.city,
    this.locations,
  });

  int? id;
  String? guid;
  String? slug;
  String? name;
  String? city;
  bool isChecked = false;
  List<Location>? locations;

  factory Taxonomy.fromJson(Map<String, dynamic> json) => Taxonomy(
        id: json["id"],
        guid: json["Guid"],
        slug: json["slug"],
        name: json["name"],
        city: json["city"],
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Guid": guid,
        "slug": slug,
        "name": name,
        "city": city,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    required this.id,
    required this.guid,
    required this.slug,
    required this.name,
  });

  int id;
  String guid;
  String slug;
  String name;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        guid: json["Guid"],
        slug: json["slug"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Guid": guid,
        "slug": slug,
        "name": name,
      };
}
