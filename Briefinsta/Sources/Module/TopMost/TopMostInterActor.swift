//
//  TopMostInterActor.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 28..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

protocol TopMostInteractorInputProtocol: class {
  // Presenter -> Interactor
}


final class TopMostInteractor {
  
  // MARK: Properties
  
  weak var presenter: TopMostInteractorOutputProtocol!
  private let dataService: DataServiceType
  
  
  // MARK: Initializing
  
  init(dataService: DataServiceType) {
    self.dataService = dataService
  }
  
}


// MARK: - InteractorInputProtocol

extension TopMostInteractor: TopMostInteractorInputProtocol {
}
