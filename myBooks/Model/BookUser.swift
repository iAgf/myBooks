//
//  BookUser.swift
//  myBooks
//
//  Created by Alghalya Alhees on 17/12/2022.
//

import Foundation
//MARK: BOOK USER MODEL
struct BookUser: Identifiable {
    var id : String  { uid }
    let uid, email, username : String
    init(data: [String:Any]){
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
    }
}
