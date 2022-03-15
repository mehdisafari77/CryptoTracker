//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
        
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLoadingView()
    }
}

extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    
    
}
