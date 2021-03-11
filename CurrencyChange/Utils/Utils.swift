//
//  Utils.swift
//  CurrencyChange
//
//  Created by Gundars Kokins on 11/03/2021.
//

import SwiftUI

extension Color {
    public static var candyPink = Color.init(red: 244/255, green: 180/255, blue: 192/255)
    public static var babyBlue = Color.init(red: 137/255, green: 207/255, blue: 240/255)
}

extension String: Identifiable {
    public var id: String {
        self
    }
}
