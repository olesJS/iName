//
//  ContentView.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(viewModel.sortedItems, id: \.name) { item in
                        HStack {
                            Image(uiImage: item.uiImage ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 125, height: 100)
                            Text(item.name)
                        }
                    }
                    .onDelete { offset in
                        for i in offset {
                            if let found = viewModel.items.firstIndex(where: { $0 == viewModel.sortedItems[i] }) {
                                viewModel.items.remove(at: found)
                            }
                        }
                        viewModel.saveData()
                    }
                }
                
                Spacer()
                
                Button() {
                    viewModel.isAddSheetActive = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                }
                .buttonStyle(.bordered)
                .sheet(isPresented: $viewModel.isAddSheetActive) {
                    AddView()
                        .environmentObject(viewModel)
                }
            }
            .navigationTitle("iName")
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
