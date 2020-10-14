//
//  HTTPService.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

final class HTTPService: NetworkLayer {
    typealias Request = HTTPRequest
    typealias Err = HTTPError
    
    private let session = URLSession(configuration: .default)
    
    func sendRequest<T: Decodable>(_ httpRequest: Request, completion: @escaping NetworkCompletion<T, Err>) {
        let urlRequest: URLRequest
        do {
            urlRequest = try URLRequest.makeFromHTTPRequest(httpRequest)
        } catch {
            return completion(.failure(HTTPError.makeFromError(error)))
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(HTTPError.makeFromError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(HTTPError.noResponseData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(HTTPError.decodingError))
            }
        }
        
        task.resume()
    }
}
