import 'package:cloud_firestore/cloud_firestore.dart';
class BookRepository {
final FirebaseFirestore _firestore;
 BookRepository(this._firestore);
 Stream<QuerySnapshot> getBooks() {
  return _firestore.collection('books').snapshots();
}
}
