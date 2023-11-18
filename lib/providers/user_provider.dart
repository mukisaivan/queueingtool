import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queueingtool/models/user.dart';

class UserProvider extends StateNotifier<UserModel> {
  UserProvider(UserModel state) : super(state);

  void updateUser(UserModel newUser) {
    state = newUser;
  }
}

final userProvider = StateNotifierProvider<UserProvider, UserModel>(
  (ref) => UserProvider(UserModel(
    email: '',
    uid: '',
    photoUrl: '',
    username: '',
    role: '',
    accountType: AccountTypeEnum.Normal,
  )),
);
