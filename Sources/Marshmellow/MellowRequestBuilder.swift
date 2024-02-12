//  Created by Jatin Menghani on 12/02/24.

import Foundation

public class MellowRequestBuilder: MellowRequestProtcol {
    
    private var baseURL: URL
    private var path: String
    private var method: MellowHttpMethod = .get
    private var scheme: String = "https"
    private var headers: [String: String]?
    private var parameters: MellowRequestParams?
    
    public required init(baseURL: URL, path: String, scheme: String = "https") {
        self.baseURL = baseURL
        self.path = path
        self.scheme = scheme
    }
    
    public init(baseURL: URL, path: String, method: MellowHttpMethod = .get, scheme: String = "https", headers: [String : String]? = nil, parameters: MellowRequestParams? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.scheme = scheme
        self.headers = headers
        self.parameters = parameters
    }
    
    public func set(method: MellowHttpMethod) -> Self {
        self.method = method
        return self
    }
    
    public func set(path: String) -> Self {
        self.path = path
        return self
    }
    
    public func set(scheme: String) -> Self {
        self.scheme = scheme
        return self
    }
    
    public func set(headers: [String : String]?) -> Self {
        self.headers = headers
        return self
    }
    
    public func set(parameters: MellowRequestParams) -> Self {
        self.parameters = parameters
        return self
    }
        
    public func buildRequest() -> (request: URLRequest?, error: MellowError?) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path + path
        
        if case .url(let urlParams) = parameters, let params = urlParams {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            return (nil, .invalidURL(urlComponents.url))
        }
        
        print("Full url -> \(url)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if let parameters = parameters {
            switch parameters {
            case .body(let bodyParams):
                if let bodyParams = bodyParams {
                    urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams)
                }
            default:
                break
            }
        }
        return (urlRequest, nil)
    }
}
