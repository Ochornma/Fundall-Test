//
//  ApiRouter.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation


enum ApiRouter: URLRequestConvertible {
    
    //login
    case login(email: String, password: String)
    //sign up
    case register(phone: String, code: String, password: String, confirmpassword: String, parentId: String)
    
    
}
