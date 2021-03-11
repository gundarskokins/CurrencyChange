//
//  CellViewModel.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 10/03/2021.
//

import Foundation

struct CellViewModel {
    var id: String
    var description: String
    var buy: String?
    var sell: String?
    var rate: CurrencyRatesModel?
    var method: TradeMethod
    
    init(model: CurrencyModel, currencyType: Currency, method: TradeMethod) {
        id = model.id
        description = model.currencyDescription
        rate = model.rates.filter { $0.currency == currencyType }.first
        self.method = method
        switch method {
            case .cash:
                buy = rate?.buyRate
                sell = rate?.sellRate
            case .transfer:
                buy = rate?.buyTransfer
                sell = rate?.sellTransfer
        }
    }
}
