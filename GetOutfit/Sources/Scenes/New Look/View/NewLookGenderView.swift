//
//  NewLookGenderView.swift
//  GetOutfit
//

import SwiftUI

struct NewLookGenderView: View {
  private let viewModel: NewLookGenderViewModel
  
  init(viewModel: NewLookGenderViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 24) {
      Text("Какой образ?")
        .font(.appRegular(size: 32))
      ZStack {
        Image(.maleBackground)
          .resizable()
          .aspectRatio(contentMode: .fill)
        Text("Мужской")
          .foregroundColor(.white)
          .font(.appRegular(size: 32))
      }.onTapGesture {
        viewModel.didSelectGender(.male)
      }
      ZStack {
        Image(.femaleBackground)
          .resizable()
          .aspectRatio(contentMode: .fill)
        Text("Женский")
          .foregroundColor(.white)
          .font(.appRegular(size: 32))
      }.onTapGesture {
        viewModel.didSelectGender(.female)
      }
      ZStack {
        Image(.nonbinaryBackground)
          .resizable()
          .aspectRatio(contentMode: .fill)
        Text("Небинарный")
          .foregroundColor(.white)
          .font(.appRegular(size: 32))
      }.onTapGesture {
        viewModel.didSelectGender(.nonbinary)
      }
    }.padding(EdgeInsets(top: 16, leading: 24, bottom: 24, trailing: 24))
  }
}
