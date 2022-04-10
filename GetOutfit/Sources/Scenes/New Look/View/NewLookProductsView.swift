//
//  NewLookProductsView.swift
//  GetOutfit
//

import SwiftUI
import Kingfisher

struct NewLookProductsView: View {
  private let viewModel: NewLookProductsViewModel
  
  init(viewModel: NewLookProductsViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 24) {
          HStack {
            Text("Ваш заказ")
              .font(.appRegular(size: 32))
            Spacer()
          }.padding(.horizontal, 24)
          ForEach(viewModel.products.indices, id: \.self) { index in
            makeItemView(product: viewModel.products[index])
          }
        }.padding(.top, 16)
          .padding(.bottom, 144)
      }
      VStack {
        Spacer()
        HStack(spacing: 0) {
          HStack {
            Spacer()
            Text(viewModel.totalPrice)
              .font(.appBold(size: 24))
            Spacer()
          }
          Button {
            viewModel.finish()
          } label: {
            HStack {
              Spacer()
              Text("Купить")
                .foregroundColor(.white)
                .font(.appBold(size: 16))
              Spacer()
            }
          }.frame(height: 56)
            .background(Color.accent)
            .cornerRadius(8)
        }.padding(.trailing, 24)
          .padding(.top, 16)
          .background(VisualEffectView(effect: UIBlurEffect(style: .regular))
                        .ignoresSafeArea()
                        .background(Color.white.opacity(0.8)))
      }
    }
  }
  
  @ViewBuilder
  private func makeItemView(product: Product) -> some View {
    HStack(alignment: .top, spacing: 16) {
      KFImage(product.imageURLs.first ?? URL(string: ""))
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 128, height: 128)
        .clipped()
      VStack(alignment: .leading, spacing: 8) {
        Text(product.name)
          .font(.appRegular(size: 24))
          .multilineTextAlignment(.leading)
          .lineLimit(3)
        HStack {
          Text("\(product.price) ₽")
            .font(.appBold(size: 16))
          Spacer()
        }
      }
    }.padding(.horizontal, 24)
  }
}
