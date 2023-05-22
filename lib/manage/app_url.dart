class AppUrl {
  static String mainUrl = "https://thecarsdoctor.com/api/";
  static String policyUrl = "https://thecarsdoctor.com/privacy.php";
  static String refundPolicyUrl = "https://thecarsdoctor.com/refundpolicy.php";
  static String termsUrl = "https://thecarsdoctor.com/terms.php";
}

String sendOTPUrl(){
  return AppUrl.mainUrl + "partner_sendOtp";
}

String resendOTPUrl(){
  return AppUrl.mainUrl + "partner_resendOtp";
}

String verifyOTPUrl(){
  return AppUrl.mainUrl + "partner_verifyOtp";
}

String profileGetUrl(){
  return AppUrl.mainUrl + "get_partner_profile";
}

String partnerOrdersUrl(){
  return AppUrl.mainUrl + "partner_orders";
}

String updateDocumentUrl(){
  return AppUrl.mainUrl + "update_document";
}

String editPartnerProfileUrl(){
  return AppUrl.mainUrl + "edit_partner_profile";
}

String partnerChangeMobileUrl(){
  return AppUrl.mainUrl + "partner_change_mobile";
}

String notificationsUrl(){
  return AppUrl.mainUrl + "get_partner_notification";
}