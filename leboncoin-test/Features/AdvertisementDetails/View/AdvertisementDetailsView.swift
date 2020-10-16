//
//  AdvertisementDetailsView.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import UIKit

// MARK: -  AdvertisementDetailsView Definition
final class AdvertisementDetailsView: UIView {
    private var vStackView: UIStackView!
    
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
    
    // MARK: View setup
    private func setupView() {
        let vStackView = UIStackView()
        vStackView.backgroundColor = .clear
        vStackView.axis = .vertical
        vStackView.spacing = 5.0
        vStackView.alignment = .fill
        vStackView.distribution = .fillProportionally
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        self.vStackView = vStackView
    }
}

// MARK: - Elements configuration with UI Model
extension AdvertisementDetailsView {
    func fill(with uiModel: AdvertisementDetailsViewUIModel) {
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.idString))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.titleString))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.descriptionString))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.categoryIdString))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.priceString))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.creationDateString))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.isUrgentString))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.smallAdImageUrlString))
        vStackView.addArrangedSubview(makeDefaultImageView(with: uiModel.smallAdImageUrl))
        vStackView.addArrangedSubview(makeDefaultLabel(with: uiModel.largeAdImageUrlString))
        vStackView.addArrangedSubview(makeDefaultImageView(with: uiModel.largeAdImageUrl))
    }
    
    private func makeDefaultLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .systemGray
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeDefaultImageView(with url: URL?) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.downloadImageFromURL(url)
        
        if url == nil {
            imageView.isHidden = true
        }
        
        return imageView
    }
}
