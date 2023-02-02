//
//  BookDetail.swift
//  myBooks
//
//  Created by Alghalya Alhees on 02/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct BookDetail: View {
    var book: BookPost
    @ObservedObject var chatManagerVM = ChatMessage()
    @State var orederNow = false
    var body: some View {
        VStack{
            
            WebImage(url: URL(string: book.bookImage))
                .resizable()
                .scaledToFit()
                .frame(height: 230)
                .padding()
                HStack{
                    Text(" @\(book.username)")
                    Spacer()
                    Text(" at \(book.timestamp.dateValue().formatted())")
                    
                }
                .padding(3)
                .foregroundColor(Color(.darkGray))
                .font(.system(size: 12))
                
            HStack{
                VStack{
                    HStack{
                        Text("Book title:")
                        
                        Text(" \(book.bookTitle)")
                            .font(.system(size: 14,  weight: .bold ,design: .serif))
                            .multilineTextAlignment(.leading)
                                                
                    }
                    .padding(.vertical, 3)
                    VStack{
                        if !book.isFree{
                            HStack{
                                Text("Price: ")
                                Text("\(book.bookPrice) kd")
                                    .font(.system(size: 14, weight: .bold, design: .serif))
                            }
                            .padding(.vertical, 3)
                            
                        }else{
                            HStack{
                                Text("Price: ")
                                
                                Text("free")
                                    .font(.system(size: 16, design: .serif))
                                    .foregroundColor(.white)
                                    .frame(width: 80,height: 30)
                                    .padding(.horizontal, 5)
                                    .background {
                                        Color.green
                                    }
                                    .cornerRadius(35)
                            }
                        }//else
                        HStack{
                            Text("Book Edition: ")
                            Text("\(book.bookEdition)")
                                .font(.system(size: 16, design: .serif))
                        }
                        .padding(.vertical, 3)
                        
                    }//vstack
                }//vstack
                .padding()
                            Spacer()
            }//hstack
            Button{
                if  book.postByID != Firebase.Auth.auth().currentUser?.uid{
                    orederNow.toggle()
                }
            }label: {
                Text("order now")
                    .foregroundColor(.white)
                    .frame(width: 250,height: 40)
                    .background {
                        Color.blue
                    }
                    .cornerRadius(10)
            }//labeL
            
            
            
        }//vstack
        .fullScreenCover(isPresented: $orederNow) {
            ChatLogView(sendTo: book.postByID, sendToIUsername: book.username)
        }
    }
    
}
//
//struct BookDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BookDetail()
//    }
//}
