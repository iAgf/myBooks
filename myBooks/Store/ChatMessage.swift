//
//  ChatMessage.swift
//  myBooks
//
//  Created by Alghalya Alhees on 12/01/2023.
//

import Foundation
import SwiftUI
import Firebase

class ChatMessage: ObservableObject{
    @Published var chatText = ""
    @Published var count = 0
    @Published var errorMessage = ""
    @Published var chatMessages = [ChatMessageModel]()
    @Published var recentMessages = [RecentMessages]()
    init(){
        fetchRecentMessages()
    }
    
    func handleSend(ToId: String,toUsername: String,  fromUsername: String){
        if chatText != "" {
            guard let fromId = Firebase.Auth.auth().currentUser?.uid else { return }
            let document = Firebase.Firestore.firestore().collection("messages").document(fromId)
                .collection(ToId).document()
            let messageData = ["fromId": fromId, "toId": ToId, "text": self.chatText,"timestamp": Timestamp() ] as [String: Any ]
            document.setData(messageData){error in
                if let error = error {
                    print("Fail to Send ")
                    self.errorMessage = "Failed to Send "
                    return
                }else{
                    print("SuccessFully saved message")
                    //fetch recent message
                    
                    self.sendRecentMessages(toId: ToId, toUsername: toUsername, fromUsername: fromUsername)
                    
                    // send
                    self.chatText = ""
//                    self.count += 1
                    
                }
                
            }
            let reciptintMessagedocument = Firebase.Firestore.firestore().collection("messages").document(ToId)
                .collection(fromId).document()
            reciptintMessagedocument.setData(messageData){error in
                if let error = error {
                    print("Fail to Send ")
                    self.errorMessage = "Failed to Send "
                    return
                    
                }
                print("SuccessFully  reciveed user")
                
                
            }
            
        }//if
    }
    func sendRecentMessages(toId: String, toUsername: String, fromUsername: String){
        guard let uid = Firebase.Auth.auth().currentUser?.uid else { return }
        let document = Firebase.Firestore.firestore().collection("recent_messages").document(uid).collection("messages").document(toId)
        let data = ["timestamp": Timestamp(),
                    "text" : self.chatText,
                    "fromId": uid,
                    "fromUsername": fromUsername,
                    "username": toUsername,
                    "toId": toId
        ] as [String : Any]
        document.setData(data){ error in
            if let error = error {
                print("failed to send \(error)")
                return
            }
            //success
            print("Success sending recent")
        }
        
        
        let documentRecent = Firebase.Firestore.firestore().collection("recent_messages").document(toId).collection("messages").document(uid)
        let dataRecent = ["timestamp": Timestamp(),
                    "text" : self.chatText,
                    "fromId": toId,
                    "fromUsername": toUsername,
                    "username": fromUsername,
                    "toId": uid
        ] as [String : Any]
        documentRecent.setData(dataRecent){ error in
            if let error = error {
                print("failed to send \(error)")
                return
            }
            //success
            print("Success sending recent")
        }

    }
    
    //
    func fetchMessage(ToId: String){
        guard let fromId = Firebase.Auth.auth().currentUser?.uid else { return }
        Firebase.Firestore.firestore().collection("messages").document(fromId).collection(ToId).order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error{
                    self.errorMessage = "Failed to listen  "
                    print(error)
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added{
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                        self.count += 1

                    }
                })
                                print("fetch to: \(ToId)")
//                DispatchQueue.main.async {
//                    self.count += 1
//                }
//
            }
    }
    //fetch recent messages
    func fetchRecentMessages(){
        guard let uid  = Firebase.Auth.auth().currentUser?.uid else { return }
        Firebase.Firestore.firestore()
            .collection("recent_messages")
            .document(uid).collection("messages")
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
    
    
}
