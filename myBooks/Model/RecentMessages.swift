//
//  RecentMessages.swift
//  myBooks
//
//  Created by Alghalya Alhees on 16/01/2023.
//

import Foundation
import Firebase
struct RecentMessages: Identifiable {
    var id : String {documentId}
    let documentId : String
    let text, username, fromId, toId: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.text = data["text"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    
}
