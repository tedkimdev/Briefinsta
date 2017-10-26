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
  
  
  // MARK: Initializing
  
  init(view: SettingViewProtocol,
       wireframe: SettingWireframeProtocol,
       interactor: SettingInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
  }
  
}


// MARK: - SettingPresenterProtocol

extension SettingPresenter: SettingPresenterProtocol {
  
  func onViewDidLoad() {
    print("Presenter.onViewDidLoad")
    self.interactor.validateAccount(with: "chchoitoi")
  }
  
  func reloadData() {
  }
  
  func editAccount() {
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
  
}

