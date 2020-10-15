//
//  AdvertisementCollectionViewCell.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import UIKit

// MARK: - UI Model to configure AdvertisementCollectionViewCell
protocol AdvertisementCellUIModel {
    var title: String { get }
    var price: String { get }
    var adPictureUrl: URL? { get }
    var adDefaultPictureImageName: String { get }
    var categoryPictureImageName: String { get }
    var isUrgentPictureImageName: String? { get }
}

// MARK: -  AdvertisementCollectionViewCell definition
final class AdvertisementCollectionViewCell: UICollectionViewCell {
    
    // MARK: Container Outlets
    private var topContainerView: UIView!
    private var bottomContainerView: UIView!
    
    // MARK: UI Elements Outlets
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    private var adPictureImageView: UIImageView!
    private var categoryPictureImageView: UIImageView!
    private var isUrgentPictureImageView: UIImageView!
    
    // MARK: Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: Manage images
    }
    
    // MARK: View setup
    private func setupView() {
        setupTopContainer()
        setupBottomContainer()
    }
    
    // MARK: Top container setup
    private func setupTopContainer() {
        topContainerView = UIView()
        topContainerView.backgroundColor = .clear
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topContainerView)
        NSLayoutConstraint.activate(
            [
                topContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                topContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                topContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
        
        setupAdPictureImageView()
        setupIsUrgentPictureImageView()
    }
    
    private func setupAdPictureImageView() {
        adPictureImageView = UIImageView(frame: topContainerView.frame)
        adPictureImageView.contentMode = .scaleAspectFill
        adPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.addSubview(adPictureImageView)
        NSLayoutConstraint.activate(
            [
                adPictureImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
                adPictureImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
                adPictureImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
                adPictureImageView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor)
            ]
        )
    }
    
    private func setupIsUrgentPictureImageView() {
        isUrgentPictureImageView = UIImageView()
        isUrgentPictureImageView.contentMode = .scaleAspectFit
        isUrgentPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.addSubview(isUrgentPictureImageView)
        NSLayoutConstraint.activate(
            [
                isUrgentPictureImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
                isUrgentPictureImageView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
                isUrgentPictureImageView.heightAnchor.constraint(equalTo: isUrgentPictureImageView.widthAnchor, multiplier: 2.0)
            ]
        )
    }
    
    // MARK: Bottom container setup
    private func setupBottomContainer() {
        bottomContainerView = UIView()
        bottomContainerView.backgroundColor = .clear
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomContainerView)
        NSLayoutConstraint.activate(
            [
                bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
                bottomContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bottomContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    private func setupBottomElements() {
        let bottomStackView = UIStackView()
        bottomStackView.axis = .vertical
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.addSubview(bottomStackView)
        NSLayoutConstraint.activate(
            [
                bottomStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
                bottomStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
                bottomStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
                bottomStackView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor)
            ]
        )
        
        let firstLineStackView = UIStackView()
        firstLineStackView.axis = .horizontal
        firstLineStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(firstLineStackView)
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLineStackView.addArrangedSubview(titleLabel)
        
        categoryPictureImageView = UIImageView()
        categoryPictureImageView.contentMode = .scaleAspectFit
        categoryPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        firstLineStackView.addArrangedSubview(categoryPictureImageView)
        
        priceLabel = UILabel()
        priceLabel.numberOfLines = 1
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(priceLabel)
    }
}

// MARK: - Elements configuration with UI Model
extension AdvertisementCollectionViewCell {
    func fill(with uiModel: AdvertisementCellUIModel) {
        fillTitleLabel(with: uiModel.title)
        fillPriceLabel(with: uiModel.price)
        fillCategoryPictureImageView(with: uiModel.categoryPictureImageName)
        fillAdPictureImageView(with: uiModel.adPictureUrl, or: uiModel.adDefaultPictureImageName)
        fillIsUrgentPicture(with: uiModel.isUrgentPictureImageName)
    }
}

// MARK: - Configure each cell elements
private extension AdvertisementCollectionViewCell {
    func fillTitleLabel(with title: String) {
        titleLabel.text = title
    }
    
    func fillAdPictureImageView(with url: URL?, or defaultImageName: String) {
        if let _ = url {
            // TODO: Use image downloader
        } else {
            adPictureImageView.image = UIImage(named: defaultImageName)
        }
    }
    
    func fillPriceLabel(with price: String) {
        priceLabel.text = price
    }
    
    func fillCategoryPictureImageView(with imageName: String) {
        categoryPictureImageView.image = UIImage(named: imageName)
    }
    
    func fillIsUrgentPicture(with isUrgentImageName: String?) {
        if let imageName = isUrgentImageName {
            isUrgentPictureImageView.image = UIImage(named: imageName)
        }
    }
}
