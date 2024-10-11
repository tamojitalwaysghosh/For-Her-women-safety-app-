//The path plugin is a cross-platform path manipulation library for Dart,
//and it helps to specify the location of the file that contains the database.
import 'package:fast_contacts/fast_contacts.dart';
import 'package:for_her_app/model/Fav_contact/fav_contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  //A static variable to hold the reference to the SQLite database instance.
  static Database? _database;
  //The name of the database file.
  static final _databaseName = "my_contacts.db";
  //The version of the database.
  //The _databaseVersion variable is used to indicate the version of the database schema.
  static final _databaseVersion = 1;

  //This getter(In this case, it's a getter named database) returns the SQLite database instance.
  //If _database is already initialized, it returns the existing instance.
  //If not, it initializes the database by calling _initDatabase.
  //The Future indicates that the value returned by this getter will be computed asynchronously.
  //The return type of the getter is declared as Future<Database>.
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  //This private function initializes and opens the database.
  static _initDatabase() async {
    //gets the default database location.
    //getDatabasesPath() function, which returns the default path for storing databases on the device's file system.
    final _databasePath = await getDatabasesPath();
    //the join() function sets the path of the database.
    //join function to combine the retrieved database path with the specific database name (_databaseName), creating a complete path to the database file.
    String path = join(_databasePath, _databaseName);
    //openDatabase function, which is crucial for establishing a connection to the database
    //opens if databse exists
    //creates if doesnot exists
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //This callback is called when the database is created for the first time.
  //It creates a table named FavContacts with columns for contact information.
  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE FavContacts(
        id TEXT PRIMARY KEY,
        userName TEXT,
        userPhoneNumbers TEXT,
        userImage BLOB
      )
    ''');
  }

  //This function saves a contact to the FavContacts table in the database.
  //It retrieves the contact image using FastContacts.getContactImage.
  //Inserts the contact details into the database.
  static Future<void> saveContact(Contact contact) async {
    final db = await database;
    final imageBytes = await FastContacts.getContactImage(contact.id);
    await db.insert(
        //table
        'FavContacts',
        //values
        {
          'id': contact.id,
          'userName': contact.displayName,
          'userPhoneNumbers': contact.phones.map((e) => e.number).join(', '),
          'userImage': imageBytes,
        });
  }

  //This function retrieves all favorite contacts from the FavContacts table.
  //It maps the database records to FavContact objects.
  static Future<List<FavContact>> getFavContacts() async {
    final db = await database;
    //query: This method is used to perform a SELECT query on the specified table ('FavContacts').
    //It takes the table name as its argument and returns a Future<List<Map<String, dynamic>>>.
    final List<Map<String, dynamic>> maps = await db.query('FavContacts');
    return List.generate(maps.length, (index) {
      return FavContact(
        id: maps[index]['id'],
        displayName: maps[index]['userName'],
        phoneNumbers: maps[index]['userPhoneNumbers'],
        image: maps[index]['userImage'],
      );
    });
  }

  //This function checks if a contact with a given contactId is already in the favorites.
  static Future<bool> isContactFav(String contactId) async {
    final db = await database;
    //The whereArgs parameter is used to pass the actual values for the placeholders in the where clause to prevent SQL injection.
    final result =
        await db.query('FavContacts', where: 'id = ?', whereArgs: [contactId]);
    return result.isNotEmpty;
  }

  //This function deletes a contact from the favorites based on the contactId.
  static Future<void> deleteContact(String contactId) async {
    final db = await database;
    await db.delete('FavContacts', where: 'id = ?', whereArgs: [contactId]);
  }
}
