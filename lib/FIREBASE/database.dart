import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:design/functions.dart';
import 'dart:math';
import 'package:path/path.dart' as Path;
// import 'package:path_provider/path_provider.dart' as path_provider;

class CloudService {
  final String index;
  CloudService({this.index});

  final CollectionReference eventCollection =
      Firestore.instance.collection('events');

  Future updateDate(String name, DateTime udate, int ind) async {
    return await eventCollection.document(name).updateData(
        {'update': udate.toIso8601String(), 'done': 1, 'lastind': ind});
  }

  Future updateData(String name, String desc, DateTime cdate, DateTime udate,
      int ind, List image, bool mace) async {
    List images = [];
    if (image != null) images = await uploadFile(name, image);
    await eventCollection.document(name).setData({
      'name': name,
      'desc': desc,
      'create': cdate.toIso8601String(),
      'update': udate.toIso8601String(),
      'index': ind,
      'theme': images[0],
      'active': 1,
      'done': 0,
      'lastind': 0,
      'mace': mace
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
            .setData({'path': '$name/${Path.basename(image[i].path)}'});
      }
    }
    return;
  }

  Future editData(
      Event event, List activities, List added, List removed) async {
    int len = 0;
    String theme = event.theme;
    List imgs = [];

    if (getl(removed) > 0) {
      final paths = await eventCollection
          .document(event.name)
          .collection('imagepath')
          .getDocuments();
      if (getl(removed) != 0)
        for (int i = 0; i < paths.documents.length; i++) {
          if (removed.contains(i)) {
            len++;
            await FirebaseStorage.instance
                .ref()
                .child('${paths.documents[i].data['path']}')
                .delete();
            await eventCollection
                .document(event.name)
                .collection('imagepath')
                .document('$i')
                .delete();
            await eventCollection
                .document(event.name)
                .collection('images')
                .document('$i')
                .delete();
          }
        }
    }
    final paths = await eventCollection
        .document(event.name)
        .collection('imagepath')
        .getDocuments();
    len = paths.documents.length - len;
    if (len == 0) theme = '!';
    if (getl(added) > 0 || len == 0) {
      //}
      //if (len == 0 || (len != 0 && getl(added) != 0)) {
      imgs = await uploadFile(event.name, added);
      //if (len != 0 || getl(added) != 0) {
      for (int i = 0; i < imgs.length; i++) {
        await eventCollection
            .document(event.name)
            .collection('images')
            .document('${len + i}')
            .setData({'url': imgs[i]});
        await eventCollection
            .document(event.name)
            .collection('imagepath')
            .document('${i + len}')
            .setData({'path': '${event.name}/${Path.basename(added[i].path)}'});
      }
    }
    if (len == 0 || theme == '!') theme = imgs[0];
    await eventCollection.document(event.name).updateData({
      'theme': theme,
      'desc': event.desc,
      'update': DateTime.now().toIso8601String(),
      'active': event.active,
    });
    for (Event i in activities) {
      await eventCollection
          .document(event.name)
          .collection('activity')
          .document('${i.index}')
          .updateData({
        'name': i.name,
        'desc': i.desc,
        'activitydate': i.updatedate.toIso8601String(),
      });
    }
    return;
  }

  Future updateactivity(String name, String desc, DateTime cdate, int acindex,
      DateTime dt) async {
    return await eventCollection
        .document(index)
        .collection('activity')
        .document('$acindex')
        .setData({
      'name': name,
      'desc': desc,
      'create': cdate.toIso8601String(),
      'index': acindex,
      'activitydate': dt.toIso8601String(),
    });
  }

  // List<Event> _listfromsnap(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Event(
  //       doc.data['index'] ?? 0,
  //       doc.data['name'] ?? '',
  //       doc.data['desc'] ?? '',
  //       doc.data['create'].toDate() ?? DateTime.now(),
  //       doc.data['update'].toDate() ?? DateTime.now(),
  //       doc.data['theme'],
  //       [],
  //       doc.data['lastind'],
  //       active: doc.data['active'],
  //       done: doc.data['done'],
  //       mace: doc.data['mace'],
  //     );
  //   }).toList();
  // }

  // List<Event> _listfromact(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Event(
  //         doc.data['index'] ?? 0,
  //         doc.data['name'] ?? '',
  //         doc.data['desc'] ?? '',
  //         doc.data['create'].toDate() ?? DateTime.now(),
  //         doc.data['activitydate'].toDate() ?? DateTime.now(),
  //         '',
  //         [],
  //         0);
  //   }).toList();
  // }

  Future delet(String nm) async {
    await eventCollection
        .document(nm)
        .collection('activity')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    var stat = await eventCollection
        .document(nm)
        .collection('imagepath')
        .document('0')
        .get();
    if (stat.exists) {
      await eventCollection
          .document(nm)
          .collection('images')
          .getDocuments()
          .then((snapshot) async {
        for (DocumentSnapshot ds in snapshot.documents) {
          await ds.reference.delete();
        }
      });
      await eventCollection
          .document(nm)
          .collection('imagepath')
          .getDocuments()
          .then((snapshot) async {
        for (DocumentSnapshot ds in snapshot.documents) {
          await FirebaseStorage.instance.ref().child(ds.data['path']).delete();
          await ds.reference.delete();
        }
      });
    }
    await eventCollection.document(nm).delete();
  }

  Future acdele(String nm, int ac, int done) async {
    await eventCollection
        .document(nm)
        .collection('activity')
        .document('$ac')
        .delete();
  }

  // Stream<List<Event>> get events {
  //   return eventCollection.snapshots().map(_listfromsnap);
  // }

  // Stream<List<Event>> acts(String index) {
  //   return eventCollection
  //       .document(index)
  //       .collection('activity')
  //       .snapshots()
  //       .map(_listfromact);
  // }

  Future<List<Event>> getevents() async {
    List<Event> events = [];
    final shots = await eventCollection.getDocuments();
    for (var i in shots.documents) {
      events.add(Event(
        i.data['index'] ?? 0,
        i.data['name'] ?? '',
        i.data['desc'] ?? '',
        DateTime.parse(i.data['create']) ?? DateTime.now(),
        DateTime.parse(i.data['update']) ?? DateTime.now(),
        i.data['theme'],
        [],
        i.data['lastind'],
        active: i.data['active'],
        done: i.data['done'],
        mace: i.data['mace'],
      ));
    }
    return events;
  }

  Future<List<Event>> getactivities(String name) async {
    List<Event> activities = [];
    final shots = await eventCollection
        .document(name)
        .collection('activity')
        .getDocuments();
    for (var doc in shots.documents) {
      activities.add(Event(
          doc.data['index'] ?? 0,
          doc.data['name'] ?? '',
          doc.data['desc'] ?? '',
          DateTime.parse(doc.data['create']) ?? DateTime.now(),
          DateTime.parse(doc.data['activitydate']) ?? DateTime.now(),
          '',
          [],
          0));
    }
    return activities;
  }

  Future<List<String>> getimage(String name) async {
    List<String> images = [];
    DocumentSnapshot sta = await eventCollection
        .document(name)
        .collection('images')
        .document('0')
        .get();
    if (sta.exists) {
      final shots = await eventCollection
          .document(name)
          .collection('images')
          .getDocuments();
      for (var i in shots.documents) {
        images.add(i.data['url']);
      }
    }
    return images;
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
        // final dir = await path_provider.getTemporaryDirectory();
        // final targetPath = dir.absolute.path + "/temp.jpg";
        // var result = await FlutterImageCompress.compressAndGetFile(
        //   f.absolute.path,
        //   targetPath,
        //   quality: 88,
        // );

        // print(f.lengthSync());
        // print(result.lengthSync());
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
}
