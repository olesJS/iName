//
//  ViewModel.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import Foundation
import UIKit
import SwiftUI
import LocalAuthentication

@MainActor class ViewModel: ObservableObject {
    // ContentView
    @Published var items: [Item]
    var sortedItems: [Item] {
        items.sorted()
    }
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedItems")
    
    @Published var isAddSheetActive = false
    @Published var isDataUnlocked = false
    
    // AddView
    @Published var name: String = ""
    
    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var isImagePickerActive = false
    
    var isDisabled: Bool {
        if name.replacingOccurrences(of: " ", with: "").count == 0 { return true }
        if inputImage == nil { return true }
        if inputImage == UIImage() { return true }
        return false
    }
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            items = []
        }
    }
    
    // write data to Document Directory
    func saveData() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("saved")
            print("\(items)")
        } catch {
            print("saveData() error")
        }
    }
    
    // loading image from ImagePicker
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    // deleting row from sorted list
    func deleteRow(offsets: IndexSet) {
        for offset in offsets {
            if let found = items.firstIndex(where: { $0 == sortedItems[offset] }) {
                items.remove(at: found)
            }
        }
        saveData()
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "You need pass identification to enable deleting items"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    Task { @MainActor in
                        self.isDataUnlocked = true
                    }
                }
            }
        }
    }
}
