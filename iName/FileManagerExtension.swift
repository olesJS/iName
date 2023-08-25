//
//  FileManagerExtension.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
