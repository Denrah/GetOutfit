//
//  SearchView.swift
//  GetOutfit
//

import Kingfisher
import SwiftUI

struct SearchView: View {
  @ObservedObject private var viewModel: SearchViewModel
  
  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 0) {
        ForEach(viewModel.products.indices, id: \.self) { index in
          HStack(spacing: 8) {
            if let imageURL = viewModel.products[index].imageURLs.first {
              KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 88, height: 88)
            }
            VStack(alignment: .leading, spacing: 8) {
              Text(viewModel.products[index].name)
                .font(.appRegular(size: 24))
                .lineLimit(2)
              HStack(spacing: 0) {
                Text("\(viewModel.products[index].price) ₽")
                  .font(.appBold(size: 16))
                Spacer(minLength: 0)
              }
            }
          }.padding(.horizontal, 24)
            .padding(.vertical, 16)
            .onTapGesture {
              viewModel.select(product: viewModel.products[index])
            }
        }
      }
    }.background(Color.white)
  }
}
