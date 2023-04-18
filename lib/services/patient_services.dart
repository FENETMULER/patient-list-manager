import 'package:mongo_dart/mongo_dart.dart';

import '../constants/connection.dart';
import '../models/patient.dart';

var db = Db(connectionString);

Future<void> connectDb() async {
  try {
    await db.open();
  } catch (e) {
    print(e);
  }
}

var coll = db.collection('patients');

Future<void> dbRegisterPatient(Map<String, dynamic> patientMap) async {
  await coll.insertOne(patientMap);
}

Future<List<Map<String, dynamic>>> dbGetAllPatients() async {
  try {
    var res = await coll
        .find(where.sortBy('registeredOn', descending: true))
        .toList();

    return res;
  } catch (e) {
    return Future.error('error');
  }
}

Future<List<Map<String, dynamic>>> dbGetRecentPatients() async {
  try {
    return coll
        .find(where.sortBy('registeredOn', descending: true).limit(5))
        .toList();
  } catch (e) {
    return Future.error('error');
  }
}
