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
  func reloadData()
  
  // TableView
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func didSelectTableViewRowAt(indexPath: IndexPath)
  func configureHeader(_ cell: SettingHeaderType, in section: Int)
  func configurecell(_ cell: SettingViewTableCellType, for indexPath: IndexPath)
  
  // Navigation
  func editAccount()
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
    let logoutSection = SettingViewSection.logout([.logout("Logout")])
    
    self.sections = [aboutSection] + [accountSection] + [logoutSection]
  }
  
}


// MARK: - SettingPresenterProtocol

extension SettingPresenter: SettingPresenterProtocol {
  
  func onViewDidLoad() {
    print("Presenter.onViewDidLoad")
    
  }
  
  func reloadData() {
  }
  
  func editAccount() {
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
      self.wireframe.navigate(to: .icons8(url: url, from: self.view))

    case .openSource:
      self.wireframe.navigate(to: .openSourceLicenses)

    case .account:
      self.interactor.validateAccount(with: "chchoitoi")
      
    default:
      print("Presenter.didSelectTableViewRowAt")
    }
  }
  
  
  // MARK: Navigation
  
  func editSetting() {
    //    wireframe.navigate(to: .editSetting(interactor.currentSetting, completion: { [weak self] setting in
    //      guard let `self` = self, self.interactor.currentSetting != setting else { return }
    //      self.interactor.changeServiceSetting(to: setting)
    //      self.reloadData()
    //    }))
  }
}


// MARK: - SettingInteractorOutputProtocol

extension SettingPresenter: SettingInteractorOutputProtocol {
  
  func setUsername(_ username: String) {
    self.username = username
    self.view.stopNetworking()
  }
  
  func configureHeader(_ cell: SettingHeaderType, in section: Int) {
    cell.configure(text: self.sections[section].headerName)
  }
  
  func configurecell(_ cell: SettingViewTableCellType, for indexPath: IndexPath) {
    switch self.sections[indexPath.section].items[indexPath.row] {
    case .account:
      cell.configure(text: "User Account")
    case .version(let title, _):
      cell.configure(text: title)
    case .icons(let title):
      cell.configure(text: title)
    case .openSource(let title):
      cell.configure(text: title)
    case .logout(let title):
      cell.configure(text: title)
    default:
      cell.configure(text: "test")
    }
  }
  
}

