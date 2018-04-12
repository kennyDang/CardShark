//
//  Result.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error?)
}

typealias ResultCallBack<Value> = (Result<Value>) -> ()
