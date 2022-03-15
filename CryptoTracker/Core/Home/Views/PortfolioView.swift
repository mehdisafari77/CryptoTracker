//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel?
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool  = false
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
