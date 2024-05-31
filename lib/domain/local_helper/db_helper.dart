import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rabble/core/config/export.dart';

class DBHelper {
  static final DBHelper dbHelper = DBHelper._();

  factory DBHelper() => dbHelper;

  DBHelper._();

  static Database? database;

  static const String dbName = 'rabble.db';
  static const int dbVersion = 10;

  static const String tableSearch = 'RecentSearch';
  static const String clmText = 'keyword';

  static const String tableCart = 'product';
  static const String clmProductId = 'productId';
  static const String clmProducerId = 'producerId';
  static const String clmProducerName = 'producerName';
  static const String clmProductType = 'type';
  static const String clmName = 'name';
  static const String clmDesc = 'description';
  static const String clmPrice = 'price';
  static const String clmQty = 'quantity';
  static const String clmProductImage = 'imageUrl';
  static const String clmRRP = 'rrp';
  static const String clmThresoldQty = 'thresholdQuantity';
  static const String clmTotalThresoldQty = 'totalThresholdQuantity';
  static const String clmUnitPerOrder = 'unitPerOrder';
  static const String clmOrderSubUnit = 'orderSubUnit';
  static const String clmOrderUnit = 'orderUnit';
  static const String clmUnitsOfMeasure = 'unitsOfMeasure';
  static const String clmPurchasedUserNames = 'purchasedUserNames';

  static const String tableProductsQuery =
      'CREATE TABLE $tableCart(id INTEGER PRIMARY KEY AUTOINCREMENT, $clmName '
      'TEXT, $clmDesc TEXT, '
      '$clmPrice INTEGER,$clmQty INTEGER, $clmProductId REAL, $clmProducerId TEXT, $clmProducerName TEXT, $clmProductType TEXT, $clmThresoldQty INTEGER,$clmTotalThresoldQty INTEGER, $clmUnitPerOrder INTEGER, $clmOrderSubUnit TEXT, $clmOrderUnit TEXT , $clmUnitsOfMeasure TEXT, $clmProductImage TEXT, $clmRRP INTEGER, $clmPurchasedUserNames TEXT)';

  static const String tableSearchQuery =
      'CREATE TABLE $tableSearch(id INTEGER PRIMARY KEY AUTOINCREMENT, $clmText '
      'TEXT )';

  Future<Database> get db async {
    if (database != null) {
      return database!;
    }
    database = await initDb();
    return database!;
  }

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);

    Future<Database> dbInit = openDatabase(path,
        version: dbVersion, onCreate: onCreate, onUpgrade: _onUpgrade);
    return dbInit;
  }

  onCreate(Database database, int version) async {
    await database.execute(tableProductsQuery);
    await database.execute(tableSearchQuery);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(tableSearchQuery);
      await db.execute(tableProductsQuery);
    }
  }

  Future<bool> addProductInCart(
      BuildContext context, ProductDetail productDetail) async {
    Database dbClient = await db;

    // Check if there's any item in the cart
    final List<Map<String, dynamic>> cartItems =
        await dbClient.query(tableCart);
    if (cartItems.isNotEmpty) {
      // If there are items, check if the new item's producer matches with existing items' producer
      if (cartItems[0][clmProducerId] != productDetail.producerId) {
        // If producers don't match, show a dialog to the user
        bool continueAdding = await globalBloc.productDeleteDialog(context);

        if (continueAdding) {
          // If user wants to continue adding, clear the cart
          await dbClient.delete(tableCart);

          // Then add the new item

          RabbleStorage().deleteKey(RabbleStorage().inivitationData);
          BuyingTeamCreationService().groupNameSubject$.sink.add('');

          int res = await dbClient.insert(
            tableCart,
            productDetail.toJson(),
          );

          return res != 0;
        } else {
          // If user doesn't want to continue, return false
          return false;
        }
      }
    }

    bool productExist = await checkProductExist(productDetail.id!);

    int res = 1;
    if (productExist) {
      updateProductQuantity(productDetail.id!, productDetail.qty!);
    } else {
      res = await dbClient.insert(
        tableCart,
        productDetail.toJson(),
      );
    }

    return res != 0;
  }

  Future close() async {
    Database dbClient = await db;
    dbClient.close();
  }

  Future<void> clearTeamData(String producerId) async {
    Database dbClient = await db;

    // Check if there's any item in the cart
    final List<Map<String, dynamic>> cartItems =
        await dbClient.query(tableCart);
    if (cartItems.isNotEmpty) {
      // If there are items, check if the new item's producer matches with existing items' producer
      if (cartItems[0][clmProducerId] != producerId) {
        await dbClient.delete(tableCart);
      }
    }
  }

  Future<bool> checkProducerMatched(String producerId) async {
    Database dbClient = await db;

    final List<Map<String, dynamic>> cartItems =
        await dbClient.query(tableCart);

    if (cartItems.isNotEmpty) {
      if (cartItems[0][clmProducerId] != producerId) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  Future<bool> checkProductExist(String productId) async {
    Database dbClient = await db;

    var result = await dbClient.rawQuery(
      'SELECT * FROM $tableCart WHERE $clmProductId = ?',
      ['$productId'],
    );

    print('result ${result.toString()}');
    if (result.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<List<ProductDetail>> getAllProducts() async {
    Database dbClient = await db;

    List<Map<String, dynamic>> result = await dbClient.query(tableCart);

    List<ProductDetail> productDetails = result.map((map) {
      return ProductDetail.fromDb(map);
    }).toList();

    return productDetails;
  }

  Future<List<ProductDetail>> getAllProductsWithOrderId(
      String orderId, String userId) async {
    Database dbClient = await db;

    List<Map<String, dynamic>> result = await dbClient.query(tableCart);

    List<ProductDetail> productDetails = result.map((map) {
      return ProductDetail.fromDbWithId(map, orderId, userId);
    }).toList();

    return productDetails;
  }

  Future<void> updateProductQuantity(String productId, int newQuantity) async {
    Database dbClient = await db;

    await dbClient.update(
      tableCart,
      {clmQty: newQuantity.toString()},
      where: '$clmProductId = ?',
      whereArgs: [productId],
    );

    return;
  }

  Future<void> updateThreshold(String productId, int newQuantity) async {
    Database dbClient = await db;

    await dbClient.update(
      tableCart,
      {clmThresoldQty: newQuantity.toString()},
      where: '$clmProductId = ?',
      whereArgs: [productId],
    );

    return;
  }

  Future<dynamic> fetchSingleProduct(String productId) async {
    Database dbClient = await db;

    List<Map<String, dynamic>> result = await dbClient.query(
      tableCart,
      where: '$clmProductId = ?',
      whereArgs: [productId],
      limit: 1,
    );

    print('result ${result.toString()}');
    if (result.isNotEmpty) {
      return ProductDetail.fromDb(result.first);
    }
    return {};
  }

  Future<int> truncateCartItems() async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM $tableCart;');
  }

  Future<bool> removeProductFromCart(String productId) async {
    var dbClient = await db;

    int res = await dbClient.delete(
      tableCart,
      where: '$clmProductId = ?',
      whereArgs: [productId],
    );
    if (res > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> insert(String search) async {
    var dbClient = await db;
    return await dbClient.insert(tableSearch, {clmText: search});
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return db.then((db) => db.query(tableSearch));
  }

  Future<int> deleteSearch(int id) async {
    Database dbClient = await db;
    return await dbClient.delete(
      tableSearch,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearAll() async {
    Database dbClient = await db;
    await dbClient.delete(tableCart);
    await dbClient.delete(tableSearch);
  }

  Future<void> clearSearch() async {
    Database dbClient = await db;
    await dbClient.delete(tableSearch);
  }
}
