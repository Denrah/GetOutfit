//
//  NewLookConstructorViewController.swift
//  GetOutfit
//

import SwiftUI
import UIKit

class NewLookConstructorViewController: BaseViewController {
  private var hostingController: UIHostingController<NewLookConstructorView>?
  
  init(viewModel: NewLookConstructorViewModel) {
    super.init(nibName: nil, bundle: nil)
    
    let rootView = NewLookConstructorView(viewModel: viewModel)
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
