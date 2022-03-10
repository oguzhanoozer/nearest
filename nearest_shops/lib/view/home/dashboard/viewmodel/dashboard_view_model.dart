import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';
import 'package:nearest_shops/view/home/shop_list/model/shop_model.dart';
import 'package:intl/intl.dart';
import '../../../product/contstants/image_path.dart';
import '../model/dashboard_model.dart';

part 'dashboard_view_model.g.dart';

class DashboardViewModel = _DashboardViewModelBase with _$DashboardViewModel;

abstract class _DashboardViewModelBase with Store {
  List<DashboardModel> dashboardModelList = [
    DashboardModel(
      url: ImagePaths.instance.hotDog,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.kiwi,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.tulip,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.currant,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    ),
    DashboardModel(
      url: ImagePaths.instance.turnip,
      title: "Product title",
      body: "Product body",
      price: "\$50",
    )
  ];

  FirebaseFirestore _firebaseFiresore = FirebaseFirestore.instance;

  Future<void> callFirestore() async {
    final shopsCollectionReference = _firebaseFiresore.collection("shops");
    QuerySnapshot shopsCollectionSnapshot =
        await shopsCollectionReference.get();
    List<DocumentSnapshot> docsInShops = shopsCollectionSnapshot.docs;
    print(docsInShops.length);
    print(docsInShops[0].get("location").latitude);
    print(docsInShops[0].data());
    GeoPoint geoPoint = docsInShops[0].get("location");
    print(geoPoint.latitude);

    ShopModel shopModel = ShopModel.fromJson(docsInShops[0].data() as Map);
    print(shopModel.location!.latitude);

    CollectionReference productsCollectionReference =
        _firebaseFiresore.collection("products");
    QuerySnapshot productCollectionSnapshot =
        await productsCollectionReference.get();
    List<DocumentSnapshot> docsInproducts = productCollectionSnapshot.docs;

    Query query = productsCollectionReference.where("name", isEqualTo: "Kalem");
    query.snapshots().listen((event) {
      DocumentSnapshot x = event.docs.first;
      ProductDetailModel productDetailModel =
          ProductDetailModel.fromJson(x.data() as Map);
      print("***"+productDetailModel.name.toString());
    });

    ProductDetailModel productDetailModel =
        ProductDetailModel.fromJson(docsInproducts.first.data() as Map);
    print(DateFormat('dd/MM/yyyy').format(productDetailModel.lastSeenDate!));
  }
}
