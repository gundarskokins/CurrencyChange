//
//  NetworkProtocol.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 07/03/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURLRequest
    case dataTaskError(description: String)
    case badResponse(statusCode: Int)
    case dataFailure
    case failedToDownload
}

extension NetworkError: LocalizedError {
    public var localizedDescription: String {
        switch self {
            case .invalidURLRequest:
                return "It seems that there is some issue with url"
            case .dataTaskError(description: let description):
                return "No data for you, my friend. Here is the error: \(description)"
            case .badResponse(statusCode: let statusCode):
                return "Wow, we didn't expect this code: \(statusCode)"
            case .dataFailure:
                return "What? This data? No.. try again"
            case .failedToDownload:
                return "Something went wrong. Let's try that again!"
        }
    }
}

protocol NetworkProtocol {
    var urlSession: URLSession { get }
    var urlRequest: URLRequest? { get }
    var url: URL? { get }
    var bodyData: Data? { get }
    
    func getData(urlRequest: URLRequest?, completion: @escaping (Result<String, Error>) -> ())
}

extension NetworkProtocol {
    func getData(urlRequest: URLRequest?, completion: @escaping (Result<String, Error>) -> ()) {
        guard let urlRequest = urlRequest else { return completion(.failure(NetworkError.invalidURLRequest)) }
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(NetworkError.dataTaskError(description: error.localizedDescription)))
            }
            
            guard let response = response as? HTTPURLResponse, 200 ..< 300 ~= response.statusCode else {
                return completion(.failure(NetworkError.failedToDownload))
            }
            
            guard let data = data, let completionString = String(data: data, encoding: .utf8) else {
                return completion(.failure(NetworkError.dataFailure))
            }
            
            completion(.success(completionString))
        }.resume()
    }
}
