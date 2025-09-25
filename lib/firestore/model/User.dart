class User{
  static const String collection = "User";
  String? ID;
  String? fullName;
  int? Age;
  String? phone;
  String? email;
  User({this.ID, this.fullName, this.Age, this.phone, this.email});
  // mobile app -> FireStore
  // Mobile -> User -> FireStore (Create)
  // mobile <- User <- FireStore (Read)

  // To turn your object to map
  // dynamic to take any input type
  Map<String, dynamic> toFirestore(){
    return {
      "FullName" : fullName,
      "id" : ID,
      "Age" : Age,
      "PhoneNumber":phone,
      "Email":email
    };
  }

  // To turn yor map to object
  User.formFirestore(Map<String, dynamic>? data){
    fullName = data?["FullName"];
    ID = data?["id"];
    Age = data?["Age"];
    phone = data?["PhoneNumber"];
    email = data?["Email"];
  }
}