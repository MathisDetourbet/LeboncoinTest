//
//  AdvertisementDetailsViewController.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import UIKit

final class AdvertisementDetailsViewController: UIViewController {
    private var scrollView: UIScrollView!
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
        setupView()
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        self.scrollView = scrollView
        
        let adDetailsView = AdvertisementDetailsView()
        adDetailsView.fill(with: adDetailsUIModel)
        adDetailsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(adDetailsView)
        
        let margin = 8.0 as CGFloat
        
        NSLayoutConstraint.activate([
            adDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            adDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            adDetailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: margin),
            adDetailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            adDetailsView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
