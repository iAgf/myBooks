//
//  BookView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
struct BookView: View {
    @State var shouldAddNewBook = false
    @EnvironmentObject var userManagerVM : UserManager

    var userBook : BooksPostedByUser
    var body: some View {
        ZStack{
            //MARK: SHOW BOOK VIEW
            VStack{
                VStack{
                HStack
                {
                    WebImage(url: URL(string: userBook.bookImage))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    VStack{
                        HStack{
                            Text("book title: ")
                            Text(" \(userBook.bookTitle) ")
                                .fontWeight(.semibold)
                            
                        }
                        .padding(3)
                        HStack{
                            Text("book price: ")
                            Text("\(userBook.bookPrice) ").fontWeight(.semibold)
                                .padding(3)
                        }
                        HStack{
                            Text("major:")
                            Text("\(userBook.bookMajor) ")
                            
                        }
                        .padding(3)
                        HStack{
                            Text("Edition:")
                            Text("\(userBook.bookEdition)")
                                .fontWeight(.semibold)
                        }                    .padding(3)
                        
                    }//Vstack
                    .padding(.vertical,8)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                }//Hstack
                
                    HStack{
                        Text("at: \(userBook.timestamp.dateValue().formatted())")
                            .font(.system(size: 12, weight: .light))
                        
                        Spacer()
                        Button{
                            //delete
                            userManagerVM.isLoading = true
                            userManagerVM.deleteABook(book: userBook)
                        }label: {
                            Image(systemName: "trash")
                                .foregroundColor(.black)
                            
                        }
                    }.padding()
            }//Vstack
                .padding(15)
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
                .padding()
                
            }//vstack
            .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
            // IF POSTED
            if userManagerVM.isLoading{
                LoadingView()
            }//isloading
        }
    }
}

//
//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView(userBook: [u])
//    }
//}
