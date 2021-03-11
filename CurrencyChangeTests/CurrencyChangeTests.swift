//
//  CurrencyChangeTests.swift
//  CurrencyChangeTests
//
//  Created by Gundars Kokins on 05/03/2021.
//

import XCTest
@testable import CurrencyChange

class CurrencyChangeTests: XCTestCase {
    func testDecodeJSON() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "sample", ofType: "json")!
        let jsonResult = Result { try Data(contentsOf: URL(fileURLWithPath: path))}
            .flatMap { result in
                Result { try JSONDecoder().decode(DataModel.self, from: result)}
            }
        
        switch jsonResult {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(_):
                break
        }
    }

    func testNetworkResponse() throws {
        let network = NetworkManager()
        
        let expectation = XCTestExpectation(description: "wait for network")
        network.getData(urlRequest: network.urlRequest) { result in
            let jsonResult = result.flatMap { data in
                Result { try JSONDecoder().decode(DataModel.self, from: Data(data.utf8))}
            }
            switch jsonResult {
                case .success(_):
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
