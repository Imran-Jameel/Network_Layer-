//
//  URLRequest+Endpoint.swift
//  templates
//
//  Created by Imran Baloch on 12/07/2021.
//

import Foundation

extension URLRequest {
    
    init?(baseURL: URL, endpoint: Endpoint) {
        
        guard let encodedPath = endpoint.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        var url = baseURL.appendingPathComponent(encodedPath)
        
        var body: Data?
        
        switch endpoint.method {
        case .get, .delete:
            if let parameters = endpoint.parameters {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                urlComponents.queryItems = parameters.asQueryItems()
                url = urlComponents.url!
            }
        case .put , .post:
            if let parameters = endpoint.parameters {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                urlComponents.queryItems = parameters.asQueryItems()
                url = urlComponents.url!
                
            }
            if let _body = endpoint.body {
                body = _body
            }
        default:
            if let parameters = endpoint.parameters {
                body = parameters.asData()
                
            }
            
        }
        
        self.init(url: url)
        
        self.httpMethod = endpoint.method.toString
        self.httpBody = body
        
        // Setting the Content-Type header to the default value of application/json only if
        // this header is not provided in the endpoint and if the method is not GET
        if endpoint.headers["Content-Type"] == nil && endpoint.method != .get {
            self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // Applying headers
        endpoint.headers.forEach { self.addValue($1, forHTTPHeaderField: $0) }
    }
}

private extension HTTPMethod {
    var toString: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}

#if DEBUG

extension URLRequest {
    func curlString() -> String {
        guard let url = self.url else {
            return ""
        }
        
        let headerStrings = self.allHTTPHeaderFields?.map({ "--header '\($0.key): \($0.value)'" }) ?? [String]()
        let composedHeaders = headerStrings.joined(separator: " ")
        
        var curl = "curl -i -X \(self.httpMethod ?? "GET") \(composedHeaders)"
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            curl = curl.appending("-d '\(bodyString)'")
        }
        
        return "\(curl) '\(url)'"
    }
}

#endif
