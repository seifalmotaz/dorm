import 'package:dorm/dorm.dart';

// part './database.g.dart';

typedef NullData = bool;

@Table()
class User {
  late String id;

  late String username;
  late String password;

  late String email;
  late String firstName;
  late String lastName;

  late DateTime lastSeen;
  late DateTime dateJoined;

  late bool? active;
  late bool isStaff;
  late bool isSuperUser;
}

void main() {
  final bool t = true;
  final NullData t2 = true;
  print(true is NullData);
  print(t2 is NullData);
  print(t is NullData);
}
