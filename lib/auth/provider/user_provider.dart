import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';
import '../repository/user_data_service.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async{
  final UserModel user = await ref.watch(userDataServiceProvider).fetchCurrentUserData();
  return user;
});


final anyuserProvider = FutureProvider.family((ref,userid) async {
  final UserModel user = await ref.watch(userDataServiceProvider).fetchnnyUserData(userid);
  return user;
});