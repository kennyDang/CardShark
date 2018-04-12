//
//  Gettable.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import Foundation

protocol Gettable {
    associatedtype Data
    func get(completion: @escaping(Result<Data>) -> ())
}
