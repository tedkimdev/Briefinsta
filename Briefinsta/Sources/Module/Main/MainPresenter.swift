//
//  MainPresenter.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol: class, BasePresenterProtocol {
  // View -> Presenter
  func reloadData()
  
  // Navigation
  func editAccount()
}

protocol MainInteractorOutputProtocol: class {
  // Interactor -> Presenter
}

final class MainPresenter {
  
  // MARK: Properties
  
  weak var view: MainViewProtocol!
  private let wireframe: MainWireframeProtocol
  private let interactor: MainInteractorInputProtocol
  
  
  // MARK: Initializing
  
  init(view: MainViewProtocol,
       wireframe: MainWireframeProtocol,
       interactor: MainInteractorInputProtocol) {
    self.view = view
    self.wireframe = wireframe
    self.interactor = interactor
  }
  
}


// MARK: - MainPresenterProtocol

extension MainPresenter: MainPresenterProtocol {
  
  func onViewDidLoad() {
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


// MARK: - MainInteractorOutputProtocol

extension MainPresenter: MainInteractorOutputProtocol {
  
}
