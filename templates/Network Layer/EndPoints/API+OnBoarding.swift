//
//  API+OnBoarding.swift
//  templates
//
//  Created by Imran Baloch on 12/07/2021.
//

import Foundation

extension APIEndPoint {
    
    enum OnBoarding {
        
        case login(userName: String, password: String)
        case signUp(userName: String, password: String, email: String)
        
        case getCity(versionCode: String)

        var endPoint: Endpoint {
            
            switch self {
            case .login(let userName, let password):
                return APIEndPoint(method: .get, resourcePath: "Path", parameters: ["userName":userName, "password":password], version: APIVersion.v1, hostOverride: "", body: nil)
            case .signUp(let userName, let password, let email):
                return APIEndPoint(method: .get, resourcePath: "Path", parameters: ["userName":userName, "password":password, "email": email], version: APIVersion.v1, hostOverride: "", body: nil)
                
            case .getCity(let versionCode):
                return APIEndPoint(method: .get, resourcePath: "GetCity", parameters: ["AppVersionCode": versionCode], version: APIVersion.v1, hostOverride: "", body: nil)
            }
        }
    }
}



