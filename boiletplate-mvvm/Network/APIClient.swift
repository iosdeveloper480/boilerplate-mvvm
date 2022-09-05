//
//  APIClient.swift
//  Asmaky
//
//  Created by EDS on 23/12/2021.
//

import Foundation
import Alamofire
import Combine

class APIClient {
    
    static let shared = APIClient()
    typealias completionHandler<V> = (DataResponse<V, AFError>) -> Void
    var cancellables = Set<AnyCancellable>()
    
    private(set) var AF: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["API_URL": DisabledTrustEvaluator(), "fcm.googleapis.com": DisabledTrustEvaluator()])
        let session = Session(serverTrustManager: manager)
        return session
    }()
    
    func get<V: Decodable>(model: V.Type,
                           endPoint: EndPoints,
                           params: [String: Any]?,
                           completionHandler: @escaping completionHandler<V>) {
        self.combineAPICall(model: model,
                            method: .get,
                            endPoint: endPoint,
                            params: params,
                            completionHandler: completionHandler)
    }
    
    func post<V: Decodable>(model: V.Type,
                            endPoint: EndPoints,
                            params: [String: Any]?,
                            completionHandler: @escaping completionHandler<V>) {
        self.combineAPICall(model: model,
                            method: .post,
                            endPoint: endPoint,
                            params: params,
                            completionHandler: completionHandler)
    }
    
    func post<V: Decodable>(model: V.Type,
                            url: String,
                            headers: HTTPHeaders?,
                            params: [String: Any]?,
                            completionHandler: @escaping completionHandler<V>) {
        self.combineAPICallWithURL(model: model,
                                   method: .post,
                                   url: url,
                                   headers: headers,
                                   params: params,
                                   completionHandler: completionHandler)
    }
    
    func put<V: Decodable>(model: V.Type,
                           endPoint: EndPoints,
                           params: [String: Any]?,
                           completionHandler: @escaping completionHandler<V>) {
        self.combineAPICall(model: model,
                            method: .put,
                            endPoint: endPoint,
                            params: params,
                            completionHandler: completionHandler)
    }
    
    private func combineAPICall<V: Decodable>(model: V.Type,
                                              method: HTTPMethod,
                                              endPoint: EndPoints,
                                              params: [String: Any]?,
                                              completionHandler: @escaping completionHandler<V>) {
        let urlString = HConstants.baseUrl + endPoint.rawValue
        
        let tokenHeader = HTTPHeader(name: "token",
                                     value: HConstants.apiToken)
        let request = AF.request(urlString,
                                 method: method,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: [tokenHeader])
        
        request.publishDecodable(type: V.self)
            .sink(receiveValue: completionHandler)
            .store(in: &cancellables)
    }
    
    private func combineAPICallWithURL<V: Decodable>(model: V.Type,
                                                     method: HTTPMethod,
                                                     url: String,
                                                     headers: HTTPHeaders?,
                                                     params: [String: Any]?,
                                                     completionHandler: @escaping completionHandler<V>) {
        
        let request = AF.request(url,
                                 method: method,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        request.publishDecodable(type: V.self)
            .sink(receiveValue: completionHandler)
            .store(in: &cancellables)
    }
}

enum EndPoints: String {
    case user = "user.php",
         index = "index.php"
}
