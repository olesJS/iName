//
//  ContentView-ViewModel.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var items: [Item]
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedItems")
        
        @Published var isAddSheetActive = false
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                items = try JSONDecoder().decode([Item].self, from: data)
            } catch {
                items = []
            }
        }
        
        func saveData() {
            do {
                let data = try JSONEncoder().encode(items)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("saveData() error")
            }
        }
    }
}
