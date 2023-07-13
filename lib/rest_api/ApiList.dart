
class APIS {

  // static const String _baseUrl = "http://partyapp.v2infotech.net/api/party";
  static const String _baseUrl = "http://localhost:3500/api/party";
  static const String _baseUrl1 = "http://shoppingapp.v2infotech.net/api";
  static var usersSignUp = "$_baseUrl/User/signup";
  static var usersLogin = "$_baseUrl/User/login";
  static var forgetPassword = "$_baseUrl/User/forgetPassword";
  static var changePassword = "$_baseUrl/User/changePassword";
  static var addMessage = "$_baseUrl/Contact/addMessage";
  static var getCategory = "$_baseUrl/Category/getCategory";
  static var getProduct = "$_baseUrl/Product/getProductList";
  static var updateProfile = "$_baseUrl/User/updateProfile";
  static var getCartList = "$_baseUrl/Cart/getCartList";
  static var addPackageCount = "$_baseUrl/Cart/addPackageCount";
  static var termsCondition = "$_baseUrl/TC/getTC";
  // static var getTC = "$_baseUrl1/TC/getTC";
  static var getTC = "$_baseUrl/TC/getTC";
  static var privacy = "$_baseUrl/Privacy/getPrivacy";
  static var privacy1 = "$_baseUrl/Privacy/privacyPolicy";
  static var faq = "$_baseUrl/Faq/getFaqQuesAns";
  static var orderDetail = "$_baseUrl/Order/addOrderDetail";
  static var orderDetails = "$_baseUrl/Order/Make_order";
  static var ownerDetail = "$_baseUrl/Caller/getCallerDetail";
  static var removeProductCart = "$_baseUrl/Cart/removeProductCart";
  static var getCartCount = "$_baseUrl/Cart/getCartCount";
  static var checkRegistration = "$_baseUrl/User/checkRegistration";
  static var ProductDetails = "$_baseUrl/Order/Product_details";
  static var Save_ptmres = "$_baseUrl/Order/Save_ptmres";
  static var OrderHistory = "$_baseUrl/Order/Order_history";


}