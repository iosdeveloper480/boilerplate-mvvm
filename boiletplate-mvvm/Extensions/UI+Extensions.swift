//
//  UI+Extensions.swift
//  Asmaky
//
//  Created by Waqas Ali on 14/11/2021.
//

import UIKit
import TTGSnackbar
import LanguageManager_iOS

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}

extension Double {
    func roundedDecimal(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var decimalValue = Decimal(self)
        var result = Decimal()
        NSDecimalRound(&result, &decimalValue, scale, mode)
        return result
    }
}
@IBDesignable extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ?
                                                            self.placeholder! : "",
                                                            attributes:[NSAttributedString.Key.foregroundColor : newValue!])
        }
    }
}
extension UITextView: UITextViewDelegate {
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                self.resizePlaceholder()
                placeholderLabel.text = newValue
//                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            
            if LanguageManager.shared.currentLanguage == .ar {
                placeholderLabel.textAlignment = .right
            } else {
                placeholderLabel.textAlignment = .left
            }
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
    func detectRightToLeft() {
        if let text = self.text, !text.isEmpty {
            let tagschemes = NSArray(objects: NSLinguisticTagScheme.language)
            let tagger = NSLinguisticTagger(tagSchemes: tagschemes as! [NSLinguisticTagScheme], options: 0)
            tagger.string = text
            
            let language = tagger.tag(at: 0, scheme: NSLinguisticTagScheme.language, tokenRange: nil, sentenceRange: nil)
            if language?.rawValue.range(of: "he") != nil || language?.rawValue.range(of: "ar") != nil || language?.rawValue.range(of: "fa") != nil {
                self.text = text.replacingOccurrences(of: "\n", with: "\n")
                self.textAlignment = .right
                self.makeTextWritingDirectionRightToLeft(nil)
            } else {
                self.textAlignment = .left
                self.makeTextWritingDirectionLeftToRight(nil)
            }
        }
    }
}
extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
            let attributedString = NSMutableAttributedString(attributedString: self)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.lineSpacing = spacing
            attributedString.addAttribute(.paragraphStyle,
                                  value: paragraphStyle,
                                  range: NSRange(location: 0, length: string.count))
            return NSMutableAttributedString(attributedString: attributedString)
    }
}
extension String {
    static func emojiFlag(for countryCode: String) -> String! {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }
        
        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))
            
            // 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
            // 0x61 marks the start of the lowercase ASCII alphabet: 'a'
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }
        
        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }
        
        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
    
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    public enum DateFormatType {
        
        /// The ISO8601 formatted year "yyyy" i.e. 1997
        case isoYear
        
        /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
        case isoYearMonth
        
        /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
        case isoDate
        
        /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
        case isoDateTime
        
        /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
        case isoDateTimeSec
        
        /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
        case isoDateTimeMilliSec
        
        /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
        case dotNet
        
        /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
        case rss
        
        /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
        case altRSS
        
        /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
        case httpHeader
        
        /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
        case standard
        
        /// A custom date format string
        case custom(String)
        
        /// The local formatted date and time "yyyy-MM-dd HH:mm:ss" i.e. 1997-07-16 19:20:00
        case localDateTimeSec
        
        /// The local formatted date  "yyyy-MM-dd" i.e. 1997-07-16
        case localDate
        
        /// The local formatted  time "hh:mm a" i.e. 07:20 am
        case localTimeWithNoon
        
        /// The local formatted date and time "yyyyMMddHHmmss" i.e. 19970716192000
        case localPhotoSave
        
        case birthDateFormatOne
        
        case birthDateFormatTwo
        
        ///
        case messageRTetriveFormat
        
        ///
        case emailTimePreview
        
        var stringFormat:String {
            switch self {
                //handle iso Time
            case .birthDateFormatOne: return "dd/MM/YYYY"
            case .birthDateFormatTwo: return "dd-MM-YYYY"
            case .isoYear: return "yyyy"
            case .isoYearMonth: return "yyyy-MM"
            case .isoDate: return "yyyy-MM-dd"
            case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
            case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
            case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            case .dotNet: return "/Date(%d%f)/"
            case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
            case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
            case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
            case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
            case .custom(let customFormat): return customFormat
                
                //handle local Time
            case .localDateTimeSec: return "yyyy-MM-dd HH:mm:ss"
            case .localTimeWithNoon: return "hh:mm a"
            case .localDate: return "yyyy-MM-dd"
            case .localPhotoSave: return "yyyyMMddHHmmss"
            case .messageRTetriveFormat: return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            case .emailTimePreview: return "dd MMM yyyy, h:mm a"
            }
        }
    }
    
    func toDate(_ format: DateFormatType = .isoDate) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        let date = dateFormatter.date(from: self)
        return date
    }
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    var encodeEmoji: String {
        if let encodeStr = NSString(cString: self.cString(using: .nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue) {
            return encodeStr as String
        }
        return self
    }
    
    var decodeEmoji: String {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false);
        let decodedStr = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decodedStr {
            return str as String
        }
        return self
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let attributedString = try NSMutableAttributedString(data: data,
                                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                                           .characterEncoding:String.Encoding.utf8.rawValue],
                                                                 documentAttributes: nil)
            return attributedString.withLineSpacing(5)
        } catch {
            return NSAttributedString()
        }
    }
    func htmlToAttributedString(fontName: String = "SFUIDisplay", fontSize: Float = 72) -> NSAttributedString? {
        let style = "<style>body { font-family: '\(fontName)'; font-size:\(fontSize)px; }</style>"
        guard let data = (self + style).data(using: .utf8) else {
            return nil
        }
        do {
            let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString//?.withLineSpacing(6)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        if self.isValidHtmlString(self) {
            return htmlToAttributedString?.string ?? ""
        } else {
            return self
        }
    }
    
    var language: String? {
        return NSLinguisticTagger.dominantLanguage(for: self)
    }
    
    func isValidHtmlString(_ value: String) -> Bool {
        if value.isEmpty {
            return false
        }
        return (value.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    var localized: String {
        if LanguageManager.shared.currentLanguage == .ar {
            return self.localiz()
        }
        return self
        
    }
    
    var twoPointDecimalValue: String {
        if let doubleValue = Double(self) {
            return String(format: "%.2f", doubleValue)
        }
        return ""
    }
    
    var doubleValue: Double {
        
        let doubleString = Double(self.twoPointDecimalValue) ?? 0.00
        return doubleString.roundTo(places: 2)
        
    }
    
    var doubleStringValue:String {
        return String(format: "%.2f", self.doubleValue)
    }
    
    
}

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension UIViewController: Storyboarded {
    func showLogoutAlert(logOutAction: @escaping () -> Void) {
        let alert = UIAlertController(title: HLocalized().menu_logout,
                                      message: HLocalized().logouttext,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: HLocalized().cancel,
                                      style: .cancel,
                                      handler: { action in
            //            cancelAction()
        }))
        alert.addAction(UIAlertAction(title: HLocalized().menu_logout,
                                      style: .default,
                                      handler: { action in
            logOutAction()
        }))
        self.present(alert, animated: true) {
            
        }
    }
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardSize.height, right: scrollView.contentInset.right)
            
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
    
    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: 0, right: scrollView.contentInset.right)
            
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
    
}

extension UIScrollView {
    
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}


extension Int {
    var boolValue: Bool { return self != 0 }
}



extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
extension UINavigationController {
    
    func setNavigationBarColor(color : UIColor){
        self.navigationBar.barTintColor = color
    }
    
    func setStatusBar(backgroundColor: UIColor) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

            let statusbarView = UIView()
            statusbarView.backgroundColor = backgroundColor
            statusbarView.layer.zPosition = 999999
            view.addSubview(statusbarView)

            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setNavigationBar(backgroundColor: UIColor = HConstants.Theme.Colors.AppColor) {
        self.setStatusBar(backgroundColor: backgroundColor)
        
        self.navigationBar.largeContentImage = nil
        self.navigationBar.shadowImage = nil
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.isTranslucent = false
        self.navigationBar.backgroundColor = backgroundColor
    }
    
    func tranceparentNavBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = UIColor.clear
        self.edgesForExtendedLayout = .top
    }
    
    func showNavigation() {
        navigationBar.backgroundColor = HConstants.Theme.Colors.AppColor
        navigationBar.tintColor = HConstants.Theme.Colors.ColorWhite
    }
    
    func hideNavigation() {
        navigationBar.tintColor = HConstants.Theme.Colors.AppColor
        navigationBar.backgroundColor = .clear
    }
}
extension UIView {
    func diagonalStrikeThrough(offsetPercent: CGFloat = 0.1) {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: bounds.height * (1 - offsetPercent)))
        linePath.addLine(to: CGPoint(x: bounds.width, y: bounds.height * offsetPercent))
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 2
        layer.addSublayer(lineLayer)
    }
    func blink() {
        self.isUserInteractionEnabled = true
        self.alpha = 0.2
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
    func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10, dampingRatio: CGFloat = 0.3) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: dampingRatio) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.startAnimation()
    }
    func subviews<T:Any>(ofType WhatType:T.Type) -> [T] {
        var result = self.subviews.compactMap {$0 as? T}
        for sub in self.subviews {
            result.append(contentsOf: sub.subviews(ofType:WhatType))
        }
        return result
    }
    // ->1
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        
        if let sublayers = layer.sublayers, !sublayers.isEmpty, let sublayer = sublayers.first {
            layer.replaceSublayer(sublayer, with: gradient)
        } else {
            layer.addSublayer(gradient)
        }
    }
    func startShimmeringAnimation(animationSpeed: Float = 1.4,
                                  direction: Direction = .leftToRight,
                                  repeatCount: Float = MAXFLOAT) {
        
        // Create color  ->2
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = HConstants.Theme.Colors.ColorBlack
        
        // Create a CAGradientLayer  ->3
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
        self.layer.mask = gradientLayer
        
        // Add animation over gradient Layer  ->4
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }
    
    func stopShimmeringAnimation() {
        self.layer.mask = nil
    }
    
    public func showToast(message:String, duration:Int = 2000) {
        
        let toastLabel = PaddingLabel()
        toastLabel.padding(top: 10, bottom: 10, left: 10, right: 10)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false;
        toastLabel.backgroundColor = UIColor.darkGray;
        toastLabel.textColor = UIColor.white;
        toastLabel.textAlignment = .center;
        toastLabel.text = message;
        toastLabel.numberOfLines = 0;
        toastLabel.alpha = 0.9;
        toastLabel.layer.cornerRadius = 20;
        toastLabel.clipsToBounds = true;
        
        self.addSubview(toastLabel);
        
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.left, relatedBy:.greaterThanOrEqual, toItem:self, attribute:.left, multiplier:1, constant:20));
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.right, relatedBy:.lessThanOrEqual, toItem:self, attribute:.right, multiplier:1, constant:-20));
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.bottom, relatedBy:.equal, toItem:self, attribute:.bottom, multiplier:1, constant:-20));
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0));
        
        UIView.animate(withDuration:0.5, delay:Double(duration) / 1000.0, options:[], animations: {
            
            toastLabel.alpha = 0.0;
            
        }) { (Bool) in
            
            toastLabel.removeFromSuperview();
        }
    }
    
    public func snakeBar(_ input:String,_ success:Bool, duration: TTGSnackbarDuration = .middle) {
        let snackbar = TTGSnackbar(message: input, duration: duration)
        snackbar.messageTextColor = .white
        snackbar.messageTextAlign = .justified
        snackbar.shouldDismissOnSwipe = true
        snackbar.onTapBlock = { snackbar in
            snackbar.dismiss()
        }
        if LanguageManager.shared.currentLanguage == .ar {
            snackbar.messageTextAlign = .right
        } else {
            snackbar.messageTextAlign = .left
        }
        self.isUserInteractionEnabled = false
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.isUserInteractionEnabled = true
        }
        if success == true {
            snackbar.backgroundColor = #colorLiteral(red: 0, green: 0.4741178751, blue: 0, alpha: 1)
            snackbar.icon = UIImage(named: "ic_check")?.withRenderingMode(.alwaysTemplate)
        }else{
            snackbar.icon = UIImage(named: "ic_cross")?.withRenderingMode(.alwaysTemplate)
            snackbar.backgroundColor = .red
        }
        snackbar.iconTintColor = .white
        
        snackbar.messageTextFont = UIFont.init(name: AppFontName.regular, size: 16)!
        snackbar.show()
    }
    public func warningSnakeBar(_ input:String, duration: TTGSnackbarDuration = .middle, animationType: TTGSnackbarAnimationType = .slideFromBottomBackToBottom) {
        let snackbar = TTGSnackbar(message: input, duration: duration)
        snackbar.messageTextColor = .white
        snackbar.messageTextAlign = .justified
        snackbar.shouldDismissOnSwipe = true
        snackbar.animationType = animationType
        snackbar.onTapBlock = { snackbar in
            snackbar.dismiss()
        }
        if LanguageManager.shared.currentLanguage == .ar {
            snackbar.messageTextAlign = .right
        } else {
            snackbar.messageTextAlign = .left
        }
        self.isUserInteractionEnabled = false
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.isUserInteractionEnabled = true
        }
        snackbar.icon = UIImage(named: "ic_cross")?.withRenderingMode(.alwaysTemplate)
        snackbar.backgroundColor = HConstants.Theme.Colors.ColorDarkGray
        snackbar.iconTintColor = .white
        
        snackbar.messageTextFont = UIFont.init(name: AppFontName.regular, size: 16)!
        snackbar.show()
    }
    public func snakeBar(_ input:String,
                         with color: UIColor = UIColor.red,
                         duration: TTGSnackbarDuration = .middle) {
        let snackbar = TTGSnackbar(message: input,
                                   duration: duration)
        snackbar.messageTextColor = .white
        snackbar.messageTextAlign = .justified
        if LanguageManager.shared.currentLanguage == .ar {
            snackbar.messageTextAlign = .right
        } else {
            snackbar.messageTextAlign = .left
        }
//        snackbar.duration = TTGSnackbarDuration(rawValue: Int(5))!
        self.isUserInteractionEnabled = false
        _ = Timer.scheduledTimer(withTimeInterval: 1,
                                 repeats: false) { timer in
            self.isUserInteractionEnabled = true
        }
        snackbar.icon = UIImage(named: "ic_cross")?.withRenderingMode(.alwaysTemplate)
        snackbar.backgroundColor = color
        snackbar.iconTintColor = .white
        
        snackbar.messageTextFont = UIFont.init(name: AppFontName.regular,
                                               size: 16)!
        snackbar.show()
    }
    func roundCorners(corners: UIRectCorner,
                      radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func round(corners: CACornerMask,
               radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    func cornerRadius(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
    func border(width: CGFloat, color: UIColor,
                cornerRadius: CGFloat = 0.0) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.cornerRadius(cornerRadius: cornerRadius)
    }
    func border(width: CGFloat,
                color: UIColor,
                maskedCorners: CACornerMask,
                radius: CGFloat = 0.0) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.round(corners: maskedCorners,
                   radius: radius)
    }
    
    func border(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func shadow(shadowColor: UIColor,
                shadowOffset: CGSize,
                shadowRadius: CGFloat,
                shadowOpacity: Float) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        layer.maskedCorners = [.layerMinXMinYCorner,
                               .layerMaxXMaxYCorner,
                               .layerMaxXMinYCorner,
                               .layerMinXMaxYCorner]
    }
    func shadow(shadowColor: UIColor,
                shadowOffset: CGSize,
                shadowRadius: CGFloat,
                shadowOpacity: Float,
                maskedCorners: CACornerMask) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        layer.maskedCorners = maskedCorners
    }
}


extension CATransition {
    
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
    //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}

extension Decodable {
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        self = try decoder.decode(Self.self, from: data)
    }
}

extension UICollectionView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if LanguageManager.shared.currentLanguage == .ar {
            self.semanticContentAttribute = .forceRightToLeft
        }else{
            self.semanticContentAttribute = .forceLeftToRight
        }
    }
}
extension UICollectionViewFlowLayout {
    
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        if LanguageManager.shared.currentLanguage == .ar {
            return true
        }else{
            return false
        }
    }
    
}
extension UIImageView {
    func scaleCenterToFit(){
        self.autoresizingMask = [.flexibleBottomMargin , .flexibleHeight , .flexibleRightMargin , .flexibleLeftMargin , .flexibleTopMargin , .flexibleWidth]
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    func scaleCenterToFill(){
        self.autoresizingMask = [.flexibleWidth ,.flexibleHeight, .flexibleBottomMargin , .flexibleRightMargin , .flexibleLeftMargin , .flexibleTopMargin]
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
    }
    
}
extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL? = URL(string: gifUrl)
        else {
            print("image named \"\(gifUrl)\" doesn't exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL!) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)
        
        return animation
    }
    func resizedImage(Size sizeImage: CGSize) -> UIImage? {
        let frame = CGRect(origin: CGPoint.zero,
                           size: CGSize(width: sizeImage.width,
                                        height: sizeImage.height))
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        self.draw(in: frame)
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.withRenderingMode(.alwaysOriginal)
        return resizedImage
    }
    
    enum Format: String {
        case png = "png"
        case jpeg = "jpeg"
    }
    
    func toBase64(type: Format = .jpeg,
                  quality: CGFloat = 1,
                  addMimePrefix: Bool = false) -> String? {
        let imageData: Data?
        switch type {
        case .jpeg: imageData = jpegData(compressionQuality: quality)
        case .png:  imageData = pngData()
        }
        guard let data = imageData else { return nil }
        
        let base64 = data.base64EncodedString()
        
        var result = base64
        if addMimePrefix {
            let prefix = "data:image/\(type.rawValue);base64,"
            result = prefix + base64
        }
        return result
    }
    
    func getPixelColor(atLocation location: CGPoint, withFrameSize size: CGSize) -> UIColor {
        let x: CGFloat = (self.size.width) * location.x / size.width
        let y: CGFloat = (self.size.height) * location.y / size.height
        
        let pixelPoint: CGPoint = CGPoint(x: x, y: y)
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelIndex: Int = ((Int(self.size.width) * Int(pixelPoint.y)) + Int(pixelPoint.x)) * 4
        
        let r = CGFloat(data[pixelIndex]) / CGFloat(255.0)
        let g = CGFloat(data[pixelIndex+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelIndex+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelIndex+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

extension UITableView {
    
    var autolayoutTableViewHeader: UIView? {
        set {
            self.tableHeaderView = newValue
            guard let header = newValue else { return }
            header.setNeedsLayout()
            header.layoutIfNeeded()
            header.frame.size =
            header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            self.tableHeaderView = header
        }
        get {
            return self.tableHeaderView
        }
    }
    
    var autolayoutTableViewFooter: UIView? {
        set {
            self.tableFooterView = newValue
            guard let footer = newValue else { return }
            footer.setNeedsLayout()
            footer.layoutIfNeeded()
            footer.frame.size =
            footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            self.tableFooterView = footer
        }
        get {
            return self.tableFooterView
        }
    }
}



extension Decodable {
    /// Sweeter: Create object from a dictionary
    public init?(dictionary: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else { return nil }
        guard let decodedSelf = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = decodedSelf
    }
}

extension Encodable {
    /// Sweeter: Export object to a dictionary representation
    public var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension UIApplication {
    /// Sweeter: `keyWindow` for scene-based apps
    public var legacyKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return windows.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }
    
    /// Sweeter: Returns the currently top-most view controller.
    public class func topViewController(base: UIViewController? = UIApplication.shared.legacyKeyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    /// Sweeter: Show `viewController` over the top-most view controller.
    public class func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            topViewController()?.present(viewController, animated: animated, completion: completion)
        }
    }
}


extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

extension UICollectionView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}


extension Notification.Name {
    static let searchDriverAgain = Notification.Name("NSNotification.Name.SearchDriverAgain")
    static let sendMessage = Notification.Name("NSNotification.Name.SendMessage")
}
