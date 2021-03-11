//
//  ContentView.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 05/03/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    var body: some View {
        VStack {
            if networkManager.isLoading {
                ProgressView()
                    .scaleEffect(2, anchor: .center)
            } else {
                NavigationView {
                    TabView {
                        CurrencyView(currencyModel: CurrencyViewModel(data: networkManager.dataModel.data, currency: .eur))
                            .tabItem {
                                Image(systemName: "eurosign.square.fill")
                                Text("EUR")
                            }
                        
                        CurrencyView(currencyModel: CurrencyViewModel(data: networkManager.dataModel.data, currency: .usd))
                            .tabItem {
                                Image(systemName: "dollarsign.square.fill")
                                Text("USD")
                            }
                        
                    }
                    .accentColor(.babyBlue)
                }
                .navigationBarHidden(true)

            }
        }
        .alert(item: $networkManager.errorMessage) { message in
            Alert(title: Text("Ooops..."), message: Text(message), dismissButton: .default(Text("Try again!"), action: {
                networkManager.loadData()
            })
            )}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


