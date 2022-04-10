//
//  LookCellView.swift
//  GetOutfit
//

import SwiftUI
import Kingfisher

struct LookCellView: View {
  @ObservedObject private var viewModel: LookCellViewModel
  
  init(viewModel: LookCellViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 16) {
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
      GeometryReader { proxy in
        HStack(spacing: 8) {
          makeImage(item: viewModel.items.element(at: 0),
                    width: (proxy.size.width - 64) / 3,
                    height: 160,
                    fontSize: 12,
                    padding: 8)
          VStack(spacing: 8) {
            makeImage(item: viewModel.items.element(at: 1),
                      width: (proxy.size.width - 64) / 3,
                      height: 76,
                      fontSize: 10,
                      padding: 4)
            HStack(spacing: 8) {
              makeImage(item: viewModel.items.element(at: 2),
                        width: (proxy.size.width - 64) / 6 - 4,
                        height: 76,
                        fontSize: 10,
                        padding: 4)
              makeImage(item: viewModel.items.element(at: 3),
                        width: (proxy.size.width - 64) / 6 - 4,
                        height: 76,
                        fontSize: 10,
                        padding: 4)
            }
          }.frame(width: (proxy.size.width - 64) / 3)
          makeImage(item: viewModel.items.element(at: 4),
                    width: (proxy.size.width - 64) / 3,
                    height: 160,
                    fontSize: 12,
                    padding: 8)
        }.padding(.horizontal, 24)
      }.frame(height: 160)
      ZStack {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(spacing: 8) {
            ForEach(viewModel.photoURLs.indices, id: \.self) { index in
              KFImage(viewModel.photoURLs[index])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 144)
            }
          }.padding(.horizontal, 24)
        }
        HStack{
          Spacer()
          VStack {
            Spacer()
          }.frame(width: 24)
            .background(LinearGradient(colors: [.white.opacity(0), .white], startPoint: .leading, endPoint: .trailing))
        }.frame(height: 144)
      }
      HStack {
        Text("\(viewModel.totalPrice) ₽")
          .font(.appBold(size: 24))
        Spacer()
        Text("Подробнее →")
          .font(.appRegular(size: 16))
      }.padding(.horizontal, 24)
    }.onTapGesture {
      viewModel.didTapView()
    }
  }
  
  @ViewBuilder
  func makeImage(item: LookItem?,
                 width: CGFloat,
                 height: CGFloat,
                 fontSize: CGFloat,
                 padding: CGFloat) -> some View {
    if let item = item {
      ZStack(alignment: .bottom) {
        KFImage(item.imageURL)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: width, height: height)
          .clipped()
        VStack(alignment: .leading, spacing: 4) {
          Text(item.name)
            .font(.appRegular(size: fontSize))
            .foregroundColor(.white)
            .lineLimit(2)
          HStack(spacing: 0) {
            Text("\(item.price) ₽")
              .font(.appBold(size: fontSize))
              .foregroundColor(.white)
              .lineLimit(2)
            Spacer(minLength: 0)
          }
        }.padding(padding)
          .background(LinearGradient(colors: [.black, .black.opacity(0)], startPoint: .bottom, endPoint: .top))
      }
    } else {
      HStack {}.frame(width: width, height: height).background(Color.shade0)
    }
  }
}
