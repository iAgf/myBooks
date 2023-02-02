//
//  LogInView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @State  private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginMode: Bool = false
    @State private var username: String = ""
    @State var loginStatusMessage = ""
    @FocusState var isFocused : Bool // 1
    @State var forgetPassword : Bool = false
    let didCompleteLogInProcess: () -> ()
    @State private var isLoading = false
    @State private var showingAlert : Bool = false
    
    
    
    
    @AppStorage("showOnBoarding") var showOnBoarding : Bool = true
    var body: some View {
        ZStack{
        NavigationView {

                VStack{
                    ScrollView{
                        VStack{
                            VStack{
                                HStack{
                                    Text(isLoginMode ? "Log in" : "Create an account")
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                
                                if !isLoginMode
                                {
                                    HStack{
                                        Image(systemName: "person.fill")
                                        Text("username: ")
                                        TextField(" enter your username ", text: $username)
                                            .focused($isFocused) //2
                                    }//hstack
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(20.0)
                                    .padding()
                                }//if
                                
                                HStack
                                {
                                    Image(systemName: "person.fill")
                                    Text("Email: ")
                                    TextField(" enter your email ", text: $email)
                                        .focused($isFocused) // 2
                                    
                                }//hstack
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(20.0)
                                .padding()
                                HStack
                                {
                                    Image(systemName: "lock")
                                    Text("password: ")
                                    SecureField("password", text: $password)
                                        .focused($isFocused) // 2
                                    
                                }//hstack
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(20.0)
                                .padding()
                                if isLoginMode{
                                    Button{
                                        forgetPassword.toggle()
                                    }label: {
                                        Text("Forget password?")
                                    }
                                }
                                
                                // MARK: buttom to log in or sign up
                                Button{
                                    // log in
                                    handleAccountAction()
//                                    isLoading = true

                                }label: {
                                    
                                    Text( isLoginMode ? " Log in " : "Create account ")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 300, height: 50)
                                        .background(Color.blue)
                                        .cornerRadius(15.0)
                                }
                                //button
                                Spacer()
                                
                                Button{
                                    // log in
                                    isLoginMode.toggle()
                                }label: {
                                    Text( !isLoginMode ? " Already have an account ? " : " Create account ")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                                //button
                                
                            }//vstack
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
                            .padding(.top, 10)
                            
                            
                        }//vstck
                        .onTapGesture {
                            isFocused = false
                        }
                    }//SCROLL
                    .alert(self.loginStatusMessage, isPresented: $showingAlert) {
                               Button("OK", role: .cancel) { }
                           }
                    .fullScreenCover(isPresented: $forgetPassword) {
                        ResetPasswordView()
                    }
                }
                .navigationTitle(isLoginMode ? "Welcome back " : "Create your account " )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
             
                
            }//zstack
        .fullScreenCover(isPresented: $showOnBoarding) {
            BoardsView(showOnBoarding: $showOnBoarding)
        }
        }//nav
        
    }
    
    //MARK: FUNCTION FOR LOG IN AND SIGN UP
    // MARK:  Log in TO FIREBASE
    private func loginUser() {
        if self.email  == "" || self.password == ""{
            self.loginStatusMessage = "Couldn't Log in"
            showingAlert = true
            return
        }
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user"
                showingAlert = true
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")

            self.didCompleteLogInProcess()
        }
    }
    
    
    // MARK: make new account IN FIREBASE
    private func createNewAccount() {
        
        if self.username == "" || self.email  == "" || self.password == ""{
            self.loginStatusMessage = "Couldn't Create user"
            showingAlert = true
            return
        }
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Couldn't Create user"
                showingAlert = true
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.storeUserInformation()
        }
    }
    
    
    private func storeUserInformation(){
        guard let uid = Firebase.Auth.auth().currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "username": self.username]
        Firebase.Firestore.firestore().collection("users").document(uid).setData(userData){ err in
            if let err = err {
                print(err)
                self.loginStatusMessage = "Couldn't Create user"
                showingAlert = true
                return
            }
            print("success")
            self.didCompleteLogInProcess()
//            self.loginStatusMessage = "Your account is being"
//            showingAlert = true

        }
    }//store
    private func handleAccountAction()
    {
        if  isLoginMode {
            //log in
            loginUser()
        }else{
            // create an account
            createNewAccount()
        }
    }//handle
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(didCompleteLogInProcess: {})
    }
}
