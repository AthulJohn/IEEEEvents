import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:design/functions.dart';
import 'dart:math';
//import 'package:flutter/cupertino.dart';
///import 'storage.dart';
import 'package:path/path.dart' as Path;
//import 'classes.dart';

class CloudService {
  final String index;
  CloudService({this.index});

  final CollectionReference eventCollection =
      Firestore.instance.collection('events');

  Future updateDate(String name, DateTime udate) async {
    return await eventCollection.document(name).updateData({'update': udate});
  }

  Future updateData(String name, String desc, DateTime cdate, DateTime udate,
      int ind, List image) async {
    List images = [];
    if (image != null) images = await uploadFile(name, image);
    await eventCollection.document(name).setData({
      'name': name,
      'desc': desc,
      'create': cdate,
      'update': udate,
      'index': ind,
      'theme': images[0],
    });
    if (getl(image) != 0) {
      for (int i = 0; i < images.length; i++) {
        await eventCollection
            .document(name)
            .collection('images')
            .document('$i')
            .setData({'url': images[i]});
        await eventCollection
            .document(name)
            .collection('imagepath')
            .document('$i')
            .setData({'path': '$name/$i'});
      }
    }
    return;
  }

  Future updatepics(String name, File img, int inde) async {
    String url;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('$inde');
    StorageUploadTask uploadTask = storageReference.putFile(img);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
    await eventCollection
        .document(name)
        .collection('imagepath')
        .document('$inde')
        .setData({'path': '$name/$inde'});
    await eventCollection
        .document(name)
        .collection('images')
        .document('$inde')
        .setData({'url': url});
  }

  // void removeimage(){

  // }

  Future editData(Event event, List activities) async {
    await eventCollection.document(event.name).updateData({
      'desc': event.desc,
      'update': DateTime.now(),
      'active': event.active,
    });
    for (Event i in activities) {
      await eventCollection
          .document(index)
          .collection('activity')
          .document(i.name)
          .updateData({
        'name': i.name,
        'desc': i.desc,
      });
    }
    return;
  }

  Future updateactivity(String name, String desc, DateTime cdate, int acindex,
      DateTime dt) async {
    return await eventCollection
        .document(index)
        .collection('activity')
        .document(name)
        .setData({
      'name': name,
      'desc': desc,
      'create': cdate,
      'index': acindex,
      'activitydate': dt,
      'active': 1
    });
  }

  List<Event> _listfromsnap(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
          doc.data['index'] ?? 0,
          doc.data['name'] ?? '',
          doc.data['desc'] ?? '',
          doc.data['create'].toDate() ?? DateTime.now(),
          doc.data['update'].toDate() ?? DateTime.now(),
          doc.data['theme'], []);
    }).toList();
  }

  List<Event> _listfromact(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
          doc.data['index'] ?? 0,
          doc.data['name'] ?? '',
          doc.data['desc'] ?? '',
          doc.data['create'].toDate() ?? DateTime.now(),
          doc.data['activitydate'].toDate() ?? DateTime.now(),
          '',
          [],
          active: doc.data['active'] ?? 0);
    }).toList();
  }

  List<String> _listfromimg(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return doc.data['url'].toString();
    }).toList();
  }

  Future delet(String nm) async {
    // await Firestore.instance.runTransaction((Transaction myTransaction) async{
    //   await myTransaction.delete(snapshot.data.documents[nm].reference);
    //});
    await eventCollection
        .document(nm)
        .collection('activity')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    await eventCollection
        .document(nm)
        .collection('images')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    await eventCollection
        .document(nm)
        .collection('imagepath')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        FirebaseStorage.instance.ref().child(ds.data['path']).delete();
        ds.reference.delete();
      }
    });

    //await pathh(nm);
    // await FirebaseStorage.instance.ref().child('$nm/').delete();
    await eventCollection.document(nm).delete();
  }

  void acdele(String nm, String ac) async {
    // await Firestore.instance.runTransaction((Transaction myTransaction) async{
    //   await myTransaction.delete(snapshot.data.documents[nm].reference);
    //});

    await eventCollection
        .document(nm)
        .collection('activity')
        .document(ac)
        .delete();
  }

  Stream<List<Event>> get events {
    return eventCollection.snapshots().map(_listfromsnap);
  }

  Stream<List<Event>> acts(String index) {
    return eventCollection
        .document(index)
        .collection('activity')
        .snapshots()
        .map(_listfromact);
  }

  Stream<List<String>> img(String ind) {
    return eventCollection
        .document(ind)
        .collection('images')
        .snapshots()
        .map(_listfromimg);
  }

  List defaultim = [
    '338221',
    '748344',
    '748346',
    '748355',
    '748358',
    '748371',
    '748389',
    '748443'
  ];
  Future<List> uploadFile(String name, List image) async {
    String url;
    List images = [];
    if (getl(image) == 0) {
      Random random = Random();
      images.add(await FirebaseStorage.instance
          .ref()
          .child('default images/${defaultim[random.nextInt(8)]}.jpg')
          .getDownloadURL());
    } else {
      for (File f in image) {
        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child('$name/${Path.basename(f.path)}');
        StorageUploadTask uploadTask = storageReference.putFile(f);
        await uploadTask.onComplete;
        url = await storageReference.getDownloadURL();
        images.add(url);
      }
    }
    return images;
  }
//  Future<List<String>> getImage(BuildContext context, Event event) async {
//    int i;
//    String ext='jpg';
//    final ref = FirebaseStorage.instance
//     .ref()
//     .child(event.name).child('${i++}.$ext');
//     for(var i in ref)
//     ref.putFile(imageFile);
// // or ref.putData(Uint8List.fromList(imageData));

// var url = await ref.getDownloadURL() as String;
// }
}