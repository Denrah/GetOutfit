//
//  NewLookConstructorView.swift
//  GetOutfit
//

import SwiftUI
import Kingfisher

struct NewLookConstructorView: View {
  @ObservedObject private(set) var viewModel: NewLookConstructorViewModel
  
  init(viewModel: NewLookConstructorViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    if viewModel.isLoading {
      makeProgressView()
    } else {
      makeConstructorView()
    }
  }
  
  @ViewBuilder
  private func makeProgressView() -> some View {
    Text(viewModel.progress)
      .font(.appRegular(size: 32))
  }
  
  @ViewBuilder
  private func makeConstructorView() -> some View {
    GeometryReader { proxy in
      ZStack {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 32) {
            HStack {
              Text("Настройте образ")
                .font(.appRegular(size: 32))
              Spacer()
            }.padding(.top, 16)
              .padding(.horizontal, 24)
            ForEach(viewModel.products.indices, id: \.self) { typeIndex in
              ZStack(alignment: .center) {
                TabView(selection: $viewModel.selectedIndices[typeIndex]) {
                  ForEach(viewModel.products[typeIndex].indices, id: \.self) { productIndex in
                    if let imageURL = viewModel.products[typeIndex][productIndex].imageURLs.first {
                      KFImage(imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width, height: 272)
                        .tag(productIndex)
                    }
                  }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                  .frame(width: proxy.size.width, height: 272)
                HStack {
                  Button {
                    if viewModel.selectedIndices[typeIndex] > 0 {
                      withAnimation {
                        viewModel.selectedIndices[typeIndex] -= 1
                      }
                    }
                  } label: {
                    Image(.arrowLeft)
                  }
                  Spacer()
                  Button {
                    if viewModel.selectedIndices[typeIndex] + 1 < viewModel.products[typeIndex].count {
                      withAnimation {
                        viewModel.selectedIndices[typeIndex] += 1
                      }
                    }
                  } label: {
                    Image(.arrowRight)
                  }
                }.padding(.horizontal, 24)
              }
            }
          }.padding(.bottom, 144)
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
              viewModel.proceed()
            } label: {
              HStack {
                Spacer()
                Text("Продолжить")
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
}
