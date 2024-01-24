import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Add a document to a collection
  Future<void> addData(String collectionName, Map<String, dynamic> data) async {
    try {
      await _fireStore.collection(collectionName).add(data);
      debugPrint("Document added successfully!");
    } catch (e) {
      debugPrint("Error adding document: $e");
    }
  }

  Future<void> addDataIn(
      String collectionName, String docName, Map<String, dynamic> data) async {
    try {
      await _fireStore.collection(collectionName).doc(docName).set(data);
      debugPrint("Document added successfully!");
    } catch (e) {
      debugPrint("Error adding document: $e");
    }
  }

  // Update a document in a collection
  Future<void> updateData(String collectionName, String documentId,
      Map<String, dynamic> data) async {
    try {
      await _fireStore.collection(collectionName).doc(documentId).update(data);
      debugPrint("Document updated successfully!");
    } catch (e) {
      debugPrint("Error updating document: $e");
    }
  }

  // Get a document by ID from a collection
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentById(
      String collectionName, String documentId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _fireStore.collection(collectionName).doc(documentId).get();

      return documentSnapshot;
    } catch (e) {
      debugPrint("Error getting document by ID: $e");
      throw e;
    }
  }

  Future<void> getCollectionById(String collectionName) async {
    try {
      final documentSnapshot =
          await _fireStore.collection(collectionName).get();
      documentSnapshot.docs.forEach((element) {
        debugPrint(element["name"]);
      });
    } catch (e) {
      debugPrint("Error getting document by ID: $e");
      throw e;
    }
  }

  // Query documents in a collection based on a field
  Future<QuerySnapshot> queryData(
      String collectionName, String fieldName, dynamic value) async {
    try {
      QuerySnapshot querySnapshot = await _fireStore
          .collection(collectionName)
          .where(fieldName, isEqualTo: value)
          .get();
      return querySnapshot;
    } catch (e) {
      debugPrint("Error querying data: $e");
      throw e;
    }
  }

  // Delete a document from a collection
  Future<void> deleteData(String collectionName, String documentId) async {
    try {
      await _fireStore.collection(collectionName).doc(documentId).delete();
      debugPrint("Document deleted successfully!");
    } catch (e) {
      debugPrint("Error deleting document: $e");
    }
  }
}
