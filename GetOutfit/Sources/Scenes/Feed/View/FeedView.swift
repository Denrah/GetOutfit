//
//  FeedView.swift
//  GetOutfit
//

import SwiftUI

struct FeedView: View {
  @ObservedObject private var viewModel: FeedViewModel
  
  init(viewModel: FeedViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      HStack {
        Text("Идеи")
          .font(.appRegular(size: 40))
        Spacer()
        Button {
          viewModel.didTapSearch()
        } label: {
          Image(.search)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
        }
      }.padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
      ScrollView(.vertical, showsIndicators: false) {
        LazyVStack(spacing: 48) {
          ForEach(viewModel.cellViewModels.indices, id: \.self) { index in
            LookCellView(viewModel: viewModel.cellViewModels[index])
          }
        }
      }
    }
  }
}
