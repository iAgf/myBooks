//
//  BookPostModel.swift
//  myBooks
//
//  Created by Alghalya Alhees on 19/12/2022.
//

import Foundation
import Firebase
import Combine
//MARK: BOOK POST MODEL
class BookPostModel: ObservableObject{
    @Published var posts : [BookPost] = []
    @Published var BookSearchResult : [BookPost] = []

     func fetchBooks(bookCollege: String, bookMajor: String){
        Firestore.firestore().collection("university").whereField("major", isEqualTo: bookMajor)
             .whereField("college", isEqualTo: bookCollege)
             .addSnapshotListener{ snapshot, error in
            if let error = error{
                print(error)
                return
            }
            guard let snap = snapshot else { return }
            self.posts.removeAll()
            
            for document in snap.documents{
                let data = document.data()
                let  newPost = BookPost(documentId: document.documentID, data: data)
                self.posts.append(newPost)
                print(self.posts)
            }
        }
    }
    
    
     func fetchAllBooks(bookCollege: String){
        Firestore.firestore().collection("university")
            .whereField("college", isEqualTo: bookCollege)
            .addSnapshotListener{ snapshot, error in
               if let error = error{
                       print(error)
                   return
               }
           guard let snap = snapshot else { return }
                        self.posts.removeAll()
           for document in snap.documents{
               let data = document.data()
               let  newPost = BookPost(documentId: document.documentID, data: data)
               self.posts.append(newPost)
               print(self.posts)
           }
           }
   }
    
   

}
