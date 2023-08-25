//
//  Item.swift
//  iName
//
//  Created by Олексій Якимчук on 25.08.2023.
//

import Foundation
import UIKit

struct Item: Codable, Comparable {
    var name: String
    var imageData: Data
    
    var uiImage: UIImage? {
        UIImage(data: imageData)
    }
    
    static func < (lhs: Item, rhs: Item) -> Bool {
        lhs.name < rhs.name
    }
}
