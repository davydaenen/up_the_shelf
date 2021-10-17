import 'package:cloud_firestore/cloud_firestore.dart';

/*
This class represent all possible CRUD operation for FirebaseFirestore.
It contains all generic implementation needed based on the provided document
path and documentID,since most of the time in FirebaseFirestore design, we will have
documentID and path for any document and collections.
 */
class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Future<void> bulkSet({
    required String path,
    required List<Map<String, dynamic>> datas,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    final batchSet = FirebaseFirestore.instance.batch();
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(path);

    final Stream<QuerySnapshot> snapshots = collectionReference.snapshots();

    return snapshots.map((snapshot) {
      dynamic result;

      try {
        result = snapshot.docs
            .where((snapshot) => snapshot.data() != null)
            .map((snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
            .toList();
      } catch (_) {
        print(_);
      }

      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    final result = snapshots.map((snapshot) {
      return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
    });
    return result;
  }
}
