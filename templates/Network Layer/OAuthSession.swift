//
//  OAuthSession.swift
//  templates
//
//  Created by Imran Baloch on 12/07/2021.
//

import Foundation

// MARK: - OAuthSession
struct OAuthSession: Codable {
    var id: Int?
    var access_token: String
    var userName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case access_token = "token"
        case userName = "userName"
    }
}

extension OAuthSession {
    
    func asData() -> Data {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(self)
            return encoded
        } catch (let error) {
            fatalError("Unable to encode OAuthSession \(error)")
        }
    }
    
    static func fromData(_ data: Data) -> OAuthSession? {
        return try? JSONDecoder().decode(OAuthSession.self, from: data)
    }
}
