//
//  InitialViewController.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/12/18.
//

import UIKit

class InitialViewController: UIViewController {
    
    // MARK: - Instance properties
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "smile")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = Constants.title
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.textColor = UIColor.black.withAlphaComponent(0.50)
        label.text = Constants.subtitle
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dataButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.loadData, for: .normal)
        button.backgroundColor = .customDarkBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapLoadData), for: .touchUpInside)
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addSubViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func addSubViews() {
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(dataButton)
    }

    private func setupConstraints() {
        containerView.constraintToSafeAreaLayoutGuideTo(view: view)
        
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        
        dataButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 60).isActive = true
        dataButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        dataButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        dataButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func fetchShuffledDeck(id: String) {
        let getDeckService = Service.getDeckOfCards(withID: id)
        GetDeckService(service: getDeckService).get(completion: { (shuffledDeckResult) in
            switch shuffledDeckResult {
            case .failure(let err):
                print("Error shuffling deck with error: \(String(describing: err))")
            case .success(let deck):
                print("got deck: \(deck.cards)")
                let cardsViewController = CardsViewController()
                cardsViewController.cards = deck.cards
                self.navigationController?.pushViewController(cardsViewController, animated: true)
            }
        })
    }
    
    // MARK: - Actions
    
    @objc private func didTapLoadData() {
        let loadingSpinnerViewController = LoadingSpinnerViewController()
        add(loadingSpinnerViewController)
        let getDeckIDService = Service.getDeckOfCardsID
        DeckService(service: getDeckIDService).get { (result) in
            switch result {
            case .failure(let error):
                print(error as Any)
            case .success(let deck):
                let shuffleDeckService = Service.shuffleDeckOfCards(withID: deck.deckID)
                DeckService(service: shuffleDeckService).get(completion: { (result) in
                    switch result {
                    case .failure(let error):
                        print(error as Any)
                    case .success(let deck):
                        let getDeckService = Service.getDeckOfCards(withID: deck.deckID)
                        GetDeckService(service: getDeckService).get(completion: { (result) in
                            switch result {
                            case .failure(let error):
                                print(error as Any)
                            case .success(let deck):
                                DispatchQueue.main.async {
                                    loadingSpinnerViewController.remove()
                                    let cardViewController = CardsViewController()
                                    cardViewController.cards = deck.cards
                                    cardViewController.deck = deck
                                    self.navigationController?.pushViewController(cardViewController, animated: true)
                                }
                            }
                        })
                    }
                })
                
            }
        }
    }
}
