//
//  CardsViewController.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/12/18.
//

import UIKit

class CardsViewController: UIViewController {
    
    // MARK: - Instance properties
    
    let cardsCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        
        let width = UIScreen.main.bounds.width
        flow.itemSize = CGSize(width: width / 5, height: 100)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let arrangeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.arrange, for: .normal)
        button.backgroundColor = .customDarkBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapArrange), for: .touchUpInside)
        return button
    }()
    
    let reshuffleButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.reshuffle, for: .normal)
        button.backgroundColor = .customDarkBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapReshuffle), for: .touchUpInside)
        return button
    }()
    
    var deck: Deck?
    
    var cards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.cardsCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        cardsCollectionView.dataSource = self
        addSubViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func addSubViews() {
        view.addSubview(containerView)
        containerView.addSubview(cardsCollectionView)
        containerView.addSubview(arrangeButton)
        containerView.addSubview(reshuffleButton)
    }
    
    private func setupConstraints() {
        containerView.constraintToSafeAreaLayoutGuideTo(view: view)
        
        cardsCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        cardsCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        cardsCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        cardsCollectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7).isActive = true
        
        arrangeButton.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 20).isActive = true
        arrangeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        arrangeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        arrangeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        reshuffleButton.topAnchor.constraint(equalTo: arrangeButton.bottomAnchor, constant: 20).isActive = true
        reshuffleButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        reshuffleButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        reshuffleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    // MARK: - Actions
    
    @objc private func didTapArrange() {
        print("Arranging cards by sequence of: CLUBS -> HEARTS -> SPADES -> DIAMONDS!")
        cards = SuperUtility.shared.sort(cards)
        for card in cards {
            if card.value == "JACK" ||
                card.value == "QUEEN" ||
                card.value == "KING" ||
                card.value == "ACE" {
                continue
            }
            print("Current card code following the same sequence: \(card.code)")
        }
    }
    
    @objc private func didTapReshuffle() {
        print("Reshuffling")
        let loadingSpinnerViewController = LoadingSpinnerViewController()
        add(loadingSpinnerViewController)
        guard let deck = deck else { return }
        let shuffleService = Service.shuffleDeckOfCards(withID: deck.deckID)
        DeckService(service: shuffleService).get { [unowned self] (result) in
            switch result {
            case .failure(let error):
                print(error as Any)
            case .success(let deck):
                let getDeckService = Service.getDeckOfCards(withID: deck.deckID)
                GetDeckService(service: getDeckService).get(completion: { (result) in
                    switch result {
                    case .failure(let error):
                        print(error as Any)
                    case .success(let newDeck):
                        self.deck = newDeck
                        self.cards = newDeck.cards
                        DispatchQueue.main.async {
                            loadingSpinnerViewController.remove()
                        }
                        print(SuperUtility.shared.findPairs(self.cards, sumValue: 13))
                    }
                })
            }
        }
    }
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        let card = cards[indexPath.row]
        cell.cardImageView.loadImageUsingCache(withUrlString: card.imageURLString)
        
        return cell
    }
    
    
}
