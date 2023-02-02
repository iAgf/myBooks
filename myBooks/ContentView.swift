//
//  ContentView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 10/12/2022.
//

import SwiftUI
struct ContentView: View {

    var body: some View {
        //MARK: TAB VIEWS FOR EACH VIEW
        TabView{
            ProfileView()
                .environmentObject(UserManager())
                .tabItem
            {
                Image(systemName: "person")
                Text("profile")
            }
            MainMessagesView()
                .tabItem
            {
                Image(systemName: "message")
                Text("message")
            }
        
            CollegeView()
                .environmentObject(BookPostModel())
                .tabItem
            {
                Image(systemName: "house")
                Text("home")
            }
        }
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
