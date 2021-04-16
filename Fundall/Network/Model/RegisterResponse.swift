//
//  RegisterResponse.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
struct RegisterResponse: Codable {
    let success: RegisterSuccess?
}

// MARK: - Success
struct RegisterSuccess: Codable {
    let message, status: String?
}
