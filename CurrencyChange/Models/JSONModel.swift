//
//  JSONModel.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 05/03/2021.
//

import Foundation

struct DataModel: Codable {
    let data: [CurrencyModel]
}

struct CurrencyModel: Codable, Identifiable {
    let id: String
    let currencyDescription: String
    let reverseUsdQuot: Bool
    let rates: [CurrencyRatesModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case currencyDescription = "description"
        case reverseUsdQuot, rates
    }
}

struct CurrencyRatesModel: Codable {
    let currency: Currency
    let rateDescription: String
    let sellRate, buyRate, sellTransfer, buyTransfer: String?
    
    enum CodingKeys: String, CodingKey {
        case currency
        case rateDescription = "description"
        case sellRate, buyRate, sellTransfer, buyTransfer
    }
}

enum Currency: String, Codable {
    case eur = "EUR"
    case usd = "USD"
}
