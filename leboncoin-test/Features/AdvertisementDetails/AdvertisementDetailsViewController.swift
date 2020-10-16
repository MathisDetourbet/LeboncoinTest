//
//  AdvertisementDetailsViewController.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import UIKit

final class AdvertisementDetailsViewController: UIViewController {
    
    private let adDetailsUIModel: AdvertisementDetailsViewUIModel
        
    init(with uiModel: AdvertisementDetailsViewUIModel) {
        self.adDetailsUIModel = uiModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let adDetailsView = AdvertisementDetailsView()
        adDetailsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(adDetailsView)
        
        NSLayoutConstraint.activate([
            adDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            adDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            adDetailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            adDetailsView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        adDetailsView.fill(with: adDetailsUIModel)
    }
}
