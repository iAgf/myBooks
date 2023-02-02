//
//  HomeCustomNavBar.swift
//  myBooks
//
//  Created by Alghalya Alhees on 15/12/2022.
//

import SwiftUI

struct HomeCustomNavBar: View {
    
    var customTitle:String
    var EnableDissmiss: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        //MARK: NAV BAR
        HStack{
            //MARK: BUTTON
            if EnableDissmiss{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(Font.body.bold())
                        .foregroundColor(.black)
                        .padding()
                }//label
                .padding(.top)
                .padding(.trailing)
            }//if enable
            Spacer()
            Text(customTitle)
                .font(.system(size: 30,weight: .bold))
                .padding(.horizontal, 8)
        }//hstack
        .padding(8)
        .padding(.top,50)
    }//view
}

struct HomeCustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeCustomNavBar(customTitle: "Home", EnableDissmiss: true)
    }
}
