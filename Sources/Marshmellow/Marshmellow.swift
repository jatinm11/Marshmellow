//  Created by Jatin Menghani on 12/02/24.

import UIKit

public protocol MellowNetworkProtocol {
    func makeRequest<T: Decodable>(with builder: MellowRequestBuilder, type: T.Type, completion: @escaping (Result<T, MellowError>) -> Void)
}

public class Marshmellow: MellowNetworkProtocol {
    
    public init() {}
    
    private var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
        
    public func setKeyDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) {
        self.keyDecodingStrategy = strategy
    }
    
    public func makeRequest<T: Decodable>(with builder: MellowRequestBuilder, type: T.Type, completion: @escaping (Result<T, MellowError>) -> Void) {
        
        guard let request = builder.buildRequest().request else { completion(.failure(builder.buildRequest().error!)); return }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(MellowError.unableToComplete))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(MellowError.invalidResponse(response as? HTTPURLResponse)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(MellowError.statusCode(httpResponse.statusCode)))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(MellowError.invalidData(data)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = self.keyDecodingStrategy
                let decodedObject = try decoder.decode(T.self, from: responseData)
                completion(.success(decodedObject))
            } 
            catch {
                completion(.failure(.invalidData(data)))
            }
        }
        
        dataTask.resume()
    }
}
