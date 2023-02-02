//
//  LottieView.swift
//  myBooks
//
//  Created by Alghalya Alhees on 15/12/2022.
//
import SwiftUI
import Lottie
//import lott
import UIKit

struct LottieView: UIViewRepresentable {
    //MARK: LOTTIE MODEL
    typealias UIViewType = UIView
    var fileName: String
    var height : Int
    var width : Int


    func makeUIView(context: UIViewRepresentableContext<LottieView>) ->  UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: fileName)
        animationView.frame = CGRect(x: 0 , y: 0, width: width, height: height)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor ),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context)
    {
    }
}



