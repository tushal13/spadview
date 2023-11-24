import 'dart:developer';
import 'dart:typed_data';

class UserModal{
  int? id;
  String? username;
  String? email;
  String? password;
  double? balance;
  Uint8List? image;

  UserModal( this.id, this.username, this.email, this.password, this.balance,this.image);

  UserModal.init() {
    log("Empty user initialized...");
  }

  factory UserModal.fromMap({required Map User}){
    return UserModal(
      User['Id'],
      User['Name'],
      User['Email'],
      User['Password'],
      double.parse(User['Balance']),
      User['Image'],
    );
  }
}