import 'package:dakibaa/models/paytm_model.dart';
import 'package:dakibaa/models/product_model_services.dart';
import 'package:dakibaa/models/services_model.dart';


String loginstatus="";
int showcount=0;
int totalAmount=0;
int totalamount_bev=0;
int totalamount_glas=0;
int? person;
bool? checkedValue_1=true;
bool? checkedValue_2=true;
String? profile_pic;
List<ProductServicesModel?> product=<ProductServicesModel?>[];
var jsons;
late ServicesModel SERVICESRESPONSE;
List<ServicesModel_list>?SERVICES_LIST;
String? titlename;
late String imageProduct;
String? descp;
var id_com;
String? price;
PaytmModel? paytmModel;
String? payment_txnid;
String? payment_mesg;
String? payment_bank;
String? payment_OrderID;

String? payment_amount;
List<String>glasswareimg=["images/onepic.jpeg","images/secondpic.jpeg","images/thirdpic.jpeg","images/fourthpic.jpeg","images/fivepic.jpeg","images/sixpic.jpeg","images/sevenpic.jpeg"];
List<String>glasswarename=["1. HI BALL","2. OLD FASHIONED","3. BEER","4. RED WINE","5. WHITE WINE","6. SHOT","7. CHAMPAGNE","8. MARTINI","9. MARGARITA","10. BRANDY BALLOON","11. TOM COLLINS","12. HURRICANE"];
List<String>baveragename=["1. ORANGE JUICE","2. PINEAPPLE JUICE","3. CRANBERRY JUICE","4. MONIN  SYRUP 250ML","5. BROWN SUGAR",
  "6. LIME POWDER (PKT)","7. SUGAR SYRUP(ltr)","8. FRESH LEMON (KG)","9. MINT LEAVES","10. FLEXABLE STRAWS","11. SWIZZLE STICKS","12. SODA WATER NORMAL[CASE]",
"13. TONIC WATER CAN","14. DIET COKE CAN (CASE)","15. SOFT DRINK (2LTR)","16. KINLAY WATER  [1LTR] (CASE)",
  "17. WATER 200ML[CASE]","18. ICE CUBES","19. SLAB ICE"];
