//  ========================
//  Keys & IDs
//  ========================
// 

// General keys

const String kImageUrl = 'imageUrl';
const String kKeyStatus = 'status';
const String kKeyJsonObject = 'json_object';
const String kKeyJsonArray = 'json_array';
const String kKeyStringData = 'string_data';
const String kKeyMessage = 'message';
const String kKeyData = 'data';
const String kKeyCode = 'code';
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kKeyToken = 'token';
const String kKeyTokenType = 'token_type';
const String kKeyDeviceToken = 'device_token';
const String kKeyAppTheme = 'app_theme';

// User/Location Info
const String kPhone = 'phone_number';
const String kKeySelectedLocation = 'selected_location';
const String kKeySelectedLat = 'selected_lat';
const String kKeySelectedLng = 'selected_lng';
const String kKeyAddress = 'address';
const String kKeyUser = 'user';
const String kKeyEmailVerifiedAt = 'email_verified_at';
const String kKeyPhoneVerifiedAt = 'phone_verified_at';

// User Auth Info
const String kKeyProvider = 'provider';
const String kFacebook = 'facebook';
const String kApple = 'apple';
const String kGoogle = 'google';

// Language & Region
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyLocale = 'selacted_locale';
const String kKeyLanguageCode = 'language_code';
const String kKeyCountryCode = 'country_code';
const String kKeyEnglishLocale = 'en';
const String kKeyBanglaLocale = 'bn';

// User Info
const String kKeyFirstName = 'first_name';
const String kKeyLastName = 'last_name';
const String kKeyDeviceID = 'device_id';
const String kKeyUserID = 'user_id';

// Local DB IDs
const String dbIdLogin = 'shop_id';

// Database keys
// const String kKeyLogin = 'local_login';

class DefaultValue {
  static const bool kDefaultBoolean = false;
  static const int kDefaultInt = 0;
  static const double kDefaultDouble = 0.0;
  static const String kDefaultString = '';
}
