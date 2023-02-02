//
//  BoardsView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 18/01/2023.
//

import SwiftUI

struct BoardsView: View {
    @Binding var showOnBoarding : Bool
    var body: some View {
        //MARK: BOARDING VIEW
        TabView{
            
            OnBoradView(image: "73243-happy-students-studying", title: "Welcome To UniBooks", description: "UniBooks helps you to find the books that you will need", showDismissButton: false, showOnBoarding: $showOnBoarding)
            
            OnBoradView(image: "77792-book", title: "Find Your Book", description: "UniBooks helps you to find books cheaper", showDismissButton: false, showOnBoarding: $showOnBoarding)
            
            OnBoradView(image: "31821-share-everythin-moneybooks", title: "Sell Your Book", description: "UniBooks hleps you to sell your college books ", showDismissButton: true, showOnBoarding: $showOnBoarding)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

//struct BoardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardsView(showOnBoarding: true)
//    }
//}
