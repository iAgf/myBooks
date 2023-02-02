//
//  ResetPasswordView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 16/01/2023.
//

import SwiftUI
import Firebase
struct ResetPasswordView: View {
    @State  private var email: String = ""
    @Environment(\.presentationMode) var presentationMode
    @FocusState var isFocused : Bool // 1
    @State var errorMessage = ""
    @State private var isLoading = false

    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.right")
                        .font(Font.body.bold())
                        .foregroundColor(.black)
                        .padding()
                }//label
                .padding(.top)
                .padding(.trailing)
            }
            Text("Forget password")
                .font(.system(size: 30))
            
            Text("\(errorMessage)")
                .padding(.top,8)
                .foregroundColor(Color(.darkGray))
            TextField("enter your email", text: $email)
                .focused($isFocused) //2
            
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button {
                //forget password
                resetPassword(email: email)
            } label: {
                Text("Reset password")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            
            Spacer()
            
        }.padding()
            .onTapGesture {
                isFocused = false
            }
    }
    
    
    
    func resetPassword(email: String){
        Firebase.Auth.auth().sendPasswordReset(withEmail: email){ error in
            if error != nil {
                print("error")
                errorMessage = "something wrong happened please try again"
                return
            }
            print("success")
            errorMessage = "please check your email"

        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
