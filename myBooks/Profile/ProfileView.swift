//
//  ProfileView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase
struct ProfileView: View {
    @ObservedObject var userManagerVM = UserManager()
    @State var addNewBookView = false
    
    var body: some View {
        NavigationView {
            VStack{
                CustomNavBar()
                HStack{
                    Text("your Books:")
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    Spacer()
                }
                ScrollView(.vertical){
                    // CHECK IF USER HAS POSTED BOOKS 
                    if userManagerVM.userBook.isEmpty {
                        Text("no books yet")
                    }else{
                        ForEach(userManagerVM.userBook){ book in
                            BookView(userBook:book)
                            Divider()
                                .padding(.vertical, 8)
                        }
                    }//else
                }
                ADDBookButton
                    .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                
            }//vstack
            .onAppear{
             // FETCH USER BOOKS
                userManagerVM.fetchUserBooks()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
            
            .navigationBarHidden(true)
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .fullScreenCover(isPresented: $addNewBookView) {
            NewBookView(bookUser: nil)
        }
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
      
    }
    
    //MARK: ADD BOOK BUTTON
    private var ADDBookButton: some View {
        Button{
            addNewBookView.toggle()
        }label: {
            
            HStack{
                Spacer()
                Text("+ add new Book")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }//hstack
            .foregroundColor(.black)
            .padding(.vertical)
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
        }//label
        
    }//button
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
