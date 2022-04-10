//
//  CatalogueView.swift
//  GetOutfit
//

import SwiftUI

struct CatalogueView: View {
  private let viewModel: CatalogueViewModel
  
  init(viewModel: CatalogueViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(alignment: .leading, spacing: 24) {
        HStack {
          Text("Каталог")
            .font(.appRegular(size: 40))
          Spacer()
        }.padding(.bottom, 8)
        ForEach(viewModel.categories.indices, id: \.self) { index in
          Button {
            viewModel.select(category: viewModel.categories[index])
          } label: {
            Text("\(viewModel.categories[index].name) →")
              .foregroundColor(.black)
              .font(.appRegular(size: 24))
              .multilineTextAlignment(.leading)
          }
        }
      }.padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 40)
    }
  }
}
