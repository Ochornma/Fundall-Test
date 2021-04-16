//
//  ProfileResponse.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let success: ProfileSuccess?
}

// MARK: - Success
struct ProfileSuccess: Codable {
    let status: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    let firstname, lastname: String?
    let avatar: String?
    let email, totalBalance, income, spent: String?

    enum CodingKeys: String, CodingKey {
        case id, firstname, lastname, avatar, email
        case totalBalance = "total_balance"
        case income, spent
    }
}
