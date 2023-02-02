//
//  BookModel.swift
//  myBooks
//
//  Created by Alghalya Alhees on 17/12/2022.
//

import Foundation
import SwiftUI
import Firebase

//MARK: BOOK POST MODEL
struct BookPost: Identifiable{
    var id : String { documentId }
    let documentId : String
    let postByID, bookTitle, bookEdition, bookPrice,bookImage, username : String
    let isFree: Bool
    let timestamp: Timestamp
    
    
    init(documentId: String,data: [String: Any]) {
        self.documentId = documentId
        self.postByID = data["postByID"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.bookTitle = data["title"] as? String ?? ""
        self.bookEdition = data["edition"] as? String ?? ""
        self.bookPrice = data["price"] as? String ?? ""
        self.bookImage = data["bookImage"] as? String ?? ""
        self.isFree = data["isFree"] as? Bool ?? false
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()

    }
}



// NOTING HERE ?
