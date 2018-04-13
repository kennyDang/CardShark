//
//  Cell+ReuseIdentifer.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/12/18.
//

import UIKit

protocol Reuseable {
    static var reuseIdentifier: String { get }
}

extension Reuseable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell: Reuseable {}
