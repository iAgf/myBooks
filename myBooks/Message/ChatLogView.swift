//
//  ChatLogView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 09/01/2023.
//

import SwiftUI
import Firebase


struct ChatLogView: View {
    
    var sendTo: String
    var sendToIUsername: String
    @ObservedObject var chatManagerVM = ChatMessage()
    @State var showtime = false
    @State var chatText : String = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userVM = UserManager()
    static let emptyScrollToString = "Empty"
    @State var chatMessages = [ChatMessageModel]()
    @FocusState var isFocused : Bool // 1

    
  
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("\(sendToIUsername)")
                        .font(.system(size: 30,weight: .bold))
                        .padding(.horizontal, 8)
                    Spacer()
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(Font.body.bold())
                            .foregroundColor(.black)
                            .padding()
                    }//label
                    .padding(.top)
                    .padding(.trailing)
                }//hstack
                .frame(height: 70)
                
            }//vstack
            ScrollView(.vertical){
                
                ScrollViewReader{ proxy in
                    VStack{
                        VStack{
                            ForEach(self.chatMessages){ message in
                                MessageBubbleView(message: message)
                                
                            }//for
                            
                        }
                        HStack{Spacer()}
                            .id(Self.emptyScrollToString)
                    }//vstack
                    .onReceive(chatManagerVM.$count) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            proxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                        }//animation
                    }//on receive
                    
                }//reader
            
            }//scroll
            .background(Color(.init(white: 0.95, alpha: 1)))
            
            .safeAreaInset(edge: .bottom) {
                chatBottomBar
                    .background(Color(.systemBackground).ignoresSafeArea())
            }//safe area
            .navigationBarTitleDisplayMode(.inline)
        }//vstack
        .onTapGesture {
            isFocused = false
        }
        .onAppear{
            self.fetchMessage(ToId: sendTo)
}//on appear

       
    }//body
    
    
    
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "message")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                TextField("type here ..", text: $chatManagerVM.chatText)
                    .focused($isFocused) // 2

                    .opacity(chatManagerVM.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button {

                chatManagerVM.handleSend(ToId: sendTo, toUsername: sendToIUsername , fromUsername: userVM.bookUser?.username ?? "")
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    

    
    
    //
    func fetchMessage(ToId: String){
        guard let fromId = Firebase.Auth.auth().currentUser?.uid else { return }
        Firebase.Firestore.firestore().collection("messages").document(fromId).collection(ToId).order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error{
//                    self.errorMessage = "Failed to listen  "
                    print(error)
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added{
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
//                        self.count += 1

                    }
                })
                                print("fetch to: \(ToId)")
                DispatchQueue.main.async {
                    chatManagerVM.count += 1
                }
//
            }
    }
}


//
//struct ChatLogView_Previews: PreviewProvider {
//    static var previews: some View {
////        ChatLogView(sendTo: "", sendToIUsername: "")
////            .environmentObject(ChatMessage())
//    }
//}
