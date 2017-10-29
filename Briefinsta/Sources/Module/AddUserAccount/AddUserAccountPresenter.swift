//
//  AddUserAccountPresenter.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 26..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol AddUserAccountPresenterProtocol: class, BasePresenterProtocol {
  // View -> Presenter
  func doneButtonDidTap(with username: String)
  func cancelButtonDidTap()
  
  // TableView
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func didSelectTableViewRowAt(indexPath: IndexPath)
  func configureHeader(_ cell: AddUserAccountHeaderFooterType, in section: Int)
  func configureFooter(_ cell: AddUserAccountHeaderFooterType, in section: Int)
  func configureCell(_ cell: AddUserAccountCell, for indexPath: IndexPath)
  
  // Navigation
  
}

protocol AddUserAccountInteractorOutputProtocol: class {
  // Interactor -> Presenter
  func presentAlertController(message: String)
  func presentAnalysisCompleted()
  func presentAddUserAccount()
}

final class AddUserAccountPresenter {
  
  // MARK: Properties
  
  weak var view: AddUserAccountViewProtocol!
  private let wireframe: AddUserAccountWireframeProtocol
  private let interactor: AddUserAccountInteractorInputProtocol
  
  private var username: String = ""
  private var sections: [AddUserAccountViewSection]
  
  
  // MARK: Initializing
  
  init(view: AddUserAccountViewProtocol,
       wireframe: AddUserAccountWireframeProtocol,
       interactor: AddUserAccountInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
    
    let addUserAccountSection = AddUserAccountViewSection.editAccount([.editAccount])
    
    self.sections = [addUserAccountSection]
  }
  
}


// MARK: - AddUserAccountPresenterProtocol

extension AddUserAccountPresenter: AddUserAccountPresenterProtocol {
  
  func onViewDidLoad() {
    self.view.displayAddUserAccount()
  }
  
  func doneButtonDidTap(with username: String) {
    self.view.displayLoadingUserAccount()
    self.interactor.validateAccount(with: username)
  }
  
  func cancelButtonDidTap() {
    self.interactor.deleteAllData()
    self.view.displayAddUserAccount()
  }
  
  func validateUserAccount(with username: String) {
    self.interactor.validateAccount(with: "leagueoflegendskorea")
//    self.interactor.validateAccount(with: username)
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
    default:
      print("Presenter.didSelectTableViewRowAt")
    }
  }
  
  func configureHeader(_ cell: AddUserAccountHeaderFooterType, in section: Int) {
    switch self.sections[section] {
    case .editAccount:
      cell.configure(text: "Briefinsta is only available for public instagram account.")
    }
  }
  
  func configureFooter(_ cell: AddUserAccountHeaderFooterType, in section: Int) {
    switch self.sections[section] {
      case .editAccount:
        cell.configure(text: "It takes a few minutes to make a report.")
    }
  }
  
  func configureCell(_ cell: AddUserAccountCell, for indexPath: IndexPath) {
    switch self.sections[indexPath.section].items[indexPath.row] {
    case .editAccount:
      if !self.username.isEmpty {
        cell.configure(text: self.username)
      }
    }
  }
  
}


// MARK: - AddUserAccountInteractorOutputProtocol

extension AddUserAccountPresenter: AddUserAccountInteractorOutputProtocol {
  
  func presentAddUserAccount() {
    DispatchQueue.main.async {
      self.view.displayAddUserAccount()
    }
  }
  
  func presentAlertController(message: String) {
    self.presentAddUserAccount()
    DispatchQueue.main.async {
      self.wireframe.navigate(to: .alert(title: "Error", message: message))
    }
  }
  
  func presentAnalysisCompleted() {
    self.presentAddUserAccount()
    DispatchQueue.main.async {
      self.wireframe.navigate(to: .completed(title: "Completed", message: "Now you can see reports."))
    }
  }
  
}
