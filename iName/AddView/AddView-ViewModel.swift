//
//  AddView-ViewModel.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import Foundation
import UIKit
import SwiftUI

extension AddView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name: String = ""
        
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var isImagePickerActive = false
        
        // loading image from ImagePicker
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
    }
}
