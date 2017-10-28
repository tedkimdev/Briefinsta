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
  func reloadData()
  
  func doneButtonDidTap(with username: String)
  func validateUserAccount(with username: String)
  
  // TableView
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func didSelectTableViewRowAt(indexPath: IndexPath)
  func configureHeader(_ cell: AddUserAccountHeaderFooterType, in section: Int)
  func configureFooter(_ cell: AddUserAccountHeaderFooterType, in section: Int)
  func configureCell(_ cell: AddUserAccountCellType, for indexPath: IndexPath)
  
  // Navigation
  func editAccount()
}

protocol AddUserAccountInteractorOutputProtocol: class {
  // Interactor -> Presenter
  func presentAlertController(message: String)
}

final class AddUserAccountPresenter {
  
  // MARK: Properties
  
  weak var view: AddUserAccountViewProtocol!
  private let wireframe: AddUserAccountWireframeProtocol
  private let interactor: AddUserAccountInteractorInputProtocol
  
  private var username: String!
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
    print("Presenter.onViewDidLoad")
  }
  
  func reloadData() {
  }
  
  func editAccount() {
  }
  
  func doneButtonDidTap(with username: String) {
    self.interactor.validateAccount(with: username)
  }
  func validateUserAccount(with username: String) {
    self.interactor.validateAccount(with: "chchoitoi")
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
    cell.configure(text: "Briefinsta is only available for public instagram account.")
  }
  
  func configureFooter(_ cell: AddUserAccountHeaderFooterType, in section: Int) {
    cell.configure(text: "It takes a few minutes to make a report.")
  }
  
  func configureCell(_ cell: AddUserAccountCellType, for indexPath: IndexPath) {
    switch self.sections[indexPath.section].items[indexPath.row] {
    default:
      cell.configure(text: "test")
    }
  }
  
  
  // MARK: Navigation
  
  func editAddUserAccount() {
  }
  
}


// MARK: - AddUserAccountInteractorOutputProtocol

extension AddUserAccountPresenter: AddUserAccountInteractorOutputProtocol {

  func presentAlertController(message: String) {
    self.wireframe.navigate(to: .alert(title: "Error", message: message))
  }
  
}
