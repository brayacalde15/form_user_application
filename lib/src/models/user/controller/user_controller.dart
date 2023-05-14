import 'package:form_user_application/src/models/user/model_user/model_user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final users = <User>[].obs;

  List<User> get user => users;

  void addUser(User user) {
    users.add(user);
  }

  void addNewAddress() {
    final user = users.last;
    user.addresses.add('');
  }
}
