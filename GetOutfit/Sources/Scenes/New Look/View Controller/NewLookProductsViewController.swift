//
//  NewLookProductsViewController.swift
//  GetOutfit
//

import SwiftUI
import UIKit

class NewLookProductsViewController: BaseViewController {
  private var hostingController: UIHostingController<NewLookProductsView>?
  
  init(viewModel: NewLookProductsViewModel) {
    super.init(nibName: nil, bundle: nil)
    
    let rootView = NewLookProductsView(viewModel: viewModel)
    hostingController = UIHostingController(rootView: rootView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let hostingController = hostingController else { return }
    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.didMove(toParent: self)
    hostingController.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
