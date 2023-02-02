//
//  OnBoradView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 18/01/2023.
//

import SwiftUI
//import SDWebImageSwiftUI

struct OnBoradView: View {
    let image: String
    let title: String
    let description: String
    let showDismissButton: Bool
    @Binding var showOnBoarding : Bool

    var body: some View {
       
        VStack(spacing: 20){
            LottieView(fileName:  image, height: 250, width: 250)
                .scaledToFit()
                .frame(width: 250, height: 250)
//                .padding()
            
            Text(title)
                .font(.title).bold()
            
            Text(description).multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            if showDismissButton{
                
                Button{
                    showOnBoarding.toggle()

                }label: {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .frame(width: 150,height: 20)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
        }
    }
}

//struct OnBoradView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnBoradView(image: "arrow.right", title: "hello", description: "hey", showDismissButton: true)
//    }
//}
