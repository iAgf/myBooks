//
//  HomeModel.swift
//  myBooks
//
//  Created by Alghalya Alhees on 17/12/2022.
//

import Foundation
import SwiftUI
import Firebase
    //MARK: CHECING IF USER IS LOOGED OR NOT
class UserManager : ObservableObject{
    @Published var errorMessage = ""
    @Published var bookUser: BookUser?
    @Published var isUserCurrentlyLoggedOut = false
    @Published var isLoading = false
    @Published var userBook = [BooksPostedByUser]()
    init()
    {
        DispatchQueue.main.async
        {
            self.isUserCurrentlyLoggedOut = Firebase.Auth.auth().currentUser?.uid   == nil
        }
        fetchCurrentUser()
//        fetchRecentMessages()
        fetchUserBooks()
    }
    
    @Published var recentMessages = [RecentMessages]()
    //fetch recent messages
    private func fetchRecentMessages(){
        guard let uid  = Firebase.Auth.auth().currentUser?.uid else { return }
        Firebase.Firestore.firestore().collection("recent_messages").document(uid).collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapShot, error in
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapShot?.documentChanges.forEach({ change in
                    let docId = change.document.documentID
                    if let index  = self.recentMessages.firstIndex(where: { rm in
                        return rm.documentId == docId
                    }){
                        self.recentMessages.remove(at: index)
                    }
                    self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
                    //                        self.recentMessages.append(.init(documentId: docId, data: change.document.data()))
                    
                })
            }
        
    }
    
    
    
    
    //MARK: Fettch Current User
    func fetchCurrentUser()
    {
        guard let uid  = Firebase.Auth.auth().currentUser?.uid  else { return }
        self.errorMessage = "\(uid)"
        Firebase.Firestore.firestore().collection("users").document(uid).getDocument { snapshot , err in
            if let error = err {
                print("Faild To Fetch Current User \(error)")
                self.errorMessage = "Could not find an account"
                return
            }
            print("uid \(uid)")
            guard let data = snapshot?.data() else {
                self.errorMessage = "No Data Found"
                return
            }
            //MARK: DECODE A DATA
            self.bookUser = .init(data: data)
        }
    }
    //MARK: SIGN OUT FUNCTION
    func handleSignOut(){
        isUserCurrentlyLoggedOut.toggle()
        try? Firebase.Auth.auth().signOut()
    }
    
    

    func fetchUserBooks(){
        guard let userId = Firebase.Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("university")
            .whereField("postByID", isEqualTo: userId)
           .order(by: "timestamp", descending: true)
            .addSnapshotListener{snapshot, error in
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
