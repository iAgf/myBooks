//
//  BottomSheet.swift
//  myBooks
//
//  Created by Alghalya Alhees on 19/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct BottomSheet: View {
    var book: BookPost
    @ObservedObject var chatManagerVM = ChatMessage()
    @State var orederNow = false
    var body: some View {
        VStack{
            HStack{
                Text(" @\(book.username)")
                Spacer()
                Text(" at \(book.timestamp.dateValue().formatted())")
                
            }
            .padding(3)
            .foregroundColor(Color(.darkGray))
            .font(.system(size: 12))
            HStack{
                WebImage(url: URL(string: book.bookImage))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
//                Spacer()
                VStack{
                    HStack{
                        Text("Book title:")
                        Text(" \(book.bookTitle)")
                            .font(.system(size: 16,  design: .serif))
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
                        }
                    }//hstck
                    HStack{
                        Text("Book Edition: ")
                        Text("\(book.bookEdition)")
                            .font(.system(size: 16, design: .serif))
                    }
                    .padding(.vertical, 3)

                }//vstack
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
            
       }//
        .fullScreenCover(isPresented: $orederNow) {
            ChatLogView(sendTo: book.postByID, sendToIUsername: book.username)
        }
    }
}
//
//struct BottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomSheet(book: nil)
//    }
//}
