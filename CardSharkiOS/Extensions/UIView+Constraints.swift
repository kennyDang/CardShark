//
//  UIView+Constraints.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/12/18.
//

import UIKit

extension UIView {
    func constraintToSafeAreaLayoutGuideTo(view: UIView) {
        let safeAreaLayoutGuides = view.safeAreaLayoutGuide
        self.leadingAnchor.constraint(equalTo: safeAreaLayoutGuides.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: safeAreaLayoutGuides.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: safeAreaLayoutGuides.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuides.bottomAnchor).isActive = true
    }
    
    func constraintToEdgesOf(view: UIView) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
