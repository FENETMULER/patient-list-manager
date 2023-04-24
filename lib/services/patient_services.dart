import 'package:mongo_dart/mongo_dart.dart';

import '../constants/connection.dart';
import '../models/patient.dart';

var db = Db(connectionString);

Future<dynamic> connectDb() async {
  try {
    await db.open();
  } catch (e) {
    return Future.error("Couldn't Connect to Database");
  }
}

var coll = db.collection('patients');

Future<dynamic> dbRegisterPatient(Map<String, dynamic> patientMap) async {
  try {
    await coll.insertOne(patientMap);
  } catch (e) {
    throw Exception("Couldn't Register Patient");
  }
}

Future<List<Map<String, dynamic>>> dbGetRecentPatients() async {
  try {
    return await coll
        .find(where.sortBy('registeredOn', descending: true).limit(5))
        .toList();
  } catch (e) {
    return Future.error("Couldn't Load Recent Patients");
  }
}

Future<void> dbDeletePatient(id) async {
  try {
    await coll.deleteOne(where.eq('_id', id));
  } catch (e) {
    throw Exception("Couldn't Delete Record");
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
    throw Exception("Couldn't Update Record");
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
      },
      {
        r'$sort': {
          'registeredOn': -1,
        }
      }
    ]).toList();
  } catch (e) {
    if (searchQuery.isEmpty) {
      return Future.error("Couldn't Load Records");
    }
    return Future.error("Couldn't Get Search Results");
  }
}
