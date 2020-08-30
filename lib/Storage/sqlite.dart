import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../functions.dart';

Database database;
Future<void> openLocalStorage() async {
// Open the database and store the reference.
  database = await openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'event_database.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE IF NOT EXISTS eventtable (id INTEGER, name TEXT PRIMARY KEY, desc TEXT, theme TEXT, active INTEGER, done INTEGER, createdate TEXT, updatedate TEXT, lastind INTEGER, mace INTEGER)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}

void closedb() async {
  await database.close();
}

Future<void> insertEvent(Event event) async {
  // Get a reference to the database.
  final Database db = database;
  db.execute(
    "CREATE TABLE IF NOT EXISTS " +
        event.name.replaceAll(' ', 'Þ') +
        " (id INTEGER PRIMARY KEY, name TEXT, desc TEXT, createdate TEXT, updatedate TEXT)",
  );
//   db.execute(
//     "CREATE TABLE IF NOT EXISTS apptheme (theme INTEGER)",
//   );
//  // await db.insert('apptheme', {'theme': 1});
  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'eventtable',
    event.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Future<int> getTheme() async {
//   List maps=await database.query('apptheme');
//   ['theme'];
// }

// Future<void> themeChange(int t) async {
//   final db = database;

//   await db.update(
//     'apptheme',
//     {'theme': t},
//   );
// }

Future<List<Event>> getEventsFromLocal() async {
  // Get a reference to the database.
  final Database db = database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('eventtable');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Event(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['desc'],
        DateTime.parse(maps[i]['createdate']),
        DateTime.parse(maps[i]['updatedate']),
        maps[i]['theme'],
        [],
        maps[i]['lastind'],
        active: maps[i]['active'],
        done: maps[i]['done'],
        mace: maps[i]['mace'] == 1 ? true : false);
  });
}

Future<void> updateEventtoLocal(Event event) async {
  // Get a reference to the database.
  final db = database;

  // Update the given Dog.
  await db.update(
    'eventtable',
    event.toMap(),
    // Ensure that the Dog has a matching id.
    where: "name = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [event.name],
  );
}

Future<void> deleteEventfromLocal(String name) async {
  // Get a reference to the database.
  final db = database;
  await db.delete(name);
  // Remove the Dog from the database.
  await db.delete(
    'eventtable',
    // Use a `where` clause to delete a specific dog.
    where: "name = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [name],
  );
}

void disposetheApp(List<Event> newEvents, List<Event> oldEvents) async {
  for (Event event in oldEvents) {
    if (!newEvents.contains(event)) {
      if (oldEvents.any((element) => element.name == event.name))
        await updateEventtoLocal(event);
      else
        await deleteEventfromLocal(event.name.replaceAll(' ', 'Þ'));
    }
  }
  for (Event event in newEvents) {
    if (!oldEvents.contains(event)) {
      await insertEvent(event);
    }
  }
}

Future<List<Event>> activitiesFromStorage(String name) async {
  final Database db = database;
  final List<Map<String, dynamic>> maps = await db.query(name);
  // Query the table for all The Dogs.
  // final List<Map<String, dynamic>> maps =
  //     await db.query(name.replaceAll(' ', 'Þ'));
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Event(
      maps[i]['id'],
      maps[i]['name'],
      maps[i]['desc'],
      DateTime.parse(maps[i]['createdate']),
      DateTime.parse(maps[i]['updatedate']),
      '',
      [],
      0,
    );
  });
}

Future<void> deleteActivityFromLocal(String table, int activity) async {
  final db = database;

  // Remove the Dog from the database.
  await db.delete(
    table,
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [activity],
  );
}

Future<void> insertActivityToLocal(String name, Event event) async {
  // Get a reference to the database.
  final Database db = database;
  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  // In this case, replace any previous data.
  await db.insert(
    name,
    {
      'id': event.index,
      'name': event.name,
      'desc': event.desc,
      'createdate': event.createdate.toIso8601String(),
      'updatedate': event.updatedate.toIso8601String(),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future disposeActivities(
    String name, List<Event> oldEvents, List<Event> newEvents) async {
  for (Event event in oldEvents) {
    if (!newEvents.contains(event)) {
      await deleteActivityFromLocal(name, event.index);
    }
  }
  for (Event event in newEvents) {
    if (!oldEvents.contains(event)) {
      await insertActivityToLocal(name, event);
    }
  }
}
