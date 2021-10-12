import 'package:up_the_shelf/src/utils/services/firestore_service.dart';

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _firestoreService = FirestoreService.instance;
}
