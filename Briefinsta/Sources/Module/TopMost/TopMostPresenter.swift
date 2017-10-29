//
//  TopMostPresenter.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol TopMostPresenterProtocol: class, BasePresenterProtocol {
  // View -> Presenter
  func onViewDidLoad()
  
  // TableView
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func didSelectTableViewRowAt(indexPath: IndexPath)
  func configureCell(_ cell: TopMostViewCell, for indexPath: IndexPath)
  
  // CollectionView
  func numberOfItemsInSection(in section: Int) -> Int
  func configureMediumCell(_ cell: InstagramMediumCell, in section: Int, for indexPath: IndexPath)
}


protocol TopMostInteractorOutputProtocol: class {
  // Interactor -> Presenter
  func presentEmptySection() // no account
  func presentLoadedSection(media: [TopMostViewSection])
  func presentAlertController(with message: String)
}


final class TopMostPresenter {
  
  // MARK: Properties
  
  weak var view: TopMostViewProtocol!
  private let wireframe: TopMostWireframeProtocol
  private let interactor: TopMostInteractorInputProtocol
  
  private var sections: [TopMostViewSection]?
  
  
  // MARK: Initializing
  
  init(view: TopMostViewProtocol,
       wireframe: TopMostWireframeProtocol,
       interactor: TopMostInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
  }
  
  fileprivate func fetchInstagramMedia() {
    self.interactor.loadInstagramMedia()
  }
  
}


// MARK: - TopMostPresenterProtocol

extension TopMostPresenter: TopMostPresenterProtocol {
  
  func onViewDidLoad() {
    self.fetchInstagramMedia()
  }
  
  func numberOfSections() -> Int {
    if self.sections != nil {
      return 1
    }
    return 0
  }
  
  func numberOfRows(in section: Int) -> Int {
    if self.sections != nil {
      return self.sections?.count ?? 0
    }
    return 0
  }
  
  func numberOfItemsInSection(in section: Int) -> Int {
    if self.sections != nil {
      return self.sections![section].items.count
    }
    return 0
  }
  
  func didSelectTableViewRowAt(indexPath: IndexPath) {
    
  }
  
  func configureCell(_ cell: TopMostViewCell, for indexPath: IndexPath) {
    guard let sections = self.sections else { return }
    cell.configure(title: sections[indexPath.row].title)
  }
  
  func configureMediumCell(_ cell: InstagramMediumCell, in section: Int, for indexPath: IndexPath) {
    guard let sections = self.sections else { return }
    cell.configure(viewModel: sections[section].items[indexPath.row])
  }
  
}


// MARK: - TopMostInteractorOutputProtocol

extension TopMostPresenter: TopMostInteractorOutputProtocol {
  
  func presentEmptySection() {
    let emptyItems = [InstagramMediaViewModel.sample(), InstagramMediaViewModel.sample(), InstagramMediaViewModel.sample()]
    self.sections = [
      TopMostViewSection(title: "Best Posts", items: emptyItems),
      TopMostViewSection(title: "Most Comment Posts", items: emptyItems),
      TopMostViewSection(title: "Most Like Posts", items: emptyItems),
      TopMostViewSection(title: "Recent Posts", items: emptyItems),
    ]
    
    DispatchQueue.main.async {
      self.view.displayLoadedMedia()
    }
  }
  
  func presentLoadedSection(media: [TopMostViewSection]) {
    self.sections = media
    DispatchQueue.main.async {
      self.view.displayLoadedMedia()
    }
  }
  
  func presentAlertController(with message: String) {
    print("presentAlertController")
  }
  
}
