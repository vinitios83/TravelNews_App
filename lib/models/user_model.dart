
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String aName;
  @HiveField(3)
  final String aId;
  @HiveField(4)
  final String aType;
  UserModel({
    required this.username,
    required this.password,
    required this.aName,
    required this.aId,
    required this.aType,
  });
}
