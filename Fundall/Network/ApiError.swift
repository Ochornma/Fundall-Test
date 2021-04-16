//
//  ApiError.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
enum ApiError: Error {
    case error              //Status code 400
    case unauthenticated //stsatus code 401
    case notFound(message: String)  
}
