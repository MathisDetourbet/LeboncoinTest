//
//  AdvertisementListViewController.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 14/10/20.
//

import UIKit

protocol AdvertisementListRoutingDelegate: class {
    func userDidSelectAdvertisement(advertisementViewModel: AdvertisementViewModel)
}

final class AdvertisementListViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let viewModel: AdvertisementListViewModel
    private weak var routingDelegate: AdvertisementListRoutingDelegate?
    
    init(viewModel: AdvertisementListViewModel, routingDelegate: AdvertisementListRoutingDelegate?) {
        self.viewModel = viewModel
        self.routingDelegate = routingDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fillCollectionView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        collectionView = makeCollectionView()
    }
    
    private func fillCollectionView() {
        viewModel.fetchAdvertisementsList { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.presentErrorAlert(with: error)
                } else {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private func presentErrorAlert(with error: BusinessError) {
        let dismissAction = UIAlertAction(title: "Got it!", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        let alert = UIAlertController.makeBusinessErrorAlert(error, dismissAction: dismissAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Collection View Setup
private extension AdvertisementListViewController {
    
    enum CollectionViewLayoutProperties {
        static let numberOfItemByRow:           Int = 2
        static let cellAspectRatio:             CGFloat = 3/2
        static let minimumItemsSpacing:         CGFloat = 5.0
        static let minimumLineSpacing:          CGFloat = 5.0
        static let collectionHorizontalInset:   CGFloat = 5.0
        static let collectionViewMargins:       CGFloat = 5.0
    }
    
    func makeCollectionView() -> UICollectionView {
        let collectionViewLayout = makeCollectionViewLayout(with: view.frame)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CollectionViewLayoutProperties.collectionViewMargins),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CollectionViewLayoutProperties.collectionViewMargins),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CollectionViewLayoutProperties.collectionViewMargins),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -CollectionViewLayoutProperties.collectionViewMargins)
        ])
        
        collectionView.register(
            AdvertisementCollectionViewCell.self,
            forCellWithReuseIdentifier: AdvertisementCollectionViewCell.defaultReuseIdentifier
        )
        
        return collectionView
    }
    
    func makeCollectionViewLayout(with frame: CGRect) -> UICollectionViewFlowLayout {
        let itemsHorizontalInset = CollectionViewLayoutProperties.minimumItemsSpacing
        let collectionViewWidth = frame.width - 3 * CollectionViewLayoutProperties.collectionViewMargins
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = sizeForItem(collectionViewWidth: collectionViewWidth)
        flowLayout.minimumInteritemSpacing = CollectionViewLayoutProperties.minimumItemsSpacing
        flowLayout.minimumLineSpacing = CollectionViewLayoutProperties.minimumLineSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: itemsHorizontalInset, bottom: 0.0, right: itemsHorizontalInset)
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
    
    func sizeForItem(collectionViewWidth: CGFloat) -> CGSize {
        let numberOfItemByRow = CGFloat(CollectionViewLayoutProperties.numberOfItemByRow)
        let itemWidth = collectionViewWidth / numberOfItemByRow - CollectionViewLayoutProperties.collectionHorizontalInset
        let itemHeight = itemWidth * CollectionViewLayoutProperties.cellAspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

// MARK: - CollectionView DataSource
extension AdvertisementListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AdvertisementCollectionViewCell.defaultReuseIdentifier, for: indexPath) as? AdvertisementCollectionViewCell else {
            fatalError("Error cell dequeue")
        }
        
        let uiModel = viewModel.elementAt(indexPath)
        cell.fill(with: uiModel)
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension AdvertisementListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModelSelected = viewModel.elementAt(indexPath)
        routingDelegate?.userDidSelectAdvertisement(advertisementViewModel: viewModelSelected)
    }
}
