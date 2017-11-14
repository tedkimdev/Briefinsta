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
  func configureCell(_ cell: TopMostViewCellType, for indexPath: IndexPath)
  
  // CollectionView
  func numberOfItemsInSection(in section: Int) -> Int
  func configureMediumCell(_ cell: InstagramMediumCellType, in section: Int, for indexPath: IndexPath)
//  func cellSize(sizeForItemAt indexPath: IndexPath) -> CGSize
  func isEmpty(in section: Int, at indexPath: IndexPath) -> Bool
}


protocol TopMostInteractorOutputProtocol: class {
  // Interactor -> Presenter
  func presentEmptySection() // no account
  func presentLoadedSection(media: [TopMostViewSection])
  func presentAlertController(with message: String)
}


final class TopMostPresenter {
  
  // MARK: Properties
  
  weak var view: TopMostViewProtocol?
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
  
  func configureCell(_ cell: TopMostViewCellType, for indexPath: IndexPath) {
    guard let sections = self.sections else { return }
    cell.configure(title: sections[indexPath.row].title)
  }
  
  func configureMediumCell(_ cell: InstagramMediumCellType, in section: Int, for indexPath: IndexPath) {
    guard let sections = self.sections,
      sections[section].items.count > indexPath.row else { return }
//    print(sections[section].items.count, indexPath.row)
    cell.configure(viewModel: sections[section].items[indexPath.row])
  }
  
  func isEmpty(in section: Int, at indexPath: IndexPath) -> Bool {
    guard let sections = self.sections,
      sections[section].items.count > indexPath.row else { return false }
    return true
  }
  
}


// MARK: - TopMostInteractorOutputProtocol

extension TopMostPresenter: TopMostInteractorOutputProtocol {
  
  func presentEmptySection() {
    let emptyItems = [InstagramMediaViewModel.sample(), InstagramMediaViewModel.sample(), InstagramMediaViewModel.sample()]
    self.sections = [
      TopMostViewSection(title: "Best Posts", items: emptyItems),
      TopMostViewSection(title: "Most Commented Posts", items: emptyItems),
      TopMostViewSection(title: "Most Liked Posts", items: emptyItems),
      TopMostViewSection(title: "Recent Posts", items: emptyItems),
    ]
    
    DispatchQueue.main.async {
      self.view?.displayLoadedMedia()
    }
  }
  
  func presentLoadedSection(media: [TopMostViewSection]) {
    self.sections = media
    DispatchQueue.main.async {
      self.view?.displayLoadedMedia()
    }
  }
  
  func presentAlertController(with message: String) {
//    print("presentAlertController")
  }
  
}
