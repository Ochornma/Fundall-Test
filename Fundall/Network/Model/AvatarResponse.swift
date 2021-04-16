//
//  AvatarResponse.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
// MARK: - AvatarResponse
struct AvatarResponse: Codable {
    let success: AvatarSuccess?
}

// MARK: - Success
struct AvatarSuccess: Codable {
    let status: String?
    let url: String?
    let message: String?
}
