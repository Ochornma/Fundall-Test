//
//  NetworkConstants.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation

import Foundation

struct NetworkConstants {
    
    
 
    //The API's base URL
    static let baseUrl = "https://campaign.fundall.io"
   
    //static var token:String = SoftKeyChain.checkForKeychainNil(key: SoftViews.token)
  //  static var token2 = UserDefaults.standard.string(forKey: "token")
    
    
/**
     "user_id": "10",
           "old_password": "12345678",
           "new_password": "23456789",
           "c_new_password": "23456789"
     */
    
    //The parameters (Queries) that we're gonna use
    struct Parameters {
        
        static let firstname = "firstname"
        static let lastname = "lastname"
        static let email = "email"
        static let password = "password"
        static let password_confirmation = "password_confirmation"
        static let avatar = "avatar"

    }
    
    
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}

