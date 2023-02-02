//
//  MessagesView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase
struct MessagesView: View {
    @State var username = ""
    @State var usernameid = ""
    @State var goToChatView = false
    @State var recentMessage : RecentMessages
    var body: some View {
        VStack{
            Button {
                print("send to \(recentMessage.toId) username \(recentMessage.username)")
                username = recentMessage.username
                usernameid = recentMessage.toId
                goToChatView.toggle()
                
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                        .padding(8)
                        .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color.black, lineWidth: 3))
                    VStack(alignment: .leading){
                        Text(recentMessage.username)
                            .font(.system(size: 16,weight: .bold))
                        
                        Text(recentMessage.text)
                            .font(.system(size: 16))
                            .foregroundColor(Color(.lightGray))
                            .multilineTextAlignment(.leading)
                    }//vstack
                    Spacer()
                    
                    Text(" at \(recentMessage.timestamp.dateValue().formatted())")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(.init(uiColor: .darkGray))
                }//hstack
                .foregroundColor(.black)
                .padding()
                
            }
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            
            Divider()
                .padding(.vertical, 8)
            
        }//vstack
        .padding(.horizontal)
        .fullScreenCover(isPresented: $goToChatView) {
            ChatLogView(sendTo: recentMessage.toId, sendToIUsername: recentMessage.username)
            
        }
    }
}
//
//struct MessagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessagesView()
//    }
//}
