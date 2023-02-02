//
//  HomeView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase
struct HomeView: View {
    @State private var searchText = ""
    @ObservedObject var vm = Collleges()
    var ChosenCollege:Int
    var ChosenCollegeName:String
    @State private var isLoading = false
    @State private var didChooseMajor: Int = 11
    @EnvironmentObject var bookVM : BookPostModel

    
    
    
    
    var college = ""
    var listData : [BookPost] {
        if searchText.isEmpty{
            return bookVM.posts
        }else{
            return bookVM.BookSearchResult
        }
        
    }
    
    var body: some View {
        
        VStack{
            ScrollView{
                //MARK: HOME VIEW || BOOK VIEW
                VStack{
                    //custom bar
                    HomeCustomNavBar(customTitle: "\(ChosenCollegeName)", EnableDissmiss: true)
                    
                    
                    HStack{
                        
                        Text("search:")
                        //MARK: SEARCH FOR BOOK
                        TextField("search", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: searchText) { newValue in
                                bookVM.BookSearchResult = bookVM.posts.filter({ book in
                                    book.bookTitle.lowercased().contains(searchText.lowercased())
                                })
                            }//onchange
                        Button
                        {
                        }label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .frame(width:37, height: 37)
                                .scaledToFit()
                                .foregroundColor(Color.black)
                        }//label
                    }//hstack
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
                        }//zack
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
                    .padding()
                    
                    
                }//VSTACK
                .frame(height: 250)
                .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                
                
                
                
                
                //MARK: SHOW BOOKS FOR EACH MAJOR
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(vm.getMajors(college: ChosenCollege)){major in
                            Button{
                                didChooseMajor = major.id
                                bookVM.fetchBooks(bookCollege: ChosenCollegeName, bookMajor: major.name)
                            }label: {
                                Text(major.name)
                                    .foregroundColor(didChooseMajor == major.id ? .white : .black)
                                    .frame( height: 40)
                                    .padding(8)
                                    .background
                                {
                                    (didChooseMajor == major.id ? Color.blue : Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                                
                            }//label
                            .padding()
                        }//for
                    }  //hstack
                }//scrolll
                
                
                
                //show books
                VStack{
                    ScrollView(.vertical){
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                            ForEach(listData){ post in
                                MajorBooks(post: post)

                            }//for
                        }//lazy
                        .padding(.horizontal)
                        .padding(.bottom,10)
                    }//scroll
                    .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                    .padding(.bottom,40)
                }//vstack
                
            }//scroll
            .padding(.bottom)
            .cornerRadius(50)
            .navigationTitle("Home View")
            
            
        }//first vstack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    
    }

  
    
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(ChosenCollege: 0, ChosenCollegeName: "")
    }
}
