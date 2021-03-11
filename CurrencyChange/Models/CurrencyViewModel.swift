//
//  CurrencyViewModel.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 10/03/2021.
//

import Foundation

struct CurrencyViewModel {
    var data: [CurrencyModel]
    var currency: Currency
    
    func listData(data: [CurrencyModel], method: TradeMethod) -> [CurrencyModel] {
        data.filter {
            switch method {
                case .cash:
                    return $0.rates.contains(where: { $0.currency == currency && $0.buyRate != nil && $0.sellRate != nil })
                case .transfer:
                    return $0.rates.contains(where: { $0.currency == currency && $0.buyTransfer != nil && $0.sellTransfer != nil })
            }
        }
    }
}
