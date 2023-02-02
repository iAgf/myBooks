//
//  BookViewModel.swift
//  myBooks
//
//  Created by Alghalya Alhees on 07/01/2023.
//

import Foundation
import Firebase
class BookViewModel: ObservableObject{
    @Published var bookText = ""
    @Published var bookEdition = ""
    @Published var bookPrice = ""
    @Published var bookImage = ""
    @Published var bookCollege = "college"
    @Published var bookMajor = "major"
    @Published var errorMessage = ""
    @Published var isFree = false

    @Published var isLoading = false
    @Published var showingAlert: Bool = false
    let bookUser : BookUser?
    init(bookUser: BookUser?){
        self.bookUser = bookUser

}
    func handleSend(college: String, major: String, image: URL, username: String){
        guard let postById = Firebase.Auth.auth().currentUser?.uid else { return }
            let document = Firebase.Firestore.firestore().collection("university").document()
        if self.isFree{
            let messageData = ["postByID": postById,"username": username ,"college": bookCollege,"major": bookMajor, "title": self.bookText, "edition": self.bookEdition, "isFree": self.isFree,"price": "free", "bookImage": image.absoluteString, "timestamp": Timestamp() ] as [String: Any ]
            document.setData(messageData){error in
                if let error = error {
                    print("Fail to Send ")
                    self.errorMessage = "Failed to Send "
                    self.showingAlert.toggle()
                    return
                }
                print("SuccessFully saved book ")
                self.errorMessage = "saved "
                self.showingAlert.toggle()
                self.isLoading.toggle()

            }

        }else{
            
            let messageData = ["postByID": postById,"username": username ,"college": bookCollege,"major": bookMajor, "title": self.bookText, "edition": self.bookEdition, "isFree": self.isFree,"price": self.bookPrice, "bookImage": image.absoluteString, "timestamp": Timestamp() ] as [String: Any ]
            
            
            document.setData(messageData){error in
                if let error = error {
                    print("Fail to Send ")
                    self.errorMessage = "Failed to Send "
                    self.showingAlert.toggle()
                    return
                }
                print("SuccessFully saved book ")
                self.errorMessage = "saved "
                self.showingAlert.toggle()
                self.isLoading.toggle()

            }

        }
        
    }
    
    }//CLASS




