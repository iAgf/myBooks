//
//  MainMessagesView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase
struct MainMessagesView: View {
    
    @ObservedObject var userManagerVM = UserManager()
    @ObservedObject var chatManagerVM = ChatMessage()
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView{
                    if chatManagerVM.recentMessages.isEmpty {
                        Text("no messages yet")
                    }else{
                        ForEach(chatManagerVM.recentMessages){ recentMessage in
                            MessagesView(recentMessage: recentMessage)
                                .padding(.top)
                            
                        }//for
                    }//else
                }//scrol
            }//vstak
            .navigationTitle("Chats")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))

            .onAppear{
                
                chatManagerVM.fetchRecentMessages()
            }
        }//nav
    }
        
    
    
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
