//
//  CurrencyView.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 09/03/2021.
//

import SwiftUI

enum TradeMethod {
    case transfer
    case cash
}

struct CurrencyView: View {
    var currencyModel: CurrencyViewModel
    @State private var methodSwitch: TradeMethod = .cash
    
    var body: some View {
        VStack {
            Picker(selection: $methodSwitch, label: Text("Transfer method")) {
                Text("Cash").tag(TradeMethod.cash)
                Text("Transfer").tag(TradeMethod.transfer)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            List(currencyModel.listData(data: currencyModel.data, method: methodSwitch)) { data in
                let cellModel = CellViewModel(model: data,
                                              currencyType: currencyModel.currency,
                                              method: methodSwitch)
                NavigationLink(destination: CurrencyDetailsView(detailsModel: DetailsViewModel(cellModel: cellModel))) {
                    CurrencyRow(cellModel: cellModel)
                }
            }
          
        }
        .navigationBarHidden(true)
    }
}

struct EuroView_Previews: PreviewProvider {
    static let model = CurrencyModel(id: "AUD", currencyDescription: "Hello Money", reverseUsdQuot: true, rates: [CurrencyRatesModel(currency: .eur, rateDescription: "EURO", sellRate: "12", buyRate: "11.1", sellTransfer: "13.4", buyTransfer: "32.3344")])
    static var previews: some View {
        CurrencyView(currencyModel: CurrencyViewModel(data: [model], currency: .eur))
    }
}
