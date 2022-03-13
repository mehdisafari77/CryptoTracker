//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 12/03/2022.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    
    @State pribate var animate: Bool = false
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView()
    }
}
