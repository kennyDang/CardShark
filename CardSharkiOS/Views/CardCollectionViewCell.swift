//
//  CardCollectionViewCell.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/12/18.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Instance properties
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        backgroundColor = .white
        addSubview(cardImageView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        cardImageView.constraintToEdgesOf(view: self)
    }
    
}
