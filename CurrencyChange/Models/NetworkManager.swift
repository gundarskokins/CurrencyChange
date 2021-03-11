//
//  NetworkLayer.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 06/03/2021.
//

import Foundation

class NetworkManager: NetworkProtocol, ObservableObject {
    @Published var dataModel = DataModel(data: [])
    @Published var isLoading = false
    @Published var errorMessage: String?
    let urlSession = URLSession(configuration: .default)
    let bodyData = "type=mobile".data(using: .utf8)
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "mtest.citadele.lv"
        components.path = "/cimo/p/currate"
        components.queryItems = [
            URLQueryItem(name: "language", value: "EN"),
            URLQueryItem(name: "location", value: "LV")
        ]
        
        return components.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url, timeoutInterval: 15)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        request.httpMethod = "POST"
        
        return request
    }
    
    init() {
        isLoading = true
        loadData()
    }
    
    func loadData() {
        getData(urlRequest: urlRequest) { result in
            
            let jsonResult = result.flatMap { data in
                Result { try JSONDecoder().decode(DataModel.self, from: Data(data.utf8))}
            }
            DispatchQueue.main.async {
                switch jsonResult {
                    case .success(let model):
                        self.dataModel = model
                        self.isLoading = false
                    case .failure(let error):
                        if let error = error as? NetworkError {
                            self.errorMessage = error.localizedDescription
                        }
                }
            }
        }
    }
}
