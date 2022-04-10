//
//  VisualEffectView.swift
//  GetOutfit
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
  
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
      return UIVisualEffectView()
    }
  
    func updateUIView(_ uiView: UIVisualEffectView,
                      context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
