import 'dart:async';
import 'dart:io';

import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ykapay/app/services/balance_service.dart';
import 'package:ykapay/utils/common.dart';

class ChargeController extends GetxController with GetTool {
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;
  bool available = true;
  // ignore: cancel_subscriptions
  StreamSubscription subscription;
  GetStorage box = GetStorage();
  RxInt balance = 0.obs;

// here to add more Products in this case we have 2 Product IDs
  RxList products = [].obs;
// here to Create boolean for our First Product to check if its Purchased our not.

  bool _isFirstItemPurchased = false;
  // ignore: unnecessary_getters_setters
  bool get isFirstItemPurchased => _isFirstItemPurchased;
  // ignore: unnecessary_getters_setters
  set isFirstItemPurchased(bool value) {
    _isFirstItemPurchased = value;
  }

// here to Create boolean for our Second Product to check if its Purchased our not.

  bool _isSecondItemPurchased = false;
  // ignore: unnecessary_getters_setters
  bool get isSecondItemPurchased => _isSecondItemPurchased;
  // ignore: unnecessary_getters_setters
  set isSecondItemPurchased(bool value) {
    _isSecondItemPurchased = value;
  }

// here is the list of purchases

  List _purchases = [];
  // ignore: unnecessary_getters_setters
  List get purchases => _purchases;
  // ignore: unnecessary_getters_setters
  set purchases(List value) {
    _purchases = value;
  }

  Rx<ProductDetails> resStream;
// here we initialize and check our purchases

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    balance.value = int.tryParse(box.read('money'));
    await initialize();
    print('products:');
    print(products);
  }

  Future<void> initialize() async {
    available = await _iap.isAvailable();
    if (available) {
      await getProducts();
      // await getPastPurchases();
      // verifyPurchase();
      subscription = _iap.purchaseUpdatedStream.listen((data) async {
        if (data[0].status == PurchaseStatus.error) {
          notify.error(title: "Thất bại", message: "Thah toán thất bại");
        } else if (data[0].status == PurchaseStatus.pending) {
          notify.warning(title: "Đang xử lý", message: "Thanh toán đang xử lý");
        } else {
          notify.success(title: "Thành công", message: "Thanh toán thành công");
          _iap.completePurchase(data[0]);

          var listIds = await BalanceService().getProducts();

          listIds.forEach((element) async {
            if (data[0].productID == element.split(':').first) {
              await handleDeposit(element.split(':').last, data[0].purchaseID);
            }
          });
        }
        purchases.addAll(data);
        verifyPurchase();
      });
    }
  }

  void buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    //_iap.buyNonConsumable(purchaseParam: purchaseParam);
    _iap.buyConsumable(purchaseParam: purchaseParam);
  }

  void verifyPurchase() {
//   here verify and complete our First Product Purchase
//     PurchaseDetails purchase = hasPurchased(younger5k);
//     if (purchase != null && purchase.status == PurchaseStatus.purchased) {
//       if (purchase.pendingCompletePurchase) {
//         _iap.completePurchase(purchase);

//         if (purchase != null && purchase.status == PurchaseStatus.purchased) {
//           isFirstItemPurchased = true;
//         }
//       }
//     }

// //   here verify and complete our second Product Purchase

//     PurchaseDetails secondPurchase = hasPurchased(younger30k);
//     if (secondPurchase != null &&
//         secondPurchase.status == PurchaseStatus.purchased) {
//       if (secondPurchase.pendingCompletePurchase) {
//         _iap.completePurchase(secondPurchase);

//         if (secondPurchase != null &&
//             secondPurchase.status == PurchaseStatus.purchased) {
//           isSecondItemPurchased = true;
//         }
//       }
//     }
  }

  PurchaseDetails hasPurchased(String productID) {
    return purchases.firstWhere((purchase) => purchase.productID == productID,
        orElse: () => null);
  }

  Future<void> getProducts() async {
    var listIds = await BalanceService().getProducts();

    Set<String> ids = Set.from(listIds.map((e) => e.split(':').first).toList());
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);
    products.assignAll(
        response.productDetails..sort((a, b) => a.price.compareTo(b.price)));
  }

  Future<void> getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();
    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        _iap.consumePurchase(purchase);
      }
    }
    purchases = response.pastPurchases;
  }

  // handle here
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController..refreshCompleted();
  }

  handleDeposit(money, String purchaseId) async {
    CommonWidget.progressIndicator();
    var res = await BalanceService()
        .addMoney(data: {'money': money, 'purchaseId': purchaseId});
    Get.back();
    if (res != null && res['error'] == 0) {
      notify.success(
          title: "Thành công",
          message: "Bạn được cộng $money vào tài khoản",
          timeout: 3000);
      balance.value += money;
    } else {
      notify.error(title: "Thất bại", message: "Thanh toán thất");
    }
    setTimeout(() {
      Get.back();
    }, 3000);
  }
}
