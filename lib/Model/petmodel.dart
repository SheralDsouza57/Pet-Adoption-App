class PetModel {
  String name;
  String place;
  String gender;
  String image;
  String bigImage;
  String price;
  String colour;
  String breed;
  String age;
  int id;
  bool isAdopted;

  PetModel(
      {required this.id,
      required this.name,
      required this.place,
      required this.gender,
      required this.image,
      required this.bigImage,
      required this.price,
      required this.colour,
      required this.breed,
      required this.age,
      required this.isAdopted});

// Converts a PetModel instance into a map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isAdopted': isAdopted,
        'place': place,
        'gender': gender,
        'image': image,
        'bigImage': bigImage,
        'price': price,
        'colour': colour,
        'breed': breed,
        'age': age,
      };

  // Constructs a PetModel instance from a map.
  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        id: json['id'],
        name: json['name'],
        isAdopted: json['isAdopted'],
        place: json['place'],
        gender: json['gender'],
        image: json['image'],
        bigImage: json['bigImage'],
        price: json['price'],
        colour: json['colour'],
        breed: json['breed'],
        age: json['age'],
      );
}
