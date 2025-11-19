// To parse this JSON data, do
//
//     final newsEntry = newsEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ProductEntry {
    int user;
    String name;
    String price;
    bool promo;
    String description;
    int stock;
    Color color;
    Size size;
    String thumbnail;
    Category category;
    bool isFeatured;

    ProductEntry({
        required this.user,
        required this.name,
        required this.price,
        required this.promo,
        required this.description,
        required this.stock,
        required this.color,
        required this.size,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        promo: json["promo"],
        description: json["description"],
        stock: json["stock"],
        color: colorValues.map[json["color"]]!,
        size: sizeValues.map[json["size"]]!,
        thumbnail: json["thumbnail"],
        category: categoryValues.map[json["category"]]!,
        isFeatured: json["is_featured"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "promo": promo,
        "description": description,
        "stock": stock,
        "color": colorValues.reverse[color],
        "size": sizeValues.reverse[size],
        "thumbnail": thumbnail,
        "category": categoryValues.reverse[category],
        "is_featured": isFeatured,
    };
}

enum Category {
    EMPTY,
    JACKETS,
    JERSEY_OLAHRAGA,
    OFFICIAL_MERCHANDISE,
    SMARTWATCH
}

final categoryValues = EnumValues({
    "": Category.EMPTY,
    "jackets": Category.JACKETS,
    "Jersey Olahraga": Category.JERSEY_OLAHRAGA,
    "Official Merchandise": Category.OFFICIAL_MERCHANDISE,
    "Smartwatch": Category.SMARTWATCH
});

enum Color {
    BLACK,
    COLOR_PINK,
    EMPTY,
    PINK
}

final colorValues = EnumValues({
    "Black": Color.BLACK,
    "pink": Color.COLOR_PINK,
    "": Color.EMPTY,
    "Pink": Color.PINK
});

enum Size {
    EMPTY,
    M,
    SIZE,
    XL
}

final sizeValues = EnumValues({
    "": Size.EMPTY,
    "M": Size.M,
    "-": Size.SIZE,
    "XL": Size.XL
});

enum Model {
    MAIN_PRODUCT
}

final modelValues = EnumValues({
    "main.product": Model.MAIN_PRODUCT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
