//
//  RegisterResponse.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
struct RegisterResponse: Codable {
    let success: Success?
}

// MARK: - Success
struct Success: Codable {
    let message, status: String?
}
