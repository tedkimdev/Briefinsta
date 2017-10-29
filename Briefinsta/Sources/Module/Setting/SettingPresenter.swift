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
  func changeMaxMediaNumber(_ maxMediaNumber: Int)
  
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
  func setUsername(_ username: String?)
  func setmaxMediaNumber(_ value: Int)
  func presentAlertController(message: String)
  func presentUpdatedSettingView()
  func presentDeletedData(message: String)
}


final class SettingPresenter {
  
  // MARK: Properties
  
  weak var view: SettingViewProtocol!
  private let wireframe: SettingWireframeProtocol
  private let interactor: SettingInteractorInputProtocol
  
  private var username: String = ""
  private var maxMediaNumber: Int = 1000
  private var sections: [SettingViewSection]
  
  
  // MARK: Initializing
  
  init(view: SettingViewProtocol,
       wireframe: SettingWireframeProtocol,
       interactor: SettingInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
    
    let aboutSection = SettingViewSection.about([
      .version("Version", "0.1"),
      .openSource("Open Source Licenses"),
      .icons("Icons"),
    ])
    let accountSection = SettingViewSection.account([.account])
    let maxPostsSection = SettingViewSection.maxPosts([.maxPosts(self.maxMediaNumber)])
    let logoutSection = SettingViewSection.delete([.delete("Delete all data")])
    
    self.sections = [aboutSection] + [accountSection] + [maxPostsSection] + [logoutSection]
  }
  
}


// MARK: - SettingPresenterProtocol

extension SettingPresenter: SettingPresenterProtocol {
  
  func onViewDidLoad() {
    self.interactor.currentUserAccount()
    self.interactor.getCurrentMaxMediaCount()
  }
  
  func changeMaxMediaNumber(_ maxMediaNumber: Int) {
    self.maxMediaNumber = maxMediaNumber
    self.interactor.changeMaxMediaNumber(self.maxMediaNumber)
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
      
    case .maxPosts:
      self.presentInputAlert()
      
    case .delete:
      self.interactor.deleteStoredMediaAll()
      
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
      let username = self.username.isEmpty ? "User Account" : self.username
      cell.configure(text: username)
      
    case .version(let text, _):
      cell.configure(text: text)
      
    case .icons(let text):
      cell.configure(text: text)
      
    case .openSource(let text):
      cell.configure(text: text)
      
    case .delete(let text):
      cell.configure(text: text)
      
//    case .github():
//      cell.configure(text: text)
      
    case .maxPosts:
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      cell.configure(text: formatter.string(from: NSNumber(integerLiteral: self.maxMediaNumber)) ?? "1,000")
      
    default:
      cell.configure(text: "")
    }
  }
  
  // MARK: Navigation

}


// MARK: - SettingInteractorOutputProtocol

extension SettingPresenter: SettingInteractorOutputProtocol {

  func setUsername(_ username: String?) {
    guard let username = username else {
      return
    }
    self.username = username
    DispatchQueue.main.async {
      self.view.reloadUI()
    }
  }
  
  func setmaxMediaNumber(_ value: Int) {
    self.maxMediaNumber = value
    DispatchQueue.main.async {
      self.view.reloadUI()
    }
  }
  
  func presentAlertController(message: String) {
    DispatchQueue.main.async {
      self.wireframe.navigate(to: .alert(title: "Completed", message: message))
    }
  }
  
  func presentDeletedData(message: String) {
    self.username = ""
    DispatchQueue.main.async {
      self.view.reloadUI()
      self.wireframe.navigate(to: .alert(title: "Completed", message: message))
    }
  }
  
  func presentUpdatedSettingView() {
    DispatchQueue.main.async {
      self.view.reloadUI()
    }
  }
  
  func presentInputAlert() {
    self.view.displayAlertInput()
  }
  
}
