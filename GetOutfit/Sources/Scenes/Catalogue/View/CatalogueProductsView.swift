//
//  CatalogueProductsView.swift
//  GetOutfit
//

import SwiftUI
import Kingfisher

struct CatalogueProductsView: View {
  @ObservedObject private var viewModel: CatalogueProductsViewModel
  
  init(viewModel: CatalogueProductsViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    if viewModel.isLoading {
      ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
    } else {
      ScrollView(.vertical, showsIndicators: false) {
        LazyVStack(alignment: .leading, spacing: 24) {
          HStack {
            Text(viewModel.title)
              .font(.appRegular(size: 40))
            Spacer()
          }.padding(.bottom, 8)
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
        }.padding(.horizontal, 24)
          .padding(.top, 16)
          .padding(.bottom, 40)
      }
    }
  }
}
