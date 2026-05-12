import 'package:mosque_finder_app/feature/auth/presentation/vm/login_vm.dart';
import 'package:mosque_finder_app/feature/feed/presentation/vm/feed_viewmodel.dart';
import 'package:mosque_finder_app/feature/profile/vm/change_password_vm.dart';
import 'package:mosque_finder_app/feature/profile/vm/profile_screen_vm.dart';
import 'package:mosque_finder_app/feature/profile/vm/reminder_screen_vm.dart';
import 'package:mosque_finder_app/feature/profile/vm/user_info_profile_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginVm>(create: ((context) => LoginVm())),

  ChangeNotifierProvider<ProfileScreenVm>(
    create: (context) => ProfileScreenVm(),
  ),

  ChangeNotifierProvider<UserInfoProfileVm>(
    create: (context) => UserInfoProfileVm(),
  ),

  ChangeNotifierProvider<ChangePasswordVm>(
    create: (context) => ChangePasswordVm(),
  ),

  ChangeNotifierProvider<ReminderScreenVm>(
    create: (context) => ReminderScreenVm(),
  ),
  ChangeNotifierProvider<FeedViewModel>(create: (context) => FeedViewModel()),
];
