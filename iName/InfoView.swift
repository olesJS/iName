//
//  InfoView.swift
//  iName
//
//  Created by Олексій Якимчук on 26.08.2023.
//

import SwiftUI

struct InfoView: View {
    let infoItem: Item
    
    var body: some View {
        VStack {
            Image(uiImage: infoItem.uiImage ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 400)
            
            Text(infoItem.name)
                .font(.largeTitle).bold()
        }
        .navigationTitle("Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}
