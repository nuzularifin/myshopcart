import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 2)
class Product {
  String? bndlDlvCnYn;
  String? cuponcheck;
  String? dispCtgrNo;
  String? dispCtgrStatCd;
  String? exchDlvCst;
  String? imageKindChk;
  String? optionAllAddPrc;
  String? outsideYnIn;
  String? outsideYnOut;
  String? prdAttrCd;
  @HiveField(0)
  String? prdNm;
  @HiveField(1)
  String? prdNo;
  String? prdSelQty;
  String? prdUpdYN;
  String? preSelPrc;
  String? proxyYn;
  String? rtngdDlvCst;
  String? saleEndDate;
  String? saleStartDate;
  String? selLimitPersonType;
  String? selMnbdNckNm;
  String? selMthdCd;
  @HiveField(2)
  String? selPrc;
  String? selPrdClfCd;
  String? selStatCd;
  String? selTermUseYn;
  String? sellerItemEventYn;
  String? sellerPrdCd;
  String? shopNo;
  String? tmpltSeq;
  String? validateMsg;
  String? nResult;
  String? dispCtgrNm;
  String? dispCtgrNmMid;
  String? dispCtgrNmRoot;
  String? dscAmt;
  String? dscPrice;
  String? freeDelivery;
  // ProductOptionDetails? productOptionDetails;
  String? dispCtgrNo1;
  String? stock;
  @HiveField(3)
  int qty = 0;

  bool isSelected = false;

  Product(
      {this.bndlDlvCnYn,
      this.cuponcheck,
      this.dispCtgrNo,
      this.dispCtgrStatCd,
      this.exchDlvCst,
      this.imageKindChk,
      this.optionAllAddPrc,
      this.outsideYnIn,
      this.outsideYnOut,
      this.prdAttrCd,
      this.prdNm,
      this.prdNo,
      this.prdSelQty,
      this.prdUpdYN,
      this.preSelPrc,
      this.proxyYn,
      this.rtngdDlvCst,
      this.saleEndDate,
      this.saleStartDate,
      this.selLimitPersonType,
      this.selMnbdNckNm,
      this.selMthdCd,
      this.selPrc,
      this.selPrdClfCd,
      this.selStatCd,
      this.selTermUseYn,
      this.sellerItemEventYn,
      this.sellerPrdCd,
      this.shopNo,
      this.tmpltSeq,
      this.validateMsg,
      this.nResult,
      this.dispCtgrNm,
      this.dispCtgrNmMid,
      this.dispCtgrNmRoot,
      this.dscAmt,
      this.dscPrice,
      this.freeDelivery,
      // this.productOptionDetails,
      this.dispCtgrNo1,
      this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    bndlDlvCnYn = json['bndlDlvCnYn'];
    cuponcheck = json['cuponcheck'];
    dispCtgrNo = json['dispCtgrNo'];
    dispCtgrStatCd = json['dispCtgrStatCd'];
    exchDlvCst = json['exchDlvCst'];
    imageKindChk = json['imageKindChk'];
    optionAllAddPrc = json['optionAllAddPrc'];
    outsideYnIn = json['outsideYnIn'];
    outsideYnOut = json['outsideYnOut'];
    prdAttrCd = json['prdAttrCd'];
    prdNm = json['prdNm'];
    prdNo = json['prdNo'];
    prdSelQty = json['prdSelQty'];
    prdUpdYN = json['prdUpdYN'];
    preSelPrc = json['preSelPrc'];
    proxyYn = json['proxyYn'];
    rtngdDlvCst = json['rtngdDlvCst'];
    saleEndDate = json['saleEndDate'];
    saleStartDate = json['saleStartDate'];
    selLimitPersonType = json['selLimitPersonType'];
    selMnbdNckNm = json['selMnbdNckNm'];
    selMthdCd = json['selMthdCd'];
    selPrc = json['selPrc'];
    selPrdClfCd = json['selPrdClfCd'];
    selStatCd = json['selStatCd'];
    selTermUseYn = json['selTermUseYn'];
    sellerItemEventYn = json['sellerItemEventYn'];
    sellerPrdCd = json['sellerPrdCd'];
    shopNo = json['shopNo'];
    tmpltSeq = json['tmpltSeq'];
    validateMsg = json['validateMsg'];
    nResult = json['nResult'];
    dispCtgrNm = json['dispCtgrNm'];
    dispCtgrNmMid = json['dispCtgrNmMid'];
    dispCtgrNmRoot = json['dispCtgrNmRoot'];
    dscAmt = json['dscAmt'];
    dscPrice = json['dscPrice'];
    freeDelivery = json['freeDelivery'];
    // productOptionDetails = json['ProductOptionDetails'] != null
    //     ? ProductOptionDetails.fromJson(json['ProductOptionDetails'])
    //     : null;
    dispCtgrNo1 = json['dispCtgrNo1'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bndlDlvCnYn'] = bndlDlvCnYn;
    data['cuponcheck'] = cuponcheck;
    data['dispCtgrNo'] = dispCtgrNo;
    data['dispCtgrStatCd'] = dispCtgrStatCd;
    data['exchDlvCst'] = exchDlvCst;
    data['imageKindChk'] = imageKindChk;
    data['optionAllAddPrc'] = optionAllAddPrc;
    data['outsideYnIn'] = outsideYnIn;
    data['outsideYnOut'] = outsideYnOut;
    data['prdAttrCd'] = prdAttrCd;
    data['prdNm'] = prdNm;
    data['prdNo'] = prdNo;
    data['prdSelQty'] = prdSelQty;
    data['prdUpdYN'] = prdUpdYN;
    data['preSelPrc'] = preSelPrc;
    data['proxyYn'] = proxyYn;
    data['rtngdDlvCst'] = rtngdDlvCst;
    data['saleEndDate'] = saleEndDate;
    data['saleStartDate'] = saleStartDate;
    data['selLimitPersonType'] = selLimitPersonType;
    data['selMnbdNckNm'] = selMnbdNckNm;
    data['selMthdCd'] = selMthdCd;
    data['selPrc'] = selPrc;
    data['selPrdClfCd'] = selPrdClfCd;
    data['selStatCd'] = selStatCd;
    data['selTermUseYn'] = selTermUseYn;
    data['sellerItemEventYn'] = sellerItemEventYn;
    data['sellerPrdCd'] = sellerPrdCd;
    data['shopNo'] = shopNo;
    data['tmpltSeq'] = tmpltSeq;
    data['validateMsg'] = validateMsg;
    data['nResult'] = nResult;
    data['dispCtgrNm'] = dispCtgrNm;
    data['dispCtgrNmMid'] = dispCtgrNmMid;
    data['dispCtgrNmRoot'] = dispCtgrNmRoot;
    data['dscAmt'] = dscAmt;
    data['dscPrice'] = dscPrice;
    data['freeDelivery'] = freeDelivery;
    // if (productOptionDetails != null) {
    //   data['ProductOptionDetails'] = productOptionDetails!.toJson();
    // }
    data['dispCtgrNo1'] = dispCtgrNo1;
    data['stock'] = stock;
    return data;
  }
}
