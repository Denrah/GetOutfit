//
//  LookDetailsView.swift
//  GetOutfit
//

import SwiftUI
import Kingfisher

struct LookDetailsView: View {
  @ObservedObject private var viewModel: LookDetailsViewModel
  
  init(viewModel: LookDetailsViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 0) {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(viewModel.photoURLs.indices, id: \.self) { index in
                KFImage(viewModel.photoURLs[index])
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(height: 144)
              }
            }
          }.padding(.bottom, 24)
          HStack(spacing: 0) {
            KFImage(viewModel.avatarURL)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 24, height: 24)
              .clipShape(Circle())
              .padding(.trailing, 8)
            Text(viewModel.userName)
              .font(.appRegular(size: 16))
            Spacer()
            Text(viewModel.likes)
              .font(.appRegular(size: 16))
              .padding(.trailing, 8)
            Button {
              viewModel.toggleLike()
            } label: {
              Image(viewModel.isLiked ? .likeFilled : .like)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(viewModel.isLiked ? .accent : .black)
                .frame(width: 24, height: 24)
            }
          }.padding(.horizontal, 24)
            .padding(.bottom, 40)
          HStack {
            Text("Составляющие")
              .font(.appRegular(size: 32))
              .padding(.horizontal, 24)
              .padding(.bottom, 16)
            Spacer()
          }
          ForEach(viewModel.items.indices, id: \.self) { index in
            makeItemView(item: viewModel.items[index])
              .padding(.bottom, 16)
          }
        }.padding(.bottom, 140)
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
  private func makeItemView(item: LookItem) -> some View {
    HStack(alignment: .top, spacing: 16) {
      KFImage(item.imageURL)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 128, height: 128)
        .clipped()
      VStack(alignment: .leading, spacing: 8) {
        Text(item.name)
          .font(.appRegular(size: 24))
          .multilineTextAlignment(.leading)
          .lineLimit(3)
        HStack {
          Text("\(item.price) ₽")
            .font(.appBold(size: 16))
          Spacer()
        }
      }
    }.padding(.horizontal, 24)
      .onTapGesture {
        viewModel.didSelectItem(lookItem: item)
      }
  }
}
