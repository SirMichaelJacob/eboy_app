// ignore_for_file: file_names, constant_identifier_names, unused_field, avoid_print, unnecessary_string_escapes
import 'dart:convert';
import 'dart:async';

import 'package:eboy_app/models/Errand.dart';
import 'package:eboy_app/models/States.dart';
import 'package:eboy_app/models/User.dart';
import 'package:eboy_app/models/hErrand.dart';
import 'package:http/http.dart' as http;
import 'package:eboy_app/models/eService.dart';

class Server {
  //static const ROOT = "http://localhost/errand_app/actions.php";
  //static const ROOT = "http://192.168.11.1/errand_app/actions.php";
  static const ROOT = "http://www.cororato.com/web_action.php";
  static const _GET_SERVICES = "GET_ALL_SERVICES";
  static const _ADD_USER = "ADD_USER";
  static const _GET_ALL_USERS = "GET_ALL_USERS";
  static const _ADD_PICKUP = "NEW_PICKUP";
  static const _GET_USER_PICKUPS = "GET_USER_PICKUPS";
  static const _ADD_HOUSEERRAND = "NEW_HOUSEERRAND";
  static const _GET_USER_HOUSEERRANDS = "GET_USER_HOUSEERRANDS";

  //Add User
  static Future<String> addUser(String fname, String lname, String phone,
      String email, String password) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_USER;
      map['firstname'] = fname;
      map['lastname'] = lname;
      map['email'] = email;
      map['phone'] = phone;
      map['password'] = password;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("GET ADD USER Response: ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  ///Add Pickup errand
  static Future<String> addErrand(
    String item,
    String state,
    String pickupLG,
    String pickupLocation,
    String destinationLG,
    String destination,
    String receiverPhone,
    String status,
    String userId,
  ) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_PICKUP;
      map['item'] = item;
      map['state'] = state;
      map['pickupLG'] = pickupLG;
      map['pickupLocation'] = pickupLocation;
      map['destinationLG'] = destinationLG;
      map['destination'] = destination;
      map['receiverPhone'] = receiverPhone;
      map['status'] = status;
      map['userId'] = userId;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("ADD_PICKUP response:${response.body}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  ///New Household Errand
  static Future<String> addHouseErrand(
      String appartmentType,
      String address,
      String state,
      String lg,
      String phone,
      String startdate,
      String enddate,
      String frequency,
      String userId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_HOUSEERRAND;
      map['address'] = address;
      map['state'] = state;
      map['lg'] = lg;
      map['phone'] = phone;
      map['appartmentType'] = appartmentType;
      map['startdate'] = startdate;
      map['enddate'] = enddate;
      map['frequency'] = frequency;
      map['status'] = 'NEW';
      map['userId'] = userId;

      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  ///

  //Get All Users
  static Future<List<User>> getUsers() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_USERS;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("GET Users response ${response.body}");
      if (response.statusCode == 200) {
        var list = <User>[];
        list = parseUsers(response.body);

        return list;
      } else {
        return <User>[];
      }
    } catch (e) {
      return <User>[];
    }
  }

  //Get all Services
  static Future<List<EService>> getServices() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_SERVICES;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("GET SERVICES Response: ${response.body}");
      if (response.statusCode == 200) {
        List<EService> list = <EService>[];
        list = parseService(response.body);
        return list;
      } else {
        return <EService>[];
      }
    } catch (e) {
      return <EService>[];
    }
  }

  //Get all States

  static Future<List<States>> getStates() async {
    try {
      var statesLgs = [
        {
          "state": "Abia",
          "lgas": [
            "Aba North",
            "Aba South",
            "Arochukwu",
            "Bende",
            "Ikawuno",
            "Ikwuano",
            "Isiala-Ngwa North",
            "Isiala-Ngwa South",
            "Isuikwuato",
            "Umu Nneochi",
            "Obi Ngwa",
            "Obioma Ngwa",
            "Ohafia",
            "Ohaozara",
            "Osisioma",
            "Ugwunagbo",
            "Ukwa West",
            "Ukwa East",
            "Umuahia North",
            "Umuahia South"
          ]
        },
        {
          "state": "Adamawa",
          "lgas": [
            "Demsa",
            "Fufore",
            "Ganye",
            "Girei",
            "Gombi",
            "Guyuk",
            "Hong",
            "Jada",
            "Lamurde",
            "Madagali",
            "Maiha",
            "Mayo-Belwa",
            "Michika",
            "Mubi-North",
            "Mubi-South",
            "Numan",
            "Shelleng",
            "Song",
            "Toungo",
            "Yola North",
            "Yola South"
          ]
        },
        {
          "state": "Akwa Ibom",
          "lgas": [
            "Abak",
            "Eastern-Obolo",
            "Eket",
            "Esit-Eket",
            "Essien-Udim",
            "Etim-Ekpo",
            "Etinan",
            "Ibeno",
            "Ibesikpo-Asutan",
            "Ibiono-Ibom",
            "Ika",
            "Ikono",
            "Ikot-Abasi",
            "Ikot-Ekpene",
            "Ini",
            "Itu",
            "Mbo",
            "Mkpat-Enin",
            "Nsit-Atai",
            "Nsit-Ibom",
            "Nsit-Ubium",
            "Obot-Akara",
            "Okobo",
            "Onna",
            "Oron",
            "Oruk Anam",
            "Udung-Uko",
            "Ukanafun",
            "Urue-Offong/Oruko",
            "Uruan",
            "Uyo"
          ]
        },
        {
          "state": "Anambra",
          "lgas": [
            "Aguata",
            "Anambra East",
            "Anambra West",
            "Anaocha",
            "Awka North",
            "Awka South",
            "Ayamelum",
            "Dunukofia",
            "Ekwusigo",
            "Idemili-North",
            "Idemili-South",
            "Ihiala",
            "Njikoka",
            "Nnewi-North",
            "Nnewi-South",
            "Ogbaru",
            "Onitsha-North",
            "Onitsha-South",
            "Orumba-North",
            "Orumba-South"
          ]
        },
        {
          "state": "Bauchi",
          "lgas": [
            "Alkaleri",
            "Bauchi",
            "Bogoro",
            "Damban",
            "Darazo",
            "Dass",
            "Gamawa",
            "Ganjuwa",
            "Giade",
            "Itas\/Gadau",
            "Jama'Are",
            "Katagum",
            "Kirfi",
            "Misau",
            "Ningi",
            "Shira",
            "Tafawa-Balewa",
            "Toro",
            "Warji",
            "Zaki"
          ]
        },
        {
          "state": "Benue",
          "lgas": [
            "Ado",
            "Agatu",
            "Apa",
            "Buruku",
            "Gboko",
            "Guma",
            "Gwer-East",
            "Gwer-West",
            "Katsina-Ala",
            "Konshisha",
            "Kwande",
            "Logo",
            "Makurdi",
            "Ogbadibo",
            "Ohimini",
            "Oju",
            "Okpokwu",
            "Otukpo",
            "Tarka",
            "Ukum",
            "Ushongo",
            "Vandeikya"
          ]
        },
        {
          "state": "Borno",
          "lgas": [
            "Abadam",
            "Askira-Uba",
            "Bama",
            "Bayo",
            "Biu",
            "Chibok",
            "Damboa",
            "Dikwa",
            "Gubio",
            "Guzamala",
            "Gwoza",
            "Hawul",
            "Jere",
            "Kaga",
            "Kala\/Balge",
            "Konduga",
            "Kukawa",
            "Kwaya-Kusar",
            "Mafa",
            "Magumeri",
            "Maiduguri",
            "Marte",
            "Mobbar",
            "Monguno",
            "Ngala",
            "Nganzai",
            "Shani"
          ]
        },
        {
          "state": "Bayelsa",
          "lgas": [
            "Brass",
            "Ekeremor",
            "Kolokuma\/Opokuma",
            "Nembe",
            "Ogbia",
            "Sagbama",
            "Southern-Ijaw",
            "Yenagoa"
          ]
        },
        {
          "state": "Cross River",
          "lgas": [
            "Abi",
            "Akamkpa",
            "Akpabuyo",
            "Bakassi",
            "Bekwarra",
            "Biase",
            "Boki",
            "Calabar-Municipal",
            "Calabar-South",
            "Etung",
            "Ikom",
            "Obanliku",
            "Obubra",
            "Obudu",
            "Odukpani",
            "Ogoja",
            "Yakurr",
            "Yala"
          ]
        },
        {
          "state": "Delta",
          "lgas": [
            "Aniocha North",
            "Aniocha-North",
            "Aniocha-South",
            "Bomadi",
            "Burutu",
            "Ethiope-East",
            "Ethiope-West",
            "Ika-North-East",
            "Ika-South",
            "Isoko-North",
            "Isoko-South",
            "Ndokwa-East",
            "Ndokwa-West",
            "Okpe",
            "Oshimili-North",
            "Oshimili-South",
            "Patani",
            "Sapele",
            "Udu",
            "Ughelli-North",
            "Ughelli-South",
            "Ukwuani",
            "Uvwie",
            "Warri South-West",
            "Warri North",
            "Warri South"
          ]
        },
        {
          "state": "Ebonyi",
          "lgas": [
            "Abakaliki",
            "Afikpo-North",
            "Afikpo South (Edda)",
            "Ebonyi",
            "Ezza-North",
            "Ezza-South",
            "Ikwo",
            "Ishielu",
            "Ivo",
            "Izzi",
            "Ohaukwu",
            "Onicha"
          ]
        },
        {
          "state": "Edo",
          "lgas": [
            "Akoko Edo",
            "Egor",
            "Esan-Central",
            "Esan-North-East",
            "Esan-South-East",
            "Esan-West",
            "Etsako-Central",
            "Etsako-East",
            "Etsako-West",
            "Igueben",
            "Ikpoba-Okha",
            "Oredo",
            "Orhionmwon",
            "Ovia-North-East",
            "Ovia-South-West",
            "Owan East",
            "Owan-West",
            "Uhunmwonde"
          ]
        },
        {
          "state": "Ekiti",
          "lgas": [
            "Ado-Ekiti",
            "Efon",
            "Ekiti-East",
            "Ekiti-South-West",
            "Ekiti-West",
            "Emure",
            "Gbonyin",
            "Ido-Osi",
            "Ijero",
            "Ikere",
            "Ikole",
            "Ilejemeje",
            "Irepodun\/Ifelodun",
            "Ise-Orun",
            "Moba",
            "Oye"
          ]
        },
        {
          "state": "Enugu",
          "lgas": [
            "Aninri",
            "Awgu",
            "Enugu-East",
            "Enugu-North",
            "Enugu-South",
            "Ezeagu",
            "Igbo-Etiti",
            "Igbo-Eze-North",
            "Igbo-Eze-South",
            "Isi-Uzo",
            "Nkanu-East",
            "Nkanu-West",
            "Nsukka",
            "Oji-River",
            "Udenu",
            "Udi",
            "Uzo-Uwani"
          ]
        },
        {
          "state": "Abuja (FCT)",
          "lgas": ["Abuja", "Kwali", "Kuje", "Gwagwalada", "Bwari", "Abaji"]
        },
        {
          "state": "Gombe",
          "lgas": [
            "Akko",
            "Balanga",
            "Billiri",
            "Dukku",
            "Funakaye",
            "Gombe",
            "Kaltungo",
            "Kwami",
            "Nafada",
            "Shongom",
            "Yamaltu\/Deba"
          ]
        },
        {
          "state": "Imo",
          "lgas": [
            "Aboh-Mbaise",
            "Ahiazu-Mbaise",
            "Ehime-Mbano",
            "Ezinihitte",
            "Ideato-North",
            "Ideato-South",
            "Ihitte\/Uboma",
            "Ikeduru",
            "Isiala-Mbano",
            "Isu",
            "Mbaitoli",
            "Ngor-Okpala",
            "Njaba",
            "Nkwerre",
            "Nwangele",
            "Obowo",
            "Oguta",
            "Ohaji-Egbema",
            "Okigwe",
            "Onuimo",
            "Orlu",
            "Orsu",
            "Oru-East",
            "Oru-West",
            "Owerri-Municipal",
            "Owerri-North",
            "Owerri-West"
          ]
        },
        {
          "state": "Jigawa",
          "lgas": [
            "Auyo",
            "Babura",
            "Biriniwa",
            "Birnin-Kudu",
            "Buji",
            "Dutse",
            "Gagarawa",
            "Garki",
            "Gumel",
            "Guri",
            "Gwaram",
            "Gwiwa",
            "Hadejia",
            "Jahun",
            "Kafin-Hausa",
            "Kaugama",
            "Kazaure",
            "Kiri kasama",
            "Maigatari",
            "Malam Madori",
            "Miga",
            "Ringim",
            "Roni",
            "Sule-Tankarkar",
            "Taura",
            "Yankwashi"
          ]
        },
        {
          "state": "Kebbi",
          "lgas": [
            "Aleiro",
            "Arewa-Dandi",
            "Argungu",
            "Augie",
            "Bagudo",
            "Birnin-Kebbi",
            "Bunza",
            "Dandi",
            "Fakai",
            "Gwandu",
            "Jega",
            "Kalgo",
            "Koko-Besse",
            "Maiyama",
            "Ngaski",
            "Sakaba",
            "Shanga",
            "Suru",
            "Wasagu/Danko",
            "Yauri",
            "Zuru"
          ]
        },
        {
          "state": "Kaduna",
          "lgas": [
            "Birnin-Gwari",
            "Chikun",
            "Giwa",
            "Igabi",
            "Ikara",
            "Jaba",
            "Jema'A",
            "Kachia",
            "Kaduna-North",
            "Kaduna-South",
            "Kagarko",
            "Kajuru",
            "Kaura",
            "Kauru",
            "Kubau",
            "Kudan",
            "Lere",
            "Makarfi",
            "Sabon-Gari",
            "Sanga",
            "Soba",
            "Zangon-Kataf",
            "Zaria"
          ]
        },
        {
          "state": "Kano",
          "lgas": [
            "Ajingi",
            "Albasu",
            "Bagwai",
            "Bebeji",
            "Bichi",
            "Bunkure",
            "Dala",
            "Dambatta",
            "Dawakin-Kudu",
            "Dawakin-Tofa",
            "Doguwa",
            "Fagge",
            "Gabasawa",
            "Garko",
            "Garun-Mallam",
            "Gaya",
            "Gezawa",
            "Gwale",
            "Gwarzo",
            "Kabo",
            "Kano-Municipal",
            "Karaye",
            "Kibiya",
            "Kiru",
            "Kumbotso",
            "Kunchi",
            "Kura",
            "Madobi",
            "Makoda",
            "Minjibir",
            "Nasarawa",
            "Rano",
            "Rimin-Gado",
            "Rogo",
            "Shanono",
            "Sumaila",
            "Takai",
            "Tarauni",
            "Tofa",
            "Tsanyawa",
            "Tudun-Wada",
            "Ungogo",
            "Warawa",
            "Wudil"
          ]
        },
        {
          "state": "Kogi",
          "lgas": [
            "Adavi",
            "Ajaokuta",
            "Ankpa",
            "Dekina",
            "Ibaji",
            "Idah",
            "Igalamela-Odolu",
            "Ijumu",
            "Kabba\/Bunu",
            "Kogi",
            "Lokoja",
            "Mopa-Muro",
            "Ofu",
            "Ogori\/Magongo",
            "Okehi",
            "Okene",
            "Olamaboro",
            "Omala",
            "Oyi",
            "Yagba-East",
            "Yagba-West"
          ]
        },
        {
          "state": "Katsina",
          "lgas": [
            "Bakori",
            "Batagarawa",
            "Batsari",
            "Baure",
            "Bindawa",
            "Charanchi",
            "Dan-Musa",
            "Dandume",
            "Danja",
            "Daura",
            "Dutsi",
            "Dutsin-Ma",
            "Faskari",
            "Funtua",
            "Ingawa",
            "Jibia",
            "Kafur",
            "Kaita",
            "Kankara",
            "Kankia",
            "Katsina",
            "Kurfi",
            "Kusada",
            "Mai-Adua",
            "Malumfashi",
            "Mani",
            "Mashi",
            "Matazu",
            "Musawa",
            "Rimi",
            "Sabuwa",
            "Safana",
            "Sandamu",
            "Zango"
          ]
        },
        {
          "state": "Kwara",
          "lgas": [
            "Asa",
            "Baruten",
            "Edu",
            "Ekiti (Araromi/Opin)",
            "Ilorin-East",
            "Ilorin-South",
            "Ilorin-West",
            "Isin",
            "Kaiama",
            "Moro",
            "Offa",
            "Oke-Ero",
            "Oyun",
            "Pategi"
          ]
        },
        {
          "state": "Lagos",
          "lgas": [
            "Agege",
            "Ajeromi-Ifelodun",
            "Alimosho",
            "Amuwo-Odofin",
            "Apapa",
            "Badagry",
            "Epe",
            "Eti-Osa",
            "Ibeju-Lekki",
            "Ifako-Ijaiye",
            "Ikeja",
            "Ikorodu",
            "Kosofe",
            "Lagos-Island",
            "Lagos-Mainland",
            "Mushin",
            "Ojo",
            "Oshodi-Isolo",
            "Shomolu",
            "Surulere",
            "Yewa-South"
          ]
        },
        {
          "state": "Nasarawa",
          "lgas": [
            "Akwanga",
            "Awe",
            "Doma",
            "Karu",
            "Keana",
            "Keffi",
            "Kokona",
            "Lafia",
            "Nasarawa",
            "Nasarawa-Eggon",
            "Obi",
            "Wamba",
            "Toto"
          ]
        },
        {
          "state": "Niger",
          "lgas": [
            "Agaie",
            "Agwara",
            "Bida",
            "Borgu",
            "Bosso",
            "Chanchaga",
            "Edati",
            "Gbako",
            "Gurara",
            "Katcha",
            "Kontagora",
            "Lapai",
            "Lavun",
            "Magama",
            "Mariga",
            "Mashegu",
            "Mokwa",
            "Moya",
            "Paikoro",
            "Rafi",
            "Rijau",
            "Shiroro",
            "Suleja",
            "Tafa",
            "Wushishi"
          ]
        },
        {
          "state": "Ogun",
          "lgas": [
            "Abeokuta-North",
            "Abeokuta-South",
            "Ado-Odo\/Ota",
            "Ewekoro",
            "Ifo",
            "Ijebu-East",
            "Ijebu-North",
            "Ijebu-North-East",
            "Ijebu-Ode",
            "Ikenne",
            "Imeko-Afon",
            "Ipokia",
            "Obafemi-Owode",
            "Odeda",
            "Odogbolu",
            "Ogun-Waterside",
            "Remo-North",
            "Shagamu",
            "Yewa North"
          ]
        },
        {
          "state": "Ondo",
          "lgas": [
            "Akoko North-East",
            "Akoko North-West",
            "Akoko South-West",
            "Akoko South-East",
            "Akure-North",
            "Akure-South",
            "Ese-Odo",
            "Idanre",
            "Ifedore",
            "Ilaje",
            "Ile-Oluji-Okeigbo",
            "Irele",
            "Odigbo",
            "Okitipupa",
            "Ondo West",
            "Ondo-East",
            "Ose",
            "Owo"
          ]
        },
        {
          "state": "Osun",
          "lgas": [
            "Atakumosa West",
            "Atakumosa East",
            "Ayedaade",
            "Ayedire",
            "Boluwaduro",
            "Boripe",
            "Ede South",
            "Ede North",
            "Egbedore",
            "Ejigbo",
            "Ife North",
            "Ife South",
            "Ife-Central",
            "Ife-East",
            "Ifelodun",
            "Ila",
            "Ilesa-East",
            "Ilesa-West",
            "Irepodun",
            "Irewole",
            "Isokan",
            "Iwo",
            "Obokun",
            "Odo-Otin",
            "Ola Oluwa",
            "Olorunda",
            "Oriade",
            "Orolu",
            "Osogbo"
          ]
        },
        {
          "state": "Oyo",
          "lgas": [
            "Afijio",
            "Akinyele",
            "Atiba",
            "Atisbo",
            "Egbeda",
            "Ibadan North",
            "Ibadan North-East",
            "Ibadan North-West",
            "Ibadan South-East",
            "Ibadan South-West",
            "Ibarapa-Central",
            "Ibarapa-East",
            "Ibarapa-North",
            "Ido",
            "Ifedayo",
            "Irepo",
            "Iseyin",
            "Itesiwaju",
            "Iwajowa",
            "Kajola",
            "Lagelu",
            "Ogo-Oluwa",
            "Ogbomosho-North",
            "Ogbomosho-South",
            "Olorunsogo",
            "Oluyole",
            "Ona-Ara",
            "Orelope",
            "Ori-Ire",
            "Oyo-West",
            "Oyo-East",
            "Saki-East",
            "Saki-West",
            "Surulere"
          ]
        },
        {
          "state": "Plateau",
          "lgas": [
            "Barkin-Ladi",
            "Bassa",
            "Bokkos",
            "Jos-East",
            "Jos-North",
            "Jos-South",
            "Kanam",
            "Kanke",
            "Langtang-North",
            "Langtang-South",
            "Mangu",
            "Mikang",
            "Pankshin",
            "Qua'an Pan",
            "Riyom",
            "Shendam",
            "Wase"
          ]
        },
        {
          "state": "Rivers",
          "lgas": [
            "Abua\/Odual",
            "Ahoada-East",
            "Ahoada-West",
            "Akuku Toru",
            "Andoni",
            "Asari-Toru",
            "Bonny",
            "Degema",
            "Eleme",
            "Emuoha",
            "Etche",
            "Gokana",
            "Ikwerre",
            "Khana",
            "Obio\/Akpor",
            "Ogba-Egbema-Ndoni",
            "Ogba\/Egbema\/Ndoni",
            "Ogu\/Bolo",
            "Okrika",
            "Omuma",
            "Opobo\/Nkoro",
            "Oyigbo",
            "Port-Harcourt",
            "Tai"
          ]
        },
        {
          "state": "Sokoto",
          "lgas": [
            "Binji",
            "Bodinga",
            "Dange-Shuni",
            "Gada",
            "Goronyo",
            "Gudu",
            "Gwadabawa",
            "Illela",
            "Kebbe",
            "Kware",
            "Rabah",
            "Sabon Birni",
            "Shagari",
            "Silame",
            "Sokoto-North",
            "Sokoto-South",
            "Tambuwal",
            "Tangaza",
            "Tureta",
            "Wamako",
            "Wurno",
            "Yabo"
          ]
        },
        {
          "state": "Taraba",
          "lgas": [
            "Ardo-Kola",
            "Bali",
            "Donga",
            "Gashaka",
            "Gassol",
            "Ibi",
            "Jalingo",
            "Karim-Lamido",
            "Kurmi",
            "Lau",
            "Sardauna",
            "Takum",
            "Ussa",
            "Wukari",
            "Yorro",
            "Zing"
          ]
        },
        {
          "state": "Yobe",
          "lgas": [
            "Bade",
            "Bursari",
            "Damaturu",
            "Fika",
            "Fune",
            "Geidam",
            "Gujba",
            "Gulani",
            "Jakusko",
            "Karasuwa",
            "Machina",
            "Nangere",
            "Nguru",
            "Potiskum",
            "Tarmuwa",
            "Yunusari",
            "Yusufari"
          ]
        },
        {
          "state": "Zamfara",
          "lgas": [
            "Anka",
            "Bakura",
            "Birnin Magaji/Kiyaw",
            "Bukkuyum",
            "Bungudu",
            "Gummi",
            "Gusau",
            "Isa",
            "Kaura-Namoda",
            "Kiyawa",
            "Maradun",
            "Maru",
            "Shinkafi",
            "Talata-Mafara",
            "Tsafe",
            "Zurmi"
          ]
        }
      ];

      //print("GET States Response: $statesMap");

      List<States> list = <States>[];
      list = parseStates(json.encode(statesLgs));

      print("List length: ${list.length}");

      return list;
    } catch (e) {
      print("Error occured: $e");
      return <States>[];
    }
  }

  static Future<List<Errand>> getUserErrands(String userId) async {
    var map = <String, dynamic>{};
    map['action'] = _GET_USER_PICKUPS;
    map['userId'] = userId;
    final response = await http.post(Uri.parse(ROOT), body: map);
    print("GET USER-ERRAND response >> ${response.body}");
    if (response.statusCode == 200) {
      List<Errand> list = <Errand>[];
      list = parseErrands(response.body);
      return list;
    } else {
      return <Errand>[];
    }
  }

  static Future<List<HErrand>> getUserHErrands(String userId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_USER_HOUSEERRANDS;
      map['userId'] = userId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        var list = parseHErrands(response.body);
        return list;
      } else {
        return <HErrand>[];
      }
    } catch (e) {
      return <HErrand>[];
    }
  }

  static List<EService> parseService(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<EService>((json) => EService.fromJson(json)).toList();
  }

  static List<States> parseStates(String statesMap) {
    final parsed = jsonDecode(statesMap);
    return parsed.map<States>((json) => States.fromJson(json)).toList();
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static List<Errand> parseErrands(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<Errand>((json) => Errand.fromJson(json)).toList();
  }

  static List<HErrand> parseHErrands(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<HErrand>((json) => HErrand.fromJson(json)).toList();
  }
}
