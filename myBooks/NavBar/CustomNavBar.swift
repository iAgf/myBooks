//
//  CustomNavBar.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
import Firebase

struct CustomNavBar: View {
    
    @State var shouldShowLogOutOption: Bool = false
    @ObservedObject private var vm  = UserManager()
    
    var body: some View {
        HStack{
            //MARK: NAV BAR FOR SIGING OUT
            Button{
                //Mark: log out
                shouldShowLogOutOption.toggle()
            }   label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.lightGray))
            }
            Spacer()
            VStack{
                Text("آهلا \(vm.bookUser?.username ?? "")")
                    .font(.system(size: 34,weight: .bold))
                    .padding(8)
            }
        }
        .padding()
        //MARK: SHOWING SIGN OUT BUTTON
        .actionSheet(isPresented: $shouldShowLogOutOption) {
            .init(title: Text("Settings"), message: Text("what do you want to do? "), buttons:
                    [
                        .destructive(Text("Sign out "), action: {
                            print("SIGN OUT")
                            vm.handleSignOut()
                        }),
                        .cancel()
                    ])
        }//action sheet
        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut) {
            LogInView(didCompleteLogInProcess: {
                self.vm.isUserCurrentlyLoggedOut = false
                self.vm.fetchCurrentUser()
            })
            
        }//ful
    }//view
    
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar()
    }
}
