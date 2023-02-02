// ignore_for_file: unused_import,file_names, avoid_print

import 'package:eboy_app/models/hErrand.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HouseholdController extends GetxController {
  var apartmentOptions = [
    'Single Self Contain',
    '1 Bedroom Flat',
    '2 Bedroom Flat',
    '3 Bedroom Bungalow',
    'Duplex'
  ].obs;

  var frequency = ['Twice a Week', 'Weekends'].obs;
  var selectedSchedule = ''.obs;
  var houseErrand = HErrand().obs;
  RxString apartmentType = ''.obs;
  RxString startDate = "".obs;

  RxList<HErrand> hErrands = <HErrand>[].obs;

  //GetStorage methods
  ///Save errand to Local Storage
  void setHouseErrand(HErrand herrand) =>
      GetStorage().write('houseErrand', herrand.toJson());

  ///Get Errand from Local Storage
  HErrand get errandInStorage =>
      HErrand.fromJson(GetStorage().read('houseErrand'));

  @override
  void onInit() {
    super.onInit();
    apartmentType = apartmentOptions[0].obs;
    selectedSchedule = frequency[0].obs;

    List storedHErrands = <
        dynamic>[]; //Initialize an empty list of stored items to avoid initialization-error

    storedHErrands = GetStorage().read<List>('hErrands');

    ///Get Stored Household cleaning errands
    void getHErrands() {
      hErrands = storedHErrands
          .map<HErrand>((item) => HErrand.fromJson(item))
          .toList()
          .obs;
      print("HouseErrands in storage >> ${hErrands.length}");
    }

    if (storedHErrands != null) {
      getHErrands(); //Gets Lists of HErrands from Local Storage
    }

    ever(hErrands, (_) => GetStorage().write('hErrands', hErrands.toList()));
  }
}
