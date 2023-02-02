// ignore_for_file: file_names, slash_for_doc_comments, invalid_use_of_protected_member, unused_local_variable, avoid_print
// ignore_for_file: unused_import

import 'dart:convert';

import 'package:eboy_app/DBService/DBServer.dart';
import 'package:eboy_app/models/Errand.dart';
import 'package:eboy_app/models/States.dart';
import 'package:eboy_app/models/User.dart';
import 'package:eboy_app/models/eService.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegistrationController extends GetxController {
  RxList<String> picList = [
    "assets/images/0.png",
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png"
  ].obs;

  RxInt indx = 0.obs;
  //bottomBar position

  RxInt bBarPosition = 0.obs;

  /// Holds form filled Status
  RxBool formFilled = false.obs;

  ///List of all Users
  var users = <User>[].obs;

  ///User
  var user = User().obs;

  ///Errand
  Rx<Errand> errand = Errand().obs;

  ///List of Local govts.
  var lgas = <dynamic>[].obs;

  ///State
  var selectedState = States().obs;

  ///Selected Local govt
  var selectedLg = ''.obs;

  ///Destination Local govt.
  var destinationLg = ''.obs;

  ///Holds the state of Loading...
  RxBool isLoading = false.obs;

  ///List of Services
  RxList<EService> services = <EService>[].obs;

  /// List of States
  RxList<States> states = <States>[].obs;
  var state = States().obs;

  /// Expand status
  RxBool isExpanded = false.obs;

  /// List of User Errands
  var userErrands = <Errand>[].obs;

  /**Get_Storage Processes 
   
  **/

  User get currentUser => User.fromJson(GetStorage().read('user'));

  bool get isFirstTimeUser => GetStorage().read('first') ?? true;

  setFirstTime(bool value) => GetStorage().write('first', value);

  setUser(User user) => GetStorage().write('user', user.toJson());

  //void setErrand(Errand _errand) => GetStorage().write('errand', _errand);

  bool get isLoggedIn =>
      GetStorage().read('LoggedIn') ??
      false; //Checks if LoggedIn is true. If its null assign False

  setLoggIn(bool value) => GetStorage().write('LoggedIn', value);

  ///
  ///

  @override
  void onInit() async {
    super.onInit();

    ///
    states.addAllIf(states.isEmpty, await Server.getStates());
    selectedState = states[31].obs; //Set Default State to Pau
    var lgz = lgas;
    lgz = selectedState.value.lgas.obs;
    lgas = lgz;
    //selectedLg = lgas[0].obs;

    // services.clear();

    // services.addAllIf(
    //     services.isEmpty,
    //     await Server
    //         .getServices()); //Adds All the Services to the GetX reactive List

    users.addAllIf(users.isEmpty,
        await Server.getUsers()); //Adds All the Users to the GetX reactive List

    //List storedData = GetStorage().read<List>('services');
    List storedUsers = GetStorage().read<List>('users');
    List storedErrands = GetStorage().read<List>('userErrands');

    // if (storedData != null) {
    //   services = storedData
    //       .map<EService>((item) => EService.fromJson(item))
    //       .toList()
    //       .obs;
    //   print("SERV: ${services.length}");
    // }

    if (storedUsers != null) {
      users = storedUsers.map<User>((item) => User.fromJson(item)).toList().obs;
      print("USERS >> ${users.length}");
    }

    getUserErrands() {
      storedErrands = <dynamic>[];

      userErrands = storedErrands
          .map<Errand>((item) => Errand.fromJson(item))
          .toList()
          .obs;
      print("UserErrands in storage >> ${userErrands.length}");
    }

    storedErrands ??= getUserErrands();
    //if (storedErrands!.isNotEmpty) {}

    ever(errand, (_) => GetStorage().write('errand', errand));
    //ever(services, (_) => GetStorage().write('services', services.toList()));
    ever(users, (_) => GetStorage().write('users', users));
    ever(userErrands,
        (_) => GetStorage().write('userErrands', userErrands.toList()));
  }
}
