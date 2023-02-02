//
//  MajorBooks.swift
//  myBooks
//
//  Created by Alghalya Alhees on 15/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MajorBooks: View {
    @State private var showingButtonsheet = false
    var post: BookPost
//    @EnvironmentObject var chatManagerVM : ChatMessage
    @ObservedObject var chatManagerVM = ChatMessage()
    @EnvironmentObject var bookVM: BookPostModel


    var body: some View {
        Button{
            showingButtonsheet.toggle()
        }label: {
            VStack{
                WebImage(url: URL(string: post.bookImage))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 130)
                VStack{
                    HStack{
                        Text("Book Title:")
                        Text("\(post.bookTitle)")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
//                            .al
                    }
                        .font(.system(size: 12,  design: .serif))
                        .foregroundColor(.black)
                    VStack {
                        if !post.isFree{
                            HStack{
                                Text("price:")
                                Text("price: \(post.bookPrice)")
                                 
                            }
                            .font(.system(size: 12, design: .serif))
                            .font(Font.body.bold())
                            .foregroundColor(.black)
                            .padding(8)
                        }
                        else {
                            Text("free")
                                .font(.system(size: 12, design: .serif))
                                .foregroundColor(.white)
                                .frame(width: 70,height: 30)
                                .padding(.horizontal, 5)
                                .background {
                                    Color.green
                                }
                                .cornerRadius(5)
                        }
                    }//vstack
                    Text("Order now")
                        .font(.system(size: 14,  design: .serif))
                        .foregroundColor(.white)
                        .frame(width: 90,height: 30)
                        .padding(.horizontal, 5)
                        .background {
                            Color.blue
                        }
                        .cornerRadius(5)

                    
                }//vstack
                .padding(.horizontal ,3)
            }//vstack
            .frame(width:  UIScreen.main.bounds.size.width/2.2, height: 280)
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
            .padding(15)
            
        }//label
        .sheet(isPresented: $showingButtonsheet) {
            if #available(iOS 16.0, *) {
                BottomSheet(book: post)
                    .presentationDetents([.fraction(0.3),.medium])
            } else {
                // Fallback on earlier versions
                BookDetail(book: post)
                
            }
//                .environmentObject(ChatMessage())
        }

        
        
    }
}
//
//struct MajorBooks_Previews: PreviewProvider {
//    static var previews: some View {
//        MajorBooks(post: nil)
//    }
//}
