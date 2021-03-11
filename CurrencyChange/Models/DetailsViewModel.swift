//
//  DetailsViewModel.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 11/03/2021.
//

import Foundation

class DetailsViewModel: ObservableObject {
    enum ValueToChange {
        case selectedCurrency
        case eurOrUSD
    }
    
    var cellModel: CellViewModel
    let formatter = NumberFormatter()

    @Published var selection: ValueToChange = .selectedCurrency
    
    //MARK: buy
    @Published var amountToBuy: Double = 1 {
        didSet {
            guard selection == .selectedCurrency else { return }
            buyRateAmount = amountToBuy / buy
            buyRateString = formatter.string(from: NSNumber(value: buyRateAmount)) ?? ""
        }
    }
    @Published var buyRateAmount: Double = 1 {
        didSet {
            guard selection == .eurOrUSD else { return }
            amountToBuy = buyRateAmount * sell
            buyAmountString = formatter.string(from: NSNumber(value: amountToBuy)) ?? ""
        }
    }
    
    @Published var buyAmountString = "1" {
        didSet {
            guard let buyDouble = Double(buyAmountString) else { return }
            amountToBuy = buyDouble
        }
    }
    
    @Published var buyRateString = "1" {
        didSet {
            guard let buyDouble = Double(buyRateString) else { return }
            buyRateAmount = buyDouble
        }
    }
    
    var buy: Double = 1
    
    //MARK: sell
    @Published var amountToSell: Double = 1 {
        didSet {
            guard selection == .selectedCurrency else { return }
            sellRateAmount = amountToSell / sell
            sellRateString = formatter.string(from: NSNumber(value: sellRateAmount)) ?? ""
        }
    }
    
    @Published var sellRateAmount: Double = 1 {
        didSet {
            guard selection == .eurOrUSD else { return }
            amountToSell = sellRateAmount * sell
            sellAmountString = formatter.string(from: NSNumber(value: amountToSell)) ?? ""
        }
    }
    
    @Published var sellAmountString = "1" {
        didSet {
            guard let sellDouble = Double(sellAmountString) else { return }
            amountToSell = sellDouble
        }
    }
    
    @Published var sellRateString = "1" {
        didSet {
            guard let sellDouble = Double(sellRateString) else { return }
            sellRateAmount = sellDouble
        }
    }
    
    var sell: Double = 1
    
    init(cellModel: CellViewModel) {
        self.cellModel = cellModel
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = cellModel.method == .cash ? 2 : 4
        formatter.decimalSeparator = "."
    }
}
