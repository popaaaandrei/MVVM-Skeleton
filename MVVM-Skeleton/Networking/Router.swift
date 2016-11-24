//
//  Router.swift
//  MVVM-Skeleton
//
//  Created by andrei on 23/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//


import Foundation
import Alamofire
import RxSwift
import SwiftyJSON



enum Router : Alamofire.URLRequestConvertible {
    
    static let baseURL = "http://127.0.0.1:8080/v1"
    
    case auth(email: String, password: String)
    
    
    var path: String {
        switch self {
        case .auth: return "auth"
        }
    }
    

    var method: HTTPMethod {
        switch self {
        case .auth: return .post
        }
    }
    
    
    // endpoint parameters
    var parameters: [String : Any]? {
        switch self {
        case let .auth(email, password):
            return ["email": email, "password": password]
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        
        let url = try Router.baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }

}



/// abstraction of networking call into Rx Observable
public func rx_request(_ request: Alamofire.URLRequestConvertible) -> Observable<JSON> {
    
    return Observable.create { observer in
        
        let alamofireRequest = Alamofire.request(request)

            .responseData { response in
                
                switch response.result {
                case let .success(data):
                    
                    var jsonError : NSError?
                    let json = JSON(data: data, error: &jsonError)
                    
                    // any possible conversion error
                    if let jsonError = jsonError {
                        observer.on(.error(jsonError))
                    }
                    
                    // check for errors
                    if let message = json.error() {
                        observer.on(.error(MyError.serverError(message: message)))
                    }
  
                    observer.on(.next(json))
                    observer.on(.completed)
                    
                case let .failure(error):
                    observer.on(.error(error))
                }
            }
        
        alamofireRequest.resume()
        
        return Disposables.create {
            alamofireRequest.cancel()
        }
        
    }
    
}



extension SwiftyJSON.JSON {
    
    func error() -> String? {
        
        /*
            "message" : "A valid account could not be found!",
            "code" : 10005,
            "error" : 1
        */
        
        if let _ = self["error"].int, let message = self["message"].string {
            return message
        }

        return nil
    }
    
}

