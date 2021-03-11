//
//  CurrencyRow.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 10/03/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var cellModel: CellViewModel
    @State private var isZoomed = false
    var frame: CGFloat {
        isZoomed ? 200 : 44
    }
    @Namespace private var animation

    var body: some View {
        HStack {
            Text(cellModel.id)
                .fontWeight(.semibold)
                .foregroundColor(.candyPink)
                .font(.system(size: 20))
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    if let buy = cellModel.buy {
                        Text("Buy:")
                        Text(buy)
                    }
                }
                HStack {
                    if let sell = cellModel.sell {
                        Text("Sell:")
                        Text(sell)
                    }
                }
            }
        }
    }
}
    
struct CurrencyRow_Previews: PreviewProvider {
    static let model = CurrencyModel(id: "AUD", currencyDescription: "Hello Money", reverseUsdQuot: true, rates: [CurrencyRatesModel(currency: .eur, rateDescription: "EURO", sellRate: "12", buyRate: "11.1", sellTransfer: "13.4", buyTransfer: "32.3344")])
    static var previews: some View {
        CurrencyRow(cellModel: CellViewModel(model: model, currencyType: .eur, method: .cash))
    }
}


