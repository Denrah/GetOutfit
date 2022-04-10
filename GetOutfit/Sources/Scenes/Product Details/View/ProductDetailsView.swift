//
//  ProductDetailsView.swift
//  GetOutfit
//

import SwiftUI
import Kingfisher

struct ProductDetailsView: View {
  @ObservedObject private var viewModel: ProductDetailsViewModel
  @State private var selectedImage: Int = 0
  
  init(viewModel: ProductDetailsViewModel) {
    self.viewModel = viewModel
    
    UIPageControl.appearance().currentPageIndicatorTintColor = .accent
    UIPageControl.appearance().pageIndicatorTintColor = .black.withAlphaComponent(0.2)
  }
  
  var body: some View {
    GeometryReader { proxy in
      ZStack {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 0) {
            if !viewModel.imageURLs.isEmpty {
              TabView(selection: $selectedImage) {
                ForEach(viewModel.imageURLs.indices, id: \.self) { index in
                  KFImage(viewModel.imageURLs[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width)
                    .clipped().tag(index)
                }
              }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: proxy.size.width)
            }
            Text(viewModel.name)
              .font(.appRegular(size: 32))
              .padding(24)
            HStack(alignment: .top, spacing: 0) {
              makePropertyView(title: "Пол", value: viewModel.gender)
              Spacer(minLength: 0)
              makePropertyView(title: "Размер", value: viewModel.size)
              Spacer(minLength: 0)
              makePropertyView(title: "Цвет", value: viewModel.color)
            }.padding(.horizontal, 24)
              .padding(.bottom, 16)
            HStack(alignment: .top, spacing: 0) {
              makePropertyView(title: "Производитель", value: viewModel.vendor)
            }.padding(.horizontal, 24)
              .padding(.bottom, 16)
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 16) {
                ForEach(viewModel.categories.indices, id: \.self) { index in
                  HStack {
                    Text(viewModel.categories[index])
                      .font(.appRegular(size: 16))
                  }.frame(height: 32)
                    .padding(.horizontal, 16)
                    .background(Color.shade1)
                    .clipShape(Capsule())
                }
              }.padding(.horizontal, 24)
            }
          }.padding(.bottom, 140)
        }
        VStack {
          Spacer()
          HStack(spacing: 0) {
            HStack {
              Spacer()
              Text(viewModel.price)
                .font(.appBold(size: 24))
              Spacer()
            }
            Button {
              
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
  }
  
  @ViewBuilder
  private func makePropertyView(title: String, value: String) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title)
        .font(.appRegular(size: 16))
      Text(value)
        .font(.appRegular(size: 24))
    }
  }
}
