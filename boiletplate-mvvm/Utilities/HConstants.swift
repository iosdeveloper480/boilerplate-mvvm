//
//  HConstants.swift
//  Asmaky
//
//  Created by mac on 14/11/2021.
//

import UIKit
import CoreLocation

struct HConstants {
    
    static let apiToken = "token"
    static let savedUser = "SavedUser"
    static let savedCart = "SavedCart"
    static let savedLocation = "SavedLocation"
    static var globalCoupon = ""
    
    //    static let baseUrl = ""
    static let baseUrl = ""
    static let rsaKeyUrl = ""
    static let redirectUrl = ""
    static let cancelUrl = ""
    static let merchantID = ""
    static let accessCode = ""
    //TEST 5204740009900014
    //    static let facebookUrl = ""
    static let facebookUrl = ""
    static let instgramUrl = ""
    static let twitterUrl = ""
    static let youtubeUrl = ""
    static var appUrl = ""
    
    static let getCategoriesUrl = "/get_categories"
    
    static let user_id = ""
    
    struct st {
        static let home = "1" /**Parameters:- static let notifications = "1"*/
        static let list = "2" /**Parameters:- static let notifications = "2"*/
        static let shop = "3" /**Parameters:- static let notifications = "3"*/
        static let productDetail = "4" /**Parameters:- static let notifications = "4"*/
        static let cart = "5" /**Parameters:- static let notifications = "5"*/
        static let ticket = "6" /**Parameters:- static let notifications = "6"*/
        static let ticketCoupon = "7" /**Parameters:- static let notifications = "7"*/
        static let submitTicket = "8" /**Parameters:- static let notifications = "8"*/
        static let addAddress = "9" /**Parameters:- static let notifications = "9"*/
        static let savedAddresses = "10" /**Parameters:- static let notifications = "10"*/
        static let deleteSavedAddresses = "11" /**Parameters:- static let notifications = "11"*/
        static let ordersList = "12" /**Parameters:- static let notifications = "12"*/
        static let orderDetail = "13" /**Parameters:- static let notifications = "13"*/
        static let addReview = "14" /**Parameters:- static let notifications = "14"*/
        static let termsAndConditions = "15" /**Parameters:- static let notifications = "15"*/
        static let contactUs = "16" /**Parameters:- static let notifications = "16"*/
        static let registerUser = "17" /**Parameters:- static let notifications = "17"*/
        static let getProfile = "18" /**Parameters:- static let notifications = "18"*/
        static let profilePic = "19" /**Parameters:- static let notifications = "19"*/
        static let walletBookings = "20" /**Parameters:- static let notifications = "20"*/
        static let loadJoinUsData = "22" /**Parameters:- static let notifications = "22"*/
        static let joinUs = "23" /**Parameters:- static let notifications = "23"*/
        static let notifications = "24" /**Parameters:- static let notifications = "24"*/
        static let recharge = "25" /**Parameters:- static let recharge = "24"*/
        
        static let driverExists = "4"
        static let coupons = "8"
        static let history = "12"
        static let addSavedAddresses = "15"
        static let category = "17"
        static let tripDetails = "18"
        static let addTrip = "19"
        static let getMessages = "20"
        static let getActiveTrip = "21"
        static let validateCoupon = "22"
    }
    
    struct Theme {
        struct Radius {
            static let buttonCornerRadius: CGFloat = 5.0
            static let shadowRadius: CGFloat = 5
            static let cornerRadius: CGFloat = 10
        }
        struct Colors {
            static let backgroundColor = UIColor(named: "backgroundColor")!
            static let lightGrayColor = UIColor(named: "lightGrayColor") ?? UIColor.lightGray
            
            static let AppColor = UIColor(named: "appColor") ?? UIColor(hexString: "#DE578A")
            static let AppLightColor = UIColor(named: "appLightColor") ?? UIColor(hexString: "#DE578A")
            
            static let SecondaryColor = UIColor(named: "secondaryColor") ?? UIColor(hexString: "#DE578A")
            static let SecondaryLightColor = UIColor(named: "secondaryLightColor") ?? UIColor(hexString: "#DE578A")
            
            static let buttonPrimaryColor = UIColor(named: "buttonColor") ?? UIColor.yellow
            static let ColorBlack = UIColor(named: "ColorBlack") ?? UIColor(hexString: "#000000")
            static let ColorGray = UIColor(named: "grayColor") ?? UIColor(hexString: "#B3B6B7")
            static let ShadowColor2 = UIColor(named: "shadowColor") ?? UIColor(hexString: "#272C33")
            static let ColorDarkGray = UIColor(named: "ColorDarkGray") ?? UIColor(hexString: "#545454")
            static let ColorRed = UIColor(named: "ColorRed") ?? UIColor(hexString: "#ED503C")
            static let ColorDarkRed = UIColor(named: "ColorDarkRed") ?? UIColor(hexString: "#A02914")
            static let ColorGreen = UIColor(named: "greenColor") ?? UIColor.systemGreen
            static let ColorGreenDark = UIColor(named: "ColorGreenDark") ?? UIColor(hexString: "#007600")
            static let ColorGold = UIColor(named: "ColorGold") ?? UIColor(hexString: "#FFD700")
            static let ColorBlue = UIColor(named: "ColorBlue") ?? UIColor(hexString: "#28A9FD")
            static let ColorWhite = UIColor(named: "ColorWhite") ?? UIColor(hexString: "#FFFFFF")
            static let ColorBorder = UIColor(named: "ColorBorder") ?? UIColor(hexString: "#ECE9EC")
            static let shadowColor = Colors.lightGrayColor
            static let unselectedCellColor = UIColor(named: "unselectedCellColor")
        }
        struct Corners {
            static let all: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            static let topRightTopLeft: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            static let bottomRightBottomLeft: CACornerMask = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            static let topLeftBottomLeft: CACornerMask = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            static let topRightBottomRight: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        struct Font {
            enum Size: CGFloat {
                case sizeMini = 10
                case size12 = 12
                case size13 = 13
                case size14 = 14
                case size16 = 16
                case size18 = 18
                case size20 = 20
            }
            enum SFUI {
                case bold, regular, medium, semibold
            }
            enum TextStyle {
                case heading1, heading2, heading3, heading4, title1, title2, subtitle1, subtitle2, subtitle3, body1, body2, caption, custom(HConstants.Theme.Font.Size, HConstants.Theme.Font.SFUI)
            }
            static func getFont(size: Size, weight: SFUI) -> UIFont {
                switch weight {
                case .bold:
                    return UIFont(name: "SFUIDisplay-Bold", size: size.rawValue) ?? UIFont.boldSystemFont(ofSize: size.rawValue)
                case .regular:
                    return UIFont(name: "SFUIDisplay", size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
                case .medium:
                    return UIFont(name: "SFUIDisplay-Medium", size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
                case .semibold:
                    return UIFont(name: "SFUIDisplay-SemiBold", size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue, weight: .semibold)
                }
            }
        }
        
        enum ShadowDirection {
            case top, bottom, right, left, all, none
        }
    }
    static let bannerTimer: TimeInterval = 8.0
    
}
func Font(ofSize: HConstants.Theme.Font.Size, weight: HConstants.Theme.Font.SFUI) -> UIFont {
    return HConstants.Theme.Font.getFont(size: ofSize, weight: weight)
}
extension UIView {
    func defaultShadow(direction: HConstants.Theme.ShadowDirection) {
        switch direction {
        case .top:
            self.shadow(shadowColor: HConstants.Theme.Colors.ShadowColor2, shadowOffset: CGSize(width: 0, height: -2), shadowRadius: 5, shadowOpacity: 1, maskedCorners: HConstants.Theme.Corners.topRightTopLeft)
        case .bottom:
            self.shadow(shadowColor: HConstants.Theme.Colors.ShadowColor2, shadowOffset: CGSize(width: 0, height: 2), shadowRadius: 5, shadowOpacity: 1, maskedCorners: HConstants.Theme.Corners.bottomRightBottomLeft)
        case .right:
            self.shadow(shadowColor: HConstants.Theme.Colors.ShadowColor2, shadowOffset: CGSize(width: 2, height: 0), shadowRadius: 5, shadowOpacity: 1, maskedCorners: HConstants.Theme.Corners.topRightBottomRight)
        case .left:
            self.shadow(shadowColor: HConstants.Theme.Colors.ShadowColor2, shadowOffset: CGSize(width: -2, height: 0), shadowRadius: 5, shadowOpacity: 1, maskedCorners: HConstants.Theme.Corners.topLeftBottomLeft)
        case .all:
            self.shadow(shadowColor: HConstants.Theme.Colors.ShadowColor2, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 5, shadowOpacity: 1, maskedCorners: HConstants.Theme.Corners.all)
        case .none:
            self.shadow(shadowColor: .clear, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 0, shadowOpacity: 0, maskedCorners: HConstants.Theme.Corners.all)
        }
    }
}
extension UILabel {
    func setFont(style: HConstants.Theme.Font.TextStyle) {
        switch style {
        case .heading1:
            self.font = Font(ofSize: .size20, weight: .bold)
        case .heading2:
            self.font = Font(ofSize: .size18, weight: .bold)
        case .heading3:
            self.font = Font(ofSize: .size16, weight: .bold)
        case .heading4:
            self.font = Font(ofSize: .size14, weight: .bold)
        case .title1:
            self.font = Font(ofSize: .size16, weight: .bold)
        case .title2:
            self.font = Font(ofSize: .size14, weight: .bold)
        case .subtitle1:
            self.font = Font(ofSize: .size16, weight: .medium)
        case .subtitle2:
            self.font = Font(ofSize: .size14, weight: .medium)
        case .subtitle3:
            self.font = Font(ofSize: .size12, weight: .medium)
        case .body1:
            self.font = Font(ofSize: .size16, weight: .regular)
        case .body2:
            self.font = Font(ofSize: .size14, weight: .regular)
        case .caption:
            self.font = Font(ofSize: .size12, weight: .regular)
        case .custom(let size, let weight):
            self.font = Font(ofSize: size, weight: weight)
        }
    }
}
extension UITextView {
    func setFont(style: HConstants.Theme.Font.TextStyle) {
        switch style {
        case .heading1:
            self.font = Font(ofSize: .size20, weight: .bold)
        case .heading2:
            self.font = Font(ofSize: .size18, weight: .bold)
        case .heading3:
            self.font = Font(ofSize: .size16, weight: .bold)
        case .heading4:
            self.font = Font(ofSize: .size14, weight: .bold)
        case .title1:
            self.font = Font(ofSize: .size16, weight: .bold)
        case .title2:
            self.font = Font(ofSize: .size14, weight: .bold)
        case .subtitle1:
            self.font = Font(ofSize: .size16, weight: .medium)
        case .subtitle2:
            self.font = Font(ofSize: .size14, weight: .medium)
        case .subtitle3:
            self.font = Font(ofSize: .size12, weight: .medium)
        case .body1:
            self.font = Font(ofSize: .size16, weight: .regular)
        case .body2:
            self.font = Font(ofSize: .size14, weight: .regular)
        case .caption:
            self.font = Font(ofSize: .size12, weight: .regular)
        case .custom(let size, let weight):
            self.font = Font(ofSize: size, weight: weight)
        }
    }
}
extension UITextField {
    func setFont(style: HConstants.Theme.Font.TextStyle) {
        switch style {
        case .heading1:
            self.font = Font(ofSize: .size20, weight: .bold)
        case .heading2:
            self.font = Font(ofSize: .size18, weight: .bold)
        case .heading3:
            self.font = Font(ofSize: .size16, weight: .bold)
        case .heading4:
            self.font = Font(ofSize: .size14, weight: .bold)
        case .title1:
            self.font = Font(ofSize: .size16, weight: .bold)
        case .title2:
            self.font = Font(ofSize: .size14, weight: .bold)
        case .subtitle1:
            self.font = Font(ofSize: .size16, weight: .medium)
        case .subtitle2:
            self.font = Font(ofSize: .size14, weight: .medium)
        case .subtitle3:
            self.font = Font(ofSize: .size12, weight: .medium)
        case .body1:
            self.font = Font(ofSize: .size16, weight: .regular)
        case .body2:
            self.font = Font(ofSize: .size14, weight: .regular)
        case .caption:
            self.font = Font(ofSize: .size12, weight: .regular)
        case .custom(let size, let weight):
            self.font = Font(ofSize: size, weight: weight)
        }
    }
}
class HLocalized {
    
    let page1Title = "page1Title".localiz()
    let page1Description = "page1Description".localiz()
    let page2Title = "page2Title".localiz()
    let page2Description = "page2Description".localiz()
    let page3Title = "page3Title".localiz()
    let page3Description = "page3Description".localiz()
    let getStarted = "getStarted".localiz()
    let welcome = "welcome".localiz()
    let welcomeDescription = "welcomeDescription".localiz()
    let UseCurrentLocation = "UseCurrentLocation".localiz()
    let SelectItManually = "SelectItManually".localiz()
    let letsRider = "LetsRider".localiz()
    let name2 = "Name".localiz()
    let mobileNumber = "MobileNumber".localiz()
    let termsConditions = "TermsConditions".localiz()
    let done2 = "done".localiz()
    let field_missing = "field_missing".localiz()
    let Please_enter_a_valid = "Please_enter_a_valid".localiz()
    let phoneVerification = "PhoneVerification".localiz()
    let opt = "OTP".localiz()
    let verifyNow = "VerifyNow".localiz()
    let Signup = "Signup".localiz()
    let History = "MyHistory".localiz()
    let Notification = "Notification".localiz()
    let Settings = "Settings".localiz()
    let MyAccount = "MyAccount".localiz()
    let Save = "Save".localiz()
    let Birthday = "Birthday".localiz()
    let logouttext = "logouttext".localiz()
    let yes = "yes".localiz()
    let no = "no".localiz()
    let selectgender = "selectgender".localiz()
    let missing_name = "missing_name".localiz()
    let missing_phone = "missing_phone".localiz()
    let select_delivery_address = "select_delivery_address".localiz()
    let nobookings = "nobookings".localiz()
    let norestaurant = "norestaurant".localiz()
    let add_on_more_thanlimit = "add_on_more_thanlimit".localiz()
    let selectcountry = "selectcountry".localiz()
    let selectrestaurant = "selectrestaurant".localiz()
    let selectcity = "selectcity".localiz()
    let unabletoupdatephoto = "unabletoupdatephoto".localiz()
    let pleaseenteryourname = "pleaseenteryourname".localiz()
    let yourreviewhassubmitted = "yourreviewhassubmitted".localiz()
    let coupon = "coupon".localiz()
    let please_enter = "please_enter".localiz()
    let selectaddress = "selectaddress".localiz()
    let notes = "notes".localiz()
    let pleaseaddrating = "pleaseaddrating".localiz()
    let search = "search".localiz()
    let app_name = "app_name".localiz()
    let menu_home = "menu_home".localiz()
    let addtocart = "addtocart".localiz()
    let tcurrency = "tcurrency".localiz()
    let towdigits = "towdigits".localiz()
    let minimumorder = "minimumorder".localiz()
    let currency = "currency".localiz()
    let menu_orders = "menu_orders".localiz()
    let ordersummary = "ordersummary".localiz()
    let address = "address".localiz()
    let subtotal = "subtotal".localiz()
    let discount = "discount".localiz()
    let discount_ = "discount_".localiz()
    let delivery = "delivery".localiz()
    let total = "total".localiz()
    let paymentmethod = "paymentmethod".localiz()
    let menu_about = "menu_about".localiz()
    let loading = "loading".localiz()
    let no_notifications = "no_notifications".localiz()
    let menu_notifications = "menu_notifications".localiz()
    let balance = "balance".localiz()
    let recharge = "recharge".localiz()
    let no_transaction = "no_transaction".localiz()
    let savedaddress = "savedaddress".localiz()
    let language = "language".localiz()
    let terms = "terms".localiz()
    let contactus = "contactus".localiz()
    let menu_logout = "menu_logout".localiz()
    let menu_settings = "menu_settings".localiz()
    let no_address = "no_address".localiz()
    let menu_wallet = "menu_wallet".localiz()
    let email = "email".localiz()
    let saddress = "saddress".localiz()
    let phone = "phone".localiz()
    let submit = "submit".localiz()
    let menu_join = "menu_join".localiz()
    let addlogo = "addlogo".localiz()
    let addlicense = "addlicense".localiz()
    let minumum = "minumum".localiz()
    let popular = "popular".localiz()
    let whatyoulike = "whatyoulike".localiz()
    let amount = "amount".localiz()
    let done = "done".localiz()
    let name = "name".localiz()
    let login = "login".localiz()
    let acceptterms = "acceptterms".localiz()
    let signup = "signup".localiz()
    let invalidphone = "invalidphone".localiz()
    let invalidname = "invalidname".localiz()
    let invalidemail = "invalidemail".localiz()
    let tap_back_again_to_exit = "tap_back_again_to_exit".localiz()
    let VerifyFragment = "VerifyFragment".localiz()
    let SignUpFragment = "SignUpFragment".localiz()
    let codeerror = "codeerror".localiz()
    let selectlanguage = "selectlanguage".localiz()
    let english = "english".localiz()
    let arabic = "arabic".localiz()
    let checkout = "checkout".localiz()
    let apply = "apply".localiz()
    let remove = "remove".localiz()
    let currentaddress = "currentaddress".localiz()
    let selectaddressmap = "selectaddressmap".localiz()
    let selectfrommap = "selectfrommap".localiz()
    let specialrequest = "specialrequest".localiz()
    let optional = "optional".localiz()
    let upto = "upto".localiz()
    let limit = "limit".localiz()
    let choosefromlist = "choosefromlist".localiz()
    let choose1 = "choose1".localiz()
    let viewcart = "viewcart".localiz()
    let addressname = "addressname".localiz()
    let confirm = "confirm".localiz()
    let invalidcountry = "invalidcountry".localiz()
    let shopname = "shopname".localiz()
    let shopname_ar = "shopname_ar".localiz()
    let city = "city".localiz()
    let ticket = "ticket".localiz()
    let cart = "cart".localiz()
    let orderdetails = "orderdetails".localiz()
    let detecting = "detecting".localiz()
    let outofdelivery = "outofdelivery".localiz()
    let currnetoutofdelivery = "currnetoutofdelivery".localiz()
    let changeaddress = "changeaddress".localiz()
    let outofservices = "outofservices".localiz()
    let selectlocation = "selectlocation".localiz()
    let edit = "edit".localiz()
    let gender = "gender".localiz()
    let lbl_take_camera_picture = "lbl_take_camera_picture".localiz()
    let lbl_choose_from_gallery = "lbl_choose_from_gallery".localiz()
    let toast_image_intent_null = "toast_image_intent_null".localiz()
    let notselected = "notselected".localiz()
    let rate = "rate".localiz()
    let reviewsuccessfully = "reviewsuccessfully".localiz()
    let howitwas = "howitwas".localiz()
    let comment = "comment".localiz()
    let submitreview = "submitreview".localiz()
    let sorry_something_wrong = "sorry_something_wrong".localiz()
    let profile = "profile".localiz()
    let promocode = "promocode".localiz()
    let verfiytxt = "verfiytxt".localiz()
    let pleaselogin = "pleaselogin".localiz()
    let free = "free".localiz()
    let noneed = "noneed".localiz()
    let tab1 = "tab1".localiz()
    let nopartners = "nopartners".localiz()
    let cancel = "cancel".localiz()
    let start = "start".localiz()
    let clearcart = "clearcart".localiz()
    let inputerror = "inputerror".localiz()
    let street = "street".localiz()
    let building = "building".localiz()
    let apartment = "apartment".localiz()
    let add_address = "add_address".localiz()
    let addresplaceholder = "addresplaceholder".localiz()
    let pleasselectagin = "pleasselectagin".localiz()
    let change = "change".localiz()
    let payment_erorr = "payment_erorr".localiz()
    let shop_erorr = "shop_erorr".localiz()
    let noorders = "noorders".localiz()
    let copy = "copy".localiz()
    let coupontxt1 = "coupontxt1".localiz()
    let coupontxt2 = "coupontxt2".localiz()
    let cappedby = "cappedby".localiz()
    let toenjoy1 = "toenjoy1".localiz()
    let toenjoy2 = "toenjoy2".localiz()
    let country = "country".localiz()
    let area = "area".localiz()
    let shop_type = "shop_type".localiz()
    let logoerror = "logoerror".localiz()
    let licenseerror = "licenseerror".localiz()
    let requestadded = "requestadded".localiz()
    let view = "view".localiz()
    let inprogress = "inprogress".localiz()
    let time_erorr = "time_erorr".localiz()
    let quantityerror = "quantityerror".localiz()
    let placed = "placed".localiz()
    let preparing = "preparing".localiz()
    let on_the_way = "on_the_way".localiz()
    let delivered = "delivered".localiz()
    let cancelled = "cancelled".localiz()
    let cash_on_delivery = "cash_on_delivery".localiz()
    let credit_debit_card = "credit_debit_card".localiz()
    let wallet = "wallet".localiz()
    let recharge_no = "recharge_no".localiz()
    let order_no = "order_no".localiz()
    let refund = "refund".localiz()
    let not_selected = "not_selected".localiz()
    let female = "female".localiz()
    let male = "male".localiz()
    
    let arabicname = "arabicname".localiz()
    let englishname = "englishname".localiz()
    
    let password = "password".localiz()
    
    let update = "update".localiz()
}
let dummyTripID = "124"
let dubaiCoordinatesList = [CLLocationCoordinate2D(latitude:24.4593678497, longitude: 54.3726604515),
                            CLLocationCoordinate2D(latitude:24.4593936819, longitude: 54.3723908504),
                            CLLocationCoordinate2D(latitude:24.4657740691, longitude: 54.3663177312),
                            CLLocationCoordinate2D(latitude:24.4660969546, longitude: 54.366260973),
                            CLLocationCoordinate2D(latitude:24.469338679, longitude: 54.369921872),
                            CLLocationCoordinate2D(latitude:24.4696873855, longitude: 54.3704610742),
                            CLLocationCoordinate2D(latitude:24.4697261306, longitude: 54.3707874334),
                            CLLocationCoordinate2D(latitude:24.4633071966, longitude: 54.3769598794),
                            CLLocationCoordinate2D(latitude:24.4629068095, longitude: 54.3770308271),
                            CLLocationCoordinate2D(latitude:24.4593678497, longitude: 54.3726604515)]

let dubaiCoordinatesList2 = [CLLocationCoordinate2D(latitude: 24.5290184872, longitude: 55.5600534448),
                             CLLocationCoordinate2D(latitude: 24.6089118991, longitude: 55.2990224885),
                             CLLocationCoordinate2D(latitude: 24.6773513849, longitude: 55.1446628365),
                             CLLocationCoordinate2D(latitude: 24.8334806983, longitude: 55.0467762279),
                             CLLocationCoordinate2D(latitude: 24.8904132687, longitude: 54.9338301411),
                             CLLocationCoordinate2D(latitude: 24.9200078395, longitude: 54.9024562281),
                             CLLocationCoordinate2D(latitude: 25.0542323309, longitude: 54.7982948369),
                             CLLocationCoordinate2D(latitude: 25.2950121711, longitude: 55.1534475322),
                             CLLocationCoordinate2D(latitude: 25.3857486398, longitude: 55.2362746625),
                             CLLocationCoordinate2D(latitude: 25.3331408942, longitude: 55.3548857059),
                             CLLocationCoordinate2D(latitude: 25.3014366173, longitude: 55.3935868429),
                             CLLocationCoordinate2D(latitude: 25.1663273335, longitude: 55.7709229289),
                             CLLocationCoordinate2D(latitude: 25.1657800274, longitude: 55.8471157924),
                             CLLocationCoordinate2D(latitude: 25.1449805746, longitude: 55.8876310452),
                             CLLocationCoordinate2D(latitude: 25.1166396134, longitude: 55.9446732075),
                             CLLocationCoordinate2D(latitude: 24.940084955, longitude: 55.827153322),
                             CLLocationCoordinate2D(latitude: 24.9163410835, longitude: 55.7997523124),
                             CLLocationCoordinate2D(latitude: 24.7913974506, longitude: 55.8311571882),
                             CLLocationCoordinate2D(latitude: 24.7913974506, longitude: 55.8311571882),
                             CLLocationCoordinate2D(latitude: 24.7934368384, longitude: 55.8289107531),
                             CLLocationCoordinate2D(latitude: 24.7975155136, longitude: 55.826664318),
                             CLLocationCoordinate2D(latitude: 24.7995548009, longitude: 55.8221714478),
                             CLLocationCoordinate2D(latitude: 24.8056724615, longitude: 55.8131857074),
                             CLLocationCoordinate2D(latitude: 24.8117898202, longitude: 55.804199967),
                             CLLocationCoordinate2D(latitude: 24.817906877, longitude: 55.7974606617),
                             CLLocationCoordinate2D(latitude: 24.8240236318, longitude: 55.7907213564),
                             CLLocationCoordinate2D(latitude: 24.8281013005, longitude: 55.7839820511),
                             CLLocationCoordinate2D(latitude: 24.8301400845, longitude: 55.7794891809),
                             CLLocationCoordinate2D(latitude: 24.8342175518, longitude: 55.7772427458),
                             CLLocationCoordinate2D(latitude: 24.8362562351, longitude: 55.7727498756),
                             CLLocationCoordinate2D(latitude: 24.8423720836, longitude: 55.7682570054),
                             CLLocationCoordinate2D(latitude: 24.846449148, longitude: 55.7637641352),
                             CLLocationCoordinate2D(latitude: 24.8505260781, longitude: 55.7592712651),
                             CLLocationCoordinate2D(latitude: 24.8525644928, longitude: 55.7547783949),
                             CLLocationCoordinate2D(latitude: 24.8546028738, longitude: 55.7525319598),
                             CLLocationCoordinate2D(latitude: 24.8546028738, longitude: 55.7525319598),
                             CLLocationCoordinate2D(latitude: 24.8566412213, longitude: 55.7502855247),
                             CLLocationCoordinate2D(latitude: 24.8586795352, longitude: 55.7480390896),
                             CLLocationCoordinate2D(latitude: 24.8627560622, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8627560622, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8627560622, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8627560622, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8627560622, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8607178155, longitude: 55.7435462194),
                             CLLocationCoordinate2D(latitude: 24.8607178155, longitude: 55.7435462194),
                             CLLocationCoordinate2D(latitude: 24.8607178155, longitude: 55.7435462194),
                             CLLocationCoordinate2D(latitude: 24.8607178155, longitude: 55.7435462194),
                             CLLocationCoordinate2D(latitude: 24.8607178155, longitude: 55.7435462194),
                             CLLocationCoordinate2D(latitude: 24.8586795352, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8586795352, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8586795352, longitude: 55.7457926545),
                             CLLocationCoordinate2D(latitude: 24.8546028738, longitude: 55.7480390896),
                             CLLocationCoordinate2D(latitude: 24.8505260781, longitude: 55.7502855247),
                             CLLocationCoordinate2D(latitude: 24.8423720836, longitude: 55.7547783949),
                             CLLocationCoordinate2D(latitude: 24.8362562351, longitude: 55.7592712651),
                             CLLocationCoordinate2D(latitude: 24.8281013005, longitude: 55.7637641352),
                             CLLocationCoordinate2D(latitude: 24.8219847471, longitude: 55.7682570054),
                             CLLocationCoordinate2D(latitude: 24.817906877, longitude: 55.7727498756),
                             CLLocationCoordinate2D(latitude: 24.8138288727, longitude: 55.7749963107),
                             CLLocationCoordinate2D(latitude: 24.8097507342, longitude: 55.7772427458),
                             CLLocationCoordinate2D(latitude: 24.8077116146, longitude: 55.7794891809),
                             CLLocationCoordinate2D(latitude: 24.8077116146, longitude: 55.7794891809),
                             CLLocationCoordinate2D(latitude: 24.6711309734, longitude: 55.6707771933),
                             CLLocationCoordinate2D(latitude: 24.5290184872, longitude: 55.560053444)]


let uaeCoordinates = [CLLocationCoordinate2D(latitude: 22.6259761191, longitude: 55.1353571828),
                      CLLocationCoordinate2D(latitude: 22.9349205825, longitude: 52.5920222219),
                      CLLocationCoordinate2D(latitude: 24.1134647816, longitude: 51.5867731984),
                      CLLocationCoordinate2D(latitude: 24.2487662559, longitude: 51.5867731984),
                      CLLocationCoordinate2D(latitude: 24.7436371169, longitude: 52.0262263234),
                      CLLocationCoordinate2D(latitude: 26.555903958, longitude: 56.5031550344),
                      CLLocationCoordinate2D(latitude: 25.0625112468, longitude: 56.9920466359),
                      CLLocationCoordinate2D(latitude: 24.9280867198, longitude: 56.3603327688),
                      CLLocationCoordinate2D(latitude: 24.8832459059, longitude: 56.3108942922),
                      CLLocationCoordinate2D(latitude: 24.8533429825, longitude: 56.2010310109),
                      CLLocationCoordinate2D(latitude: 24.7835413865, longitude: 56.2120173391),
                      CLLocationCoordinate2D(latitude: 24.7536143861, longitude: 56.1515925344),
                      CLLocationCoordinate2D(latitude: 24.7436371169, longitude: 56.0856745656),
                      CLLocationCoordinate2D(latitude: 24.808475042, longitude: 56.0252497609),
                      CLLocationCoordinate2D(latitude: 24.8932119392, longitude: 55.9703181203),
                      CLLocationCoordinate2D(latitude: 24.8932119392, longitude: 56.0417292531),
                      CLLocationCoordinate2D(latitude: 24.962951637, longitude: 56.0417292531),
                      CLLocationCoordinate2D(latitude: 25.0077634497, longitude: 55.9922907766),
                      CLLocationCoordinate2D(latitude: 24.9729112288, longitude: 55.9263728078),
                      CLLocationCoordinate2D(latitude: 24.9679315337, longitude: 55.8494685109),
                      CLLocationCoordinate2D(latitude: 24.9131415924, longitude: 55.8110163625),
                      CLLocationCoordinate2D(latitude: 24.8383888089, longitude: 55.8165095266),
                      CLLocationCoordinate2D(latitude: 24.6737738239, longitude: 55.8439753469),
                      CLLocationCoordinate2D(latitude: 24.6088657034, longitude: 55.8220026906),
                      CLLocationCoordinate2D(latitude: 24.5239350194, longitude: 55.7780573781),
                      CLLocationCoordinate2D(latitude: 24.3438922588, longitude: 55.8384821828),
                      CLLocationCoordinate2D(latitude: 24.2187116648, longitude: 55.8274958547),
                      CLLocationCoordinate2D(latitude: 24.2337398474, longitude: 55.9538386281),
                      CLLocationCoordinate2D(latitude: 24.1635931636, longitude: 55.9648249563),
                      CLLocationCoordinate2D(latitude: 24.0633167611, longitude: 56.0087702688),
                      CLLocationCoordinate2D(latitude: 24.0131491329, longitude: 55.8384821828),
                      CLLocationCoordinate2D(latitude: 24.0583008802, longitude: 55.7945368703),
                      CLLocationCoordinate2D(latitude: 24.0532848031, longitude: 55.7176325734),
                      CLLocationCoordinate2D(latitude: 23.9479019532, longitude: 55.4869196828),
                      CLLocationCoordinate2D(latitude: 23.842432946, longitude: 55.5418513234),
                      CLLocationCoordinate2D(latitude: 23.7720725513, longitude: 55.5308649953),
                      CLLocationCoordinate2D(latitude: 23.7217918078, longitude: 55.5748103078),
                      CLLocationCoordinate2D(latitude: 23.6262049827, longitude: 55.5857966359),
                      CLLocationCoordinate2D(latitude: 23.3692852495, longitude: 55.4210017141),
                      CLLocationCoordinate2D(latitude: 23.0866029506, longitude: 55.2287409719),
                      CLLocationCoordinate2D(latitude: 22.8944431863, longitude: 55.2232478078),
                      CLLocationCoordinate2D(latitude: 22.7982609878, longitude: 55.2287409719),
                      CLLocationCoordinate2D(latitude: 22.696943203, longitude: 55.1957819875),
                      CLLocationCoordinate2D(latitude: 22.6259761191, longitude: 55.1353571828)]
