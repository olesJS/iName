//
//  AddView.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
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
            
            Button("Save") {
                viewModel.items.append(Item(name: viewModel.name, imageData: viewModel.inputImage?.jpegData(compressionQuality: 0.8) ?? Data()))
                viewModel.saveData()
                viewModel.name = ""
                viewModel.inputImage = UIImage()
                dismiss()
            }
            .buttonStyle(.bordered)
            .disabled(viewModel.isDisabled)
        }
        .navigationTitle("Add item")
        .navigationBarTitleDisplayMode(.inline)
    }
}
