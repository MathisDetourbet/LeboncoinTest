//
//  HTTPService.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

final class HTTPService: NetworkLayer {
    private static let successCodeRange = 200..<300
    private let session = URLSession(configuration: .default)
    
    func sendRequest<T: Decodable>(_ httpRequest: NetworkRequest, completion: @escaping NetworkCompletion<T>) {
        guard let httpRequest = httpRequest as? HTTPRequest else {
            completion(.failure(HTTPError.badRequest))
            return
        }
        
        let urlRequest: URLRequest
        do {
            urlRequest = try URLRequest.makeFromHTTPRequest(httpRequest)
        } catch let nsError as NSError {
            return completion(.failure(HTTPError.makeFromNSError(nsError)))
        }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            // HTTP request will always respond with a response of type HTTPURLResponse
            let httpResponse = response as! HTTPURLResponse
            
            // Check if request failed
            if let error = error {
                if !HTTPService.successCodeRange.contains(httpResponse.statusCode) {
                    completion(.failure(HTTPError.makeFromHTTPURLResponse(httpResponse)))
                } else {
                    completion(.failure(HTTPError.makeFromNSError(error as NSError)))
                }
                return
            }
            
            // Check if we've got data
            guard let data = data else {
                completion(.failure(HTTPError.noResponseData))
                return
            }
            
            // Decode json to object
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
