//
//  CollegeView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 12/12/2022.
//

import SwiftUI
import Firebase

struct CollegeView: View {
    @State private var didChooseCollege = 0
    @State private var didChooseCollegeName = ""
    @State private var willMoveToNextScreen = false
    @ObservedObject var vm = Collleges()
    var listData : [college] {
        if searchText.isEmpty{
            return vm.getColleges()
        }else{
            return vm.collegeSearchResult
        }
        
    }
    @EnvironmentObject var bookVM: BookPostModel
    @State private var searchText = ""

    var body: some View {
            VStack{
                VStack{
                    Spacer()
                    //MARK: CUSTOM NAVBAR
                    HomeCustomNavBar(customTitle: "الكليات" , EnableDissmiss: false)
                    HStack{
                        Text("search:")
                        //MARK: SEARCH BAR FOR COLLEGES
                        TextField("search", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: searchText) { newValue in
                                vm.collegeSearchResult = vm.getColleges().filter({ college in
                                    college.name.lowercased().contains(searchText.lowercased())
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
                        }
                    }//hstack
                    .padding()
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
                .frame(height: 250)
                .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                Spacer()
                VStack{
                    ScrollView{
                        //MARK: SHOW COLLEGES
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                            ForEach(listData){ college in
                                VStack{
                                    Spacer()
                                    Button
                                    {
                                        self.didChooseCollegeName = college.name
                                        self.didChooseCollege = college.id
                                        bookVM.fetchAllBooks(bookCollege: self.didChooseCollegeName)
                                        print(self.didChooseCollegeName)
                                        willMoveToNextScreen.toggle()
                                        
                                        
                                    }label: {
                                        VStack(alignment: .center, spacing: 0){
                                            LottieView(fileName: college.image, height: 100, width: 100)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100, alignment: .center)
                                            VStack{
                                                Text(college.name)
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 16, weight: .medium))
                                            }
                                        }//vstack
                                        .padding()
                                        
                                    }//label
                                    .frame(width: UIScreen.main.bounds.size.width / 2.5,height: 180)
                                    .padding(8)
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
                                .fullScreenCover(isPresented: $willMoveToNextScreen) {
                                    //MARK: GO TO HOME VIEW (BOOK VIEW)
                                    HomeView(ChosenCollege: didChooseCollege, ChosenCollegeName: self.didChooseCollegeName)
                                    
                                }//full
                            }//for
                        }//lazy
                        .padding(.bottom,100)
                    }//scrol
                    .frame(maxWidth: .infinity ,maxHeight: .infinity)
                    .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                    .cornerRadius(30)
                    
           

                }//vstack
          
                

            }//vstack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
            .onDisappear
            {
                bookVM.fetchAllBooks(bookCollege: self.didChooseCollegeName)
            }
        
    }
}

struct CollegeView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeView()
    }
}
