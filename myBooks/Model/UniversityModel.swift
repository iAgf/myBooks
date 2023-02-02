//
//  UniversityModel.swift
//  myBooks
//
//  Created by Alghalya Alhees on 12/01/2023.
//

import Foundation
import SwiftUI
struct Major: Identifiable{
    var id: Int
    var name: String
}
struct college: Identifiable{
    var id: Int
    var name: String
    var image: String
}
struct book: Identifiable{
    var id: Int
    var name: String
    var image: String
    var college: String
    var major: String
    var edition: String
    var isForSalae: String
    var price: String
}
