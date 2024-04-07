import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'hotels.db');

    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE hotels(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        harga INTEGER,
        rating REAL,
        tentang TEXT,
        imagePath TEXT
      )
    ''');
  }

  // Function untuk menambahkan data ke dalam tabel hotels
  Future<void> insertHotel(Map<String, dynamic> hotelData) async {
    final db = await this.db;
    await db?.insert('hotels', hotelData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Function untuk mendapatkan semua data dari tabel hotels
  Future<List<Map<String, dynamic>>> getAllHotels() async {
    final db = await this.db;
    return await db?.query('hotels') ?? [];
  }

  // Function untuk mengupdate data di dalam tabel hotels berdasarkan ID
  Future<void> updateHotel(Map<String, dynamic> hotelData, int hotelId) async {
    final db = await this.db;
    await db
        ?.update('hotels', hotelData, where: 'id = ?', whereArgs: [hotelId]);
  }

  // Function untuk menghapus data dari tabel hotels berdasarkan ID
  Future<void> deleteHotel(int hotelId) async {
    final db = await this.db;
    await db?.delete('hotels', where: 'id = ?', whereArgs: [hotelId]);
  }
}
