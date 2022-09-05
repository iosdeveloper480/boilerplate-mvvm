//
//  UserModel.swift
//  Asmaky
//
//  Created by EDS on 23/12/2021.
//

import Foundation

struct UserModel: Codable {
    var success: Bool
    var user: User
    var isFirstTime: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case success = "success",
             user = "user"
    }
    
    func saveUser() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: HConstants.savedUser)
        }
    }
    
    static func getUser() -> UserModel? {
        if let savedPerson = UserDefaults.standard.object(forKey: HConstants.savedUser) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson) {
                return loadedPerson
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func removeUser() {
        UserDefaults.standard.set(nil, forKey: HConstants.savedUser)
    }
    
    static func isLoggedIn() -> Bool {
        return self.getUser() == nil ? false : true
    }
}

/*
 {
     "success": true,
     "user": {
         "id": "2",
         "uid": "",
         "name": "mohamed",
         "img": "N\\A",
         "firebase": "fgkdfjlkgjdflkgjlk",
         "phone": "+971586745257",
         "email": "ali1@gmail.com",
         "gender": "0",
         "dob": "00/00/0000",
         "balance": "0",
         "device": "2",
         "version": "0",
         "lang": "0",
         "block": "0",
         "date": "2022-03-29 17:44:55",
         "notification_date": "2022-03-29 17:44:55",
         "enable": "1"
     }
 }
 
 {
   "success": true,
   "user": {
     "id": "2",
     "uid": "",
     "name": "Waqas Ali",
     "img": "N\\A",
     "firebase": "",
     "phone": "+971527188709",
     "email": " ",
     "gender": "0",
     "dob": "00/00/0000",
     "balance": "0",
     "device": "2",
     "version": "0",
     "lang": "0",
     "block": "0",
     "date": "2022-03-29 17:44:55",
     "notification_date": "2022-03-29 17:44:55",
     "enable": "1"
   }
 }
 */

struct User: Codable {
    
    //    UserDefaults.standard.set(token, forKey: "fcmToken")
    var id: String
    var uid: String
    var name: String
    var img: String
    var firebase: String
    var phone: String
    var email: String
    var balance: String
    var device: String
    var gender: String?
    var birthday: String?
    var version: String
    var lang: String
    var block: String
    var date: String
    var notification_date: String
    var enable: String
    var isAnonymous: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id",
             uid = "uid",
             name = "name",
             img = "img",
             firebase = "firebase",
             phone = "phone",
             email = "email",
             device = "device",
             gender = "gender",
             birthday = "dob",
             balance = "balance",
             version = "version",
             lang = "lang",
             block = "block",
             date = "date",
             notification_date = "notification_date",
             enable
    }
    
    init(id: String,
         uid: String,
         name: String,
         img: String,
         firebase: String,
         phone: String,
         email: String,
         balance: String,
         device: String,
         gender: String,
         birthday: String,
         version: String,
         lang: String,
         block: String,
         date: String,
         notification_date: String,
         enable: String,
         isAnonymous: Bool) {
        
        self.id = id
        self.uid = uid
        self.name = name
        self.img = img
        self.firebase = firebase
        self.phone = phone
        self.email = email
        self.balance = balance
        self.device = device
        self.gender = gender
        self.birthday = birthday
        self.version = version
        self.lang = lang
        self.block = block
        self.date = date
        self.notification_date = notification_date
        self.enable = enable
        self.isAnonymous = isAnonymous
        
    }
    
    init(from decoder: Decoder) throws {
        func get<V: Decodable>(from decoder: Decoder = decoder,
                             _ type: V.Type,
                             forKey: CodingKeys) throws -> V? {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            if let value = try? values.decode(V.self, forKey: forKey) {
                return value
            } else {
                return nil
            }
        }
        self.id = ""
        self.uid = ""
        self.name = ""
        self.img = ""
        self.firebase = ""
        self.phone = ""
        self.email = ""
        self.balance = ""
        self.device = ""
        self.gender = ""
        self.version = ""
        self.lang = ""
        self.block = ""
        self.date = ""
        self.notification_date = ""
        
        if let id = try? get(String.self, forKey: .id) {
            self.id = id
        }
        if let uid = try? get(String.self, forKey: .uid) {
            self.uid = uid
        }
        if let name = try? get(String.self, forKey: .name) {
            self.name = name
        }
        if let img = try? get(String.self, forKey: .img) {
            self.img = img
        }
        if let firebase = try? get(String.self, forKey: .firebase) {
            self.firebase = firebase
        }
        if let phone = try? get(String.self, forKey: .phone) {
            self.phone = phone
        }
        if let email = try? get(String.self, forKey: .email) {
            self.email = email
        }
        if let balance = try? get(String.self, forKey: .balance) {
            self.balance = balance
        }
        if let device = try? get(String.self, forKey: .device) {
            self.device = device
        }
        if let gender = try? get(String.self, forKey: .gender) {
            self.gender = gender
        }
        if let birthday = try? get(String.self, forKey: .birthday) {
            self.birthday = birthday
        } else {
            self.birthday = "00/00/0000"
        }
        if let version = try? get(String.self, forKey: .version) {
            self.version = version
        }
        if let lang = try? get(String.self, forKey: .lang) {
            self.lang = lang
        }
        if let block = try? get(String.self, forKey: .block) {
            self.block = block
        }
        if let date = try? get(String.self, forKey: .date) {
            self.date = date
        }
        if let notification_date = try? get(String.self, forKey: .notification_date) {
            self.notification_date = notification_date
        }
        if let enable = try? get(String.self, forKey: .enable) {
            self.enable = enable
        } else {
            self.enable = "1"
        }
        self.isAnonymous = self.uid == UserDefaults.standard.object(forKey: "anonymousId") as? String ?? ""
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.uid, forKey: .uid)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.img, forKey: .img)
        try container.encode(self.firebase, forKey: .firebase)
        try container.encode(self.phone, forKey: .phone)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.balance, forKey: .balance)
        try container.encode(self.device, forKey: .device)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.birthday, forKey: .birthday)
        try container.encode(self.version, forKey: .version)
        try container.encode(self.lang, forKey: .lang)
        try container.encode(self.block, forKey: .block)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.notification_date, forKey: .notification_date)
        try container.encode(self.enable, forKey: .enable)
//        try container.encode(self.isAnonymous, forKey: .isAnonymous)
        
    }
}
