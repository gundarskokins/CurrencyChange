//
//  CurrencyDetailsView.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 10/03/2021.
//

import SwiftUI

struct CurrencyDetailsView: View {
    @ObservedObject var detailsModel: DetailsViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Buy \(detailsModel.cellModel.description)")) {
                    VStack(alignment: .leading) {
                        Text(detailsModel.cellModel.id)
                            .foregroundColor(.candyPink)
                            .fontWeight(.semibold)
                        
                        TextField(detailsModel.cellModel.description, text: $detailsModel.buyAmountString)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                detailsModel.selection = .selectedCurrency
                            }

                        Text(detailsModel.cellModel.rate?.currency.rawValue ?? "")
                            .foregroundColor(.babyBlue)
                            .fontWeight(.semibold)
                        TextField(detailsModel.cellModel.rate?.rateDescription ?? "", text: $detailsModel.buyRateString)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                detailsModel.selection = .eurOrUSD
                            }
                 
                    }
                }
                
                Section(header: Text("Sell \(detailsModel.cellModel.description)")) {
                    VStack(alignment: .leading) {
                        Text(detailsModel.cellModel.id)
                            .foregroundColor(.candyPink)
                            .fontWeight(.semibold)
                        TextField(detailsModel.cellModel.description, text: $detailsModel.sellAmountString)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                detailsModel.selection = .selectedCurrency
                            }
                        
                        Text(detailsModel.cellModel.rate?.currency.rawValue ?? "")
                            .foregroundColor(.babyBlue)
                            .fontWeight(.semibold)
                        TextField(detailsModel.cellModel.rate?.rateDescription ?? "", text: $detailsModel.sellRateString)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                detailsModel.selection = .eurOrUSD
                            }
                            
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarTitle(detailsModel.cellModel.id, displayMode: .inline)
        .onAppear(perform: {
            if let buyString = detailsModel.cellModel.buy, let buy = Double(buyString) {
                detailsModel.amountToBuy = buy
                detailsModel.buy = buy
                detailsModel.buyRateString = buyString
            }
            if let sellString = detailsModel.cellModel.sell, let sell = Double(sellString) {
                detailsModel.amountToBuy = sell
                detailsModel.sell = sell
                detailsModel.sellRateString = sellString
            }
        })
    }
}

struct CurrencyDetailsView_Previews: PreviewProvider {
    static let model = CurrencyModel(id: "AUD", currencyDescription: "Hello Money", reverseUsdQuot: true, rates: [CurrencyRatesModel(currency: .eur, rateDescription: "EURO", sellRate: "12", buyRate: "11.1", sellTransfer: "13.4", buyTransfer: "32.3344")])
    static var previews: some View {
        CurrencyDetailsView(detailsModel: DetailsViewModel(cellModel: CellViewModel(model: model, currencyType: .eur, method: .transfer)))
    }
}
