//
//  MessageBubbleView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 30/01/2023.
//

import SwiftUI
import Firebase

struct MessageBubbleView: View {
    var message : ChatMessageModel

    var body: some View {
        VStack{
            if message.fromId == Firebase.Auth.auth().currentUser?.uid {
                HStack{
                    Spacer()
                    HStack{
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background {
                        Color.blue
                    }
                    .cornerRadius(8)
                }
                .padding(.horizontal,8)
                .padding(.top,8)
            }
            else{
                HStack{
                    HStack{
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background {
                        Color.white
                    }
                    .cornerRadius(8)
                    Spacer()
                }
                .padding(.horizontal,8)
                .padding(.top,8)
                
            }
            
        }
    }
}
//
//struct MessageBubbleView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageBubbleView()
//    }
//}
