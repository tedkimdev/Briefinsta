//
//  ServiceResult.swift
//  Briefinsta
//
//  Created by aney on 2017. 10. 25..
//  Copyright © 2017년 Ted Kim. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case error(Error)
}

enum ServiceError: Error {
  case error
}
