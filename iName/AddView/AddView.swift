//
//  AddView.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import SwiftUI

struct AddView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            viewModel.image?
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            
            TextField("Name", text: $viewModel.name)
                .padding()
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
            
            Button("Add image") {
                viewModel.isImagePickerActive = true
            }
            .sheet(isPresented: $viewModel.isImagePickerActive) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.loadImage()
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("Add item")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save") {
                
            }
        }
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}
