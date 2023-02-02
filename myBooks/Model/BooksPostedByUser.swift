//
//  BooksPostedByUser.swift
//  myBooks
//
//  Created by Alghalya Alhees on 07/01/2023.
//
import SwiftUI
import Firebase
import Foundation
struct BooksPostedByUser: Identifiable{
    var id : String { documentId }
    let documentId : String
    let postByID, bookTitle, bookEdition, bookMajor ,bookPrice,bookImage : String
    let timestamp: Timestamp

    init(documentId: String,data: [String: Any]) {
        self.documentId = documentId
        self.postByID = data["postByID"] as? String ?? ""
        self.bookTitle = data["title"] as? String ?? ""
        self.bookEdition = data["edition"] as? String ?? ""
        self.bookPrice = data["price"] as? String ?? ""
        self.bookMajor = data["major"] as? String ?? ""
        self.bookImage = data["bookImage"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()

    }
}
