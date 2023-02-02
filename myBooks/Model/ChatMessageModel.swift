//
//  ChatMessageModel.swift
//  myBooks
//
//  Created by Alghalya Alhees on 29/01/2023.
//

import Foundation
struct ChatMessageModel : Identifiable{
    var id : String { documentId }
    let documentId : String
    let fromId, toId, text: String
    
    init(documentId: String,data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
    }
}

struct Message : Identifiable, Codable{
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
    
}
