//
//  SettingPresenter.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol SettingPresenterProtocol: class, BasePresenterProtocol {
  // View -> Presenter
  
  // TableView
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func didSelectTableViewRowAt(indexPath: IndexPath)
  func configureHeader(_ cell: SettingHeaderType, in section: Int)
  func configureCell(_ cell: SettingViewTableCellType, for indexPath: IndexPath)
  
  // Navigation
}

protocol SettingInteractorOutputProtocol: class {
  // Interactor -> Presenter
  func setUsername(_ username: String)
}

final class SettingPresenter {
  
  // MARK: Properties
  
  weak var view: SettingViewProtocol!
  private let wireframe: SettingWireframeProtocol
  private let interactor: SettingInteractorInputProtocol
  
  private var username: String!
  private var sections: [SettingViewSection]
  
  
  // MARK: Initializing
  
  init(view: SettingViewProtocol,
       wireframe: SettingWireframeProtocol,
       interactor: SettingInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
    
    let aboutSection = SettingViewSection.about([
      .version("version", "1.0.0"),
      .openSource("Open Source Licenses"),
      .icons("Icons"),
    ])
    let accountSection = SettingViewSection.account([.account])
    let logoutSection = SettingViewSection.delete([.delete("Delete all data")])
    
    self.sections = [aboutSection] + [accountSection] + [logoutSection]
  }
  
}


// MARK: - SettingPresenterProtocol

extension SettingPresenter: SettingPresenterProtocol {
  
  func onViewDidLoad() {
    print("Presenter.onViewDidLoad")
  }
  
  // MARK: TableView
  
  func numberOfSections() -> Int {
    return self.sections.count
  }
  
  func numberOfRows(in section: Int) -> Int {
    return self.sections[section].items.count
  }
  
  func didSelectTableViewRowAt(indexPath: IndexPath) {
    switch self.sections[indexPath.section].items[indexPath.row] {
    case .icons:
      guard let url = URL(string: "https://icons8.com") else { return }
      self.wireframe.navigate(to: .icons8(url: url))

    case .openSource:
      self.wireframe.navigate(to: .openSourceLicenses)

    case .account:
      self.wireframe.navigate(to: .editAccount)
    case .delete:
    //TODO: Delete action
      print("Tapped delete all data!!!")
      
    default:
      print("Presenter.didSelectTableViewRowAt")
    }
  }
  
  func configureHeader(_ cell: SettingHeaderType, in section: Int) {
    cell.configure(text: self.sections[section].headerName)
  }
  
  func configureCell(_ cell: SettingViewTableCellType, for indexPath: IndexPath) {
    switch self.sections[indexPath.section].items[indexPath.row] {
    case .account:
      cell.configure(text: "User Account")
    case .version(let title, _):
      cell.configure(text: title)
    case .icons(let title):
      cell.configure(text: title)
    case .openSource(let title):
      cell.configure(text: title)
    case .delete(let title):
      cell.configure(text: title)
    default:
      cell.configure(text: "test")
    }
  }
  
  
  // MARK: Navigation

}


// MARK: - SettingInteractorOutputProtocol

extension SettingPresenter: SettingInteractorOutputProtocol {
  
  func setUsername(_ username: String) {
    self.username = username
    self.view.stopNetworking()
  }
  
}

