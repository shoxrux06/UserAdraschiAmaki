import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../core/data/models/locale_product.dart';

class DbManager {
  Database? _database = null;

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "cartItems.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE myCart (productId INTEGER, image TEXT, quantity INTEGER, productName TEXT, totalSum INTEGER, price TEXT)",
          );
        });
    return _database;
  }

  clearCartTable() async {
    final allProducts = await DbManager().getDataList();
    for (var element in allProducts) {
      await DbManager().deleteData(element);
    }
  }
  Future<int?> insertData(LocaleProduct model) async {
    await openDb();
    int? a= await _database?.insert('myCart', model.toJson());
    return a;
  }

  Future<List<LocaleProduct>> getDataList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.rawQuery('SELECT * FROM myCart');

    return List.generate(maps.length, (i) {
      return LocaleProduct(
        productId: maps[i]['productId'],
        image: maps[i]['image'],
        quantity: maps[i]['quantity'],
        productName: maps[i]['productName'],
        totalSum: maps[i]['totalSum'],
        price: maps[i]['price'],
      );
    });
  }

  Future<int> updateData(LocaleProduct model) async {
    await openDb();
    return await _database!.update('myCart', model.toJson(), where: "productId = ?", whereArgs: [model.productId]);
  }

  Future<void> deleteData(LocaleProduct model) async {
    await openDb();
    await _database!.delete('myCart', where: "productId = ?", whereArgs: [model.productId]);
  }
}