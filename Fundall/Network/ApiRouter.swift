//
//  ApiRouter.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
import Alamofire


enum ApiRouter: URLRequestConvertible {
   
    //login
    case login(email: String, password: String)
    
    //sign up
    case register(firstname: String, lastname: String, password: String, password_confirmation: String, email: String)
    
    case getProfile
    
    
    func asURLRequest() throws -> URLRequest {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let url = try NetworkConstants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.contentType.rawValue)
        urlRequest.setValue("Bearer \(token ?? " ")" , forHTTPHeaderField: NetworkConstants.HttpHeaderField.authentication.rawValue)
        
        let encoding : ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            case .post:
                return JSONEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .getProfile:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .getProfile:
            return "base/profile"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [NetworkConstants.Parameters.email: email, NetworkConstants.Parameters.password: password]
        case .register(let firstname, let lastname, let password, let password_confirmation,let email):
            return [NetworkConstants.Parameters.firstname: firstname, NetworkConstants.Parameters.lastname: lastname, NetworkConstants.Parameters.password: password, NetworkConstants.Parameters.email:email, NetworkConstants.Parameters.password_confirmation: password_confirmation]
        case .getProfile:
            return nil
        }
    }
}
