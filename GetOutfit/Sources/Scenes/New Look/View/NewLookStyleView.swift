//
//  NewLookStyleView.swift
//  GetOutfit
//

import SwiftUI
import Kingfisher

struct NewLookStyleView: View {
  enum NewLookStyleViewState {
    case styles, occasions
    
    var title: String {
      switch self {
      case .styles:
        return "Какой стиль хотите попробовать?"
      case .occasions:
        return "Какой у вас случай?"
      }
    }
    
    var toggleButtonTitle: String {
      switch self {
      case .styles:
        return "Я хочу подобрать к случаю →"
      case .occasions:
        return "Покажите мне стили →"
      }
    }
    
    mutating func toggle() {
      switch self {
      case .styles:
        self = .occasions
      case .occasions:
        self = .styles
      }
    }
  }
  
  @State private var state: NewLookStyleViewState = .styles
  
  @ObservedObject private(set) var viewModel: NewLookStyleViewModel
  
  init(viewModel: NewLookStyleViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    if viewModel.isLoading {
      ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
    } else {
      GeometryReader { proxy in
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 0) {
            Text(state.title)
              .font(.appRegular(size: 32))
              .padding(.bottom, 8)
            HStack {
              Button(state.toggleButtonTitle) {
                state.toggle()
              }.foregroundColor(.accent)
                .font(.appRegular(size: 16))
              Spacer()
            }.padding(.bottom, 24)
            switch state {
            case .styles:
              makeStylesView(proxy: proxy)
            case .occasions:
              makeOccasionsView()
            }
          }.padding(.horizontal, 24)
        }
      }
    }
  }
  
  @ViewBuilder
  private func makeStylesView(proxy: GeometryProxy) -> some View {
    HStack(alignment: .top, spacing: 16) {
      VStack(spacing: 16) {
        ForEach(viewModel.styleImageURLs[0..<(viewModel.styleImageURLs.count / 2)].indices, id: \.self) { index in
          KFImage(viewModel.styleImageURLs[index])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: (proxy.size.width - 64) / 2, height: 240)
            .clipped()
            .onTapGesture {
              viewModel.selectStyle()
            }
        }
      }
      VStack(spacing: 16) {
        ForEach(viewModel.styleImageURLs[(viewModel.styleImageURLs.count / 2)..<viewModel.styleImageURLs.count].indices, id: \.self) { index in
          KFImage(viewModel.styleImageURLs[index])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: (proxy.size.width - 64) / 2, height: 240)
            .clipped()
            .onTapGesture {
              viewModel.selectStyle()
            }
        }
      }.padding(.top, 40)
    }.padding(.bottom, 32)
  }
  
  @ViewBuilder
  private func makeOccasionsView() -> some View {
    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
      ForEach(viewModel.keys, id: \.self) { key in
        Section {
          ForEach((viewModel.occasions[key] ?? []).indices, id: \.self) { index in
            Button {
              if let occasion = viewModel.occasions[key]?[index] {
                viewModel.select(occasion: occasion)
              }
            } label: {
              Text(viewModel.occasions[key]?[index].label ?? "")
                .foregroundColor(.black)
                .font(.appRegular(size: 24))
                .padding(.bottom, 16)
            }
          }
        } header: {
          HStack {
            Text(key)
              .font(.appBold(size: 16))
            Spacer()
          }.padding(.bottom, 16)
            .padding(.top, 32)
            .background(Color.white)
        }
      }
    }
  }
}
