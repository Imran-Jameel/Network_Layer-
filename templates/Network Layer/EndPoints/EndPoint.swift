//
//  EndPoint.swift
//  templates
//
//  Created by Imran Baloch on 12/07/2021.
//

import Foundation

private let contentType = "application/json"

typealias HTTPHeaders = [String: String]

enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
}

enum APIVersion: String {
    case none = ""
    case v1 = "v1"
}

typealias Path = String

protocol Parameters {
    func asData() -> Data?
    func asQueryItems() -> [URLQueryItem]?
}

extension Parameters {
    func asData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}

extension Dictionary: Parameters where Key == String, Value == Any {
    func asQueryItems() -> [URLQueryItem]? {
        return self.map { URLQueryItem(name: $0, value: "\($1)") }
    }
}

extension Array: Parameters {
    func asQueryItems() -> [URLQueryItem]? {
        /// Arrays cannot be converted to Query Items
        return nil
    }
}


protocol Endpoint {
    var path: Path { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
    var version: APIVersion { get }
    var resourcePath: Path { get }
    var body: Data? { get }
}

struct APIEndPoint: Endpoint {
   
    var resourcePath: Path
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders
    var version: APIVersion
    var hostOverride: String?
    var body: Data?
    
    var path: Path {
        if case .none = self.version { return self.resourcePath }
        return "/" + self.resourcePath
//        return "/" + self.version.rawValue + self.resourcePath
    }
    
    init(method: HTTPMethod = .get,
         resourcePath: Path,
         parameters: Parameters? = nil,
         headers: HTTPHeaders = [:],
         version: APIVersion = .v1,
         hostOverride: String? = nil, body: Data? = nil) {

        self.method = method
        self.resourcePath = resourcePath
        self.parameters = parameters
        self.headers = headers
        self.version = version
        self.hostOverride = hostOverride
        self.body = body
        self.headers = APIEndPoint.generateDefaultHeaders()
    }
}

extension APIEndPoint {
    
    
    
    static func generateDefaultHeaders() -> HTTPHeaders {
        let headers = HTTPHeaders()
        
//        let dateString = DateFormatter.ucc_httpHeaderFormatter.string(from: Date())

//        headers["Content-Type"] = contentType
//        headers["User-Agent"] = UserAgentBuilder.userAgentString()
//        headers["Accept-Language"] = LanguageManager.current.code
//
//        headers["API-DATE"] = dateString
//        headers["API-CLIENT"] = "rGnkS8pmwQ6dxm2E83e5sBrX45pVnXPE" //SuperAppKeys().sTCApiClient
        
        
        
//        if let apiClient = self.buildApiClientHeader(withDateString: dateString) {
//
//            headers["API-CLIENT"] = apiClient
//        }
        
        return headers
    }
}



