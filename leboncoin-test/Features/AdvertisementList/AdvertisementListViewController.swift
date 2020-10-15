//
//  AdvertisementListViewController.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 14/10/20.
//

import UIKit

final class AdvertisementListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let viewModel: AdvertisementListViewModel
    
    init(viewModel: AdvertisementListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        collectionView = makeCollectionView()
    }
}

// MARK: - Collection View Setup
private extension AdvertisementListViewController {
    
    enum CollectionViewLayoutProperties {
        public static let numberOfItemByRow: Int = 2
        public static let cellAspectRatio: CGFloat = 3/2
        public static let minimumItemsSpacing: CGFloat = 0.0
        public static let collectionHorizontalInset: CGFloat = 5.0
    }
    
    func sizeForItem() -> CGSize {
        let numberOfItemByRow = CGFloat(CollectionViewLayoutProperties.numberOfItemByRow)
        let collectionWidth = self.collectionView.frame.width
        let itemWidth = (collectionWidth) / numberOfItemByRow - CollectionViewLayoutProperties.collectionHorizontalInset
        let itemHeight = itemWidth * CollectionViewLayoutProperties.cellAspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func makeCollectionView() -> UICollectionView {
        let collectionViewLayout = makeCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
//        collectionViewLayout.itemSize = sizeForItem()
        
        collectionView.register(AdvertisementCollectionViewCell.self, forCellWithReuseIdentifier: AdvertisementCollectionViewCell.defaultReuseIdentifier)
        
        return collectionView
    }
    
    func makeCollectionViewLayout() -> UICollectionViewFlowLayout {
        let itemsHorizontalInset = CollectionViewLayoutProperties.minimumItemsSpacing
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = sizeForItem()
        flowLayout.minimumInteritemSpacing = CollectionViewLayoutProperties.minimumItemsSpacing
        flowLayout.minimumLineSpacing = CollectionViewLayoutProperties.minimumItemsSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: itemsHorizontalInset, bottom: 0.0, right: itemsHorizontalInset)
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
}

// MARK: - CollectionView DataSource
extension AdvertisementListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError()
    }
}

// MARK: - CollectionView Delegate
extension AdvertisementListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
