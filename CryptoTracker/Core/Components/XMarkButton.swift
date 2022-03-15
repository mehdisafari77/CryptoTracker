//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

