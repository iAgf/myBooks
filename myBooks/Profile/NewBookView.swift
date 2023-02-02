//
//  NewBookView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase
import FirebaseStorage
struct NewBookView: View {
    
    @State var image: UIImage?
    @State var shouldShowImagePicker: Bool = false
    @State private var bookTitle: String = ""
    @State private var bookPice: String = ""
    @State private var bookMajor: String = ""
    @State private var bookEdition: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isForSale: Bool = false
    @ObservedObject var collegeVM = Collleges()
    @State private var bookCollege: String = ""
    @State private var ChooseCollege: Int = 0
    @State private var ChooseMajor: Int = 0
    @State private var isLoading = false
    @ObservedObject var userVm = UserManager()
    @FocusState var isFocused : Bool // 1
    @EnvironmentObject var vm : UserManager
    @ObservedObject var bookVM : BookViewModel

    let bookUser : BookUser?
    init(bookUser: BookUser?){
        self.bookUser = bookUser
        self.bookVM = .init(bookUser: bookUser)
    }
    
        
    var body: some View {
        ZStack{
            //MARK: POST NEW BOOK
            VStack{
                ScrollView{
                    HomeCustomNavBar(customTitle:"أضف كتاب جديد:", EnableDissmiss: true)
                    VStack {
                        
                        VStack{
                            VStack{
                                //MARK: IMAGE BUTTON
                                Button{
                                    //show image picker
                                    shouldShowImagePicker.toggle()
                                } label:{
                                    if let image = self.image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 130, height: 130)
                                            .padding()
                                    }else{
                                        VStack{
                                            Image(systemName: "book.closed")
                                                .font(.system(size: 60))
                                                .padding()
                                            Text("add photo")

                                        }//vstack
                                    }//else
                                }//label
                                .padding()
                                
                                //MARK: BOOK TITLE
                                VStack{
                                    HStack{
                                        Text("book title: ")
                                        TextField(" enter your book title ", text: $bookVM.bookText)
                                            .focused($isFocused) //2
//                                            .frame(width: 100)
                                            .textFieldStyle(.roundedBorder)
                                    }//hstack
                                    .padding()
                                    //MARK: BOOK EDITION
                                    HStack{
                                        Text("Book Edition")
                                        TextField("Edition ", text: $bookVM.bookEdition)
                                            .focused($isFocused) //2
                                            .textFieldStyle(.roundedBorder)
//                                            .frame(width: 100)
                                    }//hstack
                                    .padding()
                                    
                                }//vstack for title & edition
                                
                            }//hstack
                            //MARK: BOOK FOR SALE OR FREE
                            // Picker
                            VStack{
                                Text("اختر الية البيع")
                                HStack{
                                    Button{
                                        bookVM.isFree = false
                                        
                                    }label: {
                                        Text("sell")
                                            .foregroundColor(!bookVM.isFree ? .white : .black)
                                            .frame(width: 70,height: 40)
                                            .padding(.horizontal,8)
                                            .background {
                                                ( bookVM.isFree ? Color.gray.opacity(0.2):  Color.blue)
                                                    .cornerRadius(10)
                                            }
                                    }//label 1
                                    
                                    Button{
                                        
                                        bookVM.isFree = true
                                        
                                    }label: {
                                        Text("free")
                                            .foregroundColor(bookVM.isFree ? .white : .black)
                                            .frame(width: 70,height: 40)
                                            .padding(.horizontal,8)
                                            .background {
                                                (bookVM.isFree ? Color.blue : Color.gray.opacity(0.2))
                                                    .cornerRadius(10)
                                            }
                                    }//label 2
                                    
                                }//hstack
                                
                            }//vstack
                            
                            
                            //MARK: BOOK PRICE
                            if !bookVM.isFree{
                                HStack
                                {
                                    Text("book price : ")
                                    TextField(" enter book price ", text: $bookVM.bookPrice)
                                        .focused($isFocused) //2

                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 100)
                                    
                                }//hstack
                                .padding()
                            }//if
                            
                        }//vstack
                        
                        VStack{
                            //MARK: BOOK College
                            HStack{
                                Text("College: \(bookCollege)")
                                    .bold()
                                Spacer()
                            }//hstack
                    
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(collegeVM.getColleges()){ college in
                                        HStack{
                                            Button{
                                                ChooseCollege = college.id
                                                bookCollege = college.name
                                            }label: {
                                                Text(college.name)
                                                    .foregroundColor(ChooseCollege == college.id ? .white : .black)
                                                    .frame(height: 40)
                                                    .padding(.horizontal,8)
                                                    .background {
                                                        (ChooseCollege == college.id ? Color.blue : Color.gray.opacity(0.2))
                                                            .cornerRadius(10)
                                                    }
                                            }//label
                                        }.frame( height: 50)
                                    }
                                    
                                }//hstack
                            }.padding()
                            
                            //MARK: BOOK MAJOR
                            HStack{
                                Text("major: \(bookMajor)")
                                    .bold()
                                Spacer()
                            }
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(collegeVM.getMajors(college: ChooseCollege)) { major in
                                        Button{
                                            ChooseMajor = major.id
                                            bookMajor = major.name
                                        }label: {
                                            Text(major.name)
                                                .foregroundColor(ChooseMajor == major.id ? .white : .black)
                                                .frame(height: 40)
                                                .padding(.horizontal,8)
                                                .background {
                                                    (ChooseMajor == major.id ? Color.blue : Color.gray.opacity(0.2))
                                                        .cornerRadius(10)
                                                }//background
                                        }//labe;
                                    }//hstack
                                }//for
                            }//scrol
                            
                            .padding()
                        }//vstack
                        //MARK: ADD BOOK TO THE FIREBASE BUTTON
                        Button{
                            // add a book
                            bookVM.bookMajor = bookMajor
                            bookVM.bookCollege = bookCollege
                            self.persistImageToStorage()
                            
                        }label: {
                            HStack{
                                Spacer()
                                Text("add book " )
                                    .foregroundColor(.white)
                                    .padding()
                                Spacer()
                            }//hstack
                            .background(Color.blue.cornerRadius(10))
                            .padding()
                        }//button
                        
                        
                        
                    }//vstack
                    .navigationTitle("add new book")
                    .fullScreenCover(isPresented: $shouldShowImagePicker)
                    {
                        ImagePicker(image: $image)
                    }//full
                    
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
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
            }
            .onAppear{
                bookCollege = collegeVM.getColleges()[0].name
                bookMajor = collegeVM.getMajors(college: 0)[0].name
            }
            
            .onTapGesture {
                isFocused = false
            }
            .alert(bookVM.errorMessage, isPresented: $bookVM.showingAlert) {
                       Button("OK", role: .cancel) { }
                   }
            
            if bookVM.isLoading{
                    LoadingView()
                }//isloading
            }//zstack
        
    }

    
    // MARK:  send image
    private func persistImageToStorage() {
        if bookVM.bookText == "" || bookVM.bookEdition == "" || bookVM.bookMajor == "" || bookVM.bookCollege == ""  {
            bookVM.errorMessage = "please fill out all the fields"
            bookVM.showingAlert = true
        }
        else{
            bookVM.isLoading.toggle()
            
            guard let uid = Firebase.Auth.auth().currentUser?.uid else { return }
            let ref =  Storage.storage().reference(withPath: "images/\(UUID().uuidString).jpg")
            guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
            ref.putData(imageData, metadata: nil) { metadata, err in
                if let err = err {
                    print("Failed to push image to Storage: \(err)")
                    bookVM.errorMessage = "please add photo"
                    bookVM.showingAlert = true
                    return
                }
                ref.downloadURL { url, err in
                    if let err = err {
                        print("Failed to retrieve downloadURL: \(err)")
                        bookVM.errorMessage = "please add photo"
                        bookVM.showingAlert = true
                        return
                    }
                    print(url?.absoluteString)
                    guard let url = url else {
                        bookVM.errorMessage = "please add photo"
                        bookVM.showingAlert = true
                        return
                        
                    }
                    bookVM.handleSend(college: bookCollege, major: bookMajor, image: url, username: userVm.bookUser?.username ?? "")
                    vm.fetchUserBooks()
                    presentationMode.wrappedValue.dismiss()
                    
                    
                    
                }
            }
        }
    }
     
}
    

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView(bookUser: nil)
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color.white.opacity(0.8)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(3)
                .frame(width: 120, height: 120)
                .background {
                    Color.black.opacity(0.2)
                        .cornerRadius(7)
                }
        }///zsatck
       
    }
}
