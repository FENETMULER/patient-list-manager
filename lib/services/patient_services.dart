import 'package:mongo_dart/mongo_dart.dart';

import '../constants/connection.dart';
import '../models/patient.dart';

var db = Db(connectionString);

void connectDb() async {
  await db.open();
}

var coll = db.collection('patients');

void dbRegisterPatient(Map<String, dynamic> patientMap) async {
  var res = await coll.insertOne(patientMap).toString();
  print(res);
}
