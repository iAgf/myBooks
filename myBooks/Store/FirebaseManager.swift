//
//  FirebaseManager.swift
//  myBooks
//
//  Created by Alghalya Alhees on 17/12/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
//MARK: FIREBASE MANAGER MODEL
class FirebaseManager : NSObject, ObservableObject{
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
//    static let shared = FirebaseManager()
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        super.init()
    }
}


