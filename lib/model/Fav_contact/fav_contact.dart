import 'dart:typed_data';

//The communication between database and data occurs in the form of objects.
//So, we need to define what we want to insert into the database.

class FavContact {
  final String id;
  final String displayName;
  final String phoneNumbers;
  final Uint8List? image;

  //constructor
  FavContact({
    required this.id,
    required this.displayName,
    required this.phoneNumbers,
    this.image,
  });
}


//The final keyword declares a variable at runtime, and a value is assigned to it only once.

//The required keyword represents that a value is necessary for the following variable.

//The this keyword represents the current class and its variables.
