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
    return await coll
        .find(where.sortBy('registeredOn', descending: true).limit(5))
        .toList();
  } catch (e) {
    return Future.error('error');
  }
}

Future<void> dbDeletePatient(id) async {
  try {
    await coll.deleteOne(where.eq('_id', id));
  } catch (e) {
    return Future.error('error');
  }
}

Future<void> dbUpdatePatient(Patient patient) async {
  try {
    await coll.replaceOne(where.eq('_id', patient.id), {
      'firstName': patient.firstName,
      'lastName': patient.lastName,
      'age': patient.age,
      'sex': patient.sex,
      'phoneNumber': patient.phoneNumber,
      'houseNumber': patient.houseNumber,
      'district': patient.district,
      'subCity': patient.subCity,
      'diagnosis': patient.diagnosis,
      'registeredOn': patient.registeredOn,
    });
  } catch (e) {
    return Future.error('error');
  }
}

Future<List<Map<String, dynamic>>> dbGetSearchResults(
    String searchQuery) async {
  try {
    return await coll.aggregateToStream([
      {
        r'$set': {
          'nameAndNumber': {
            r'$concat': [r'$firstName', ' ', r'$lastName', ' ', r'$phoneNumber']
          }
        }
      },
      {
        r'$match': {
          'nameAndNumber': {r'$regex': searchQuery, r'$options': 'i'}
        }
      }
    ]).toList();
  } catch (e) {
    return Future.error('error');
  }
}
