//
//  PostedByUserModel.swift
//  myBooks
//
//  Created by Alghalya Alhees on 02/01/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import Combine

class PostedByUserManager: ObservableObject{
    @Published var isLoading = false
    @Published var userBook = [BooksPostedByUser]()
    {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(){
        self.fetchUserBooks()
    }
    // fetch user books
    func fetchUserBooks(){
        guard let userId = Firebase.Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("university")
//            .order(by: "timestamp")
            .whereField("postByID", isEqualTo: userId)
            
            .getDocuments{snapshot, error in
                if let error = error{
                    print(error)
                    return
                }
                guard let snap = snapshot else { return }
                self.userBook.removeAll()
                for document in snap.documents{
                    let data = document.data()
                    let newPost = BooksPostedByUser(documentId: document.documentID, data: data)
                    self.userBook.append(newPost)
                    print(self.userBook)
                    //                print(userBook.count)
                }
            }
    }
    
    func deleteABook(book: BooksPostedByUser){
        Firestore.firestore().collection("university")
            .document(book.documentId)
            .delete{ error in
                if let err = error {
                    print("Cant be deleted")
                    //alert
                }
                else{
                    self.fetchUserBooks()
                    self.isLoading = false
                    
                }
                
            }
    }
}
