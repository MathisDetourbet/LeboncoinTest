//
//  RootCoordinator.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 14/10/20.
//

import UIKit

final class RootCoordinator: NavCoordinator {
    // MARK: Controller in charge of Navigation
    let navigationController: UINavigationController
    
    // MARK: Dependency property to inject
    private let httpService: HTTPService
    private let httpConfiguration: HTTPConfiguration
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.httpConfiguration = HTTPConfiguration()
        self.httpService = HTTPService()
    }
    
    func start() {
        let dataAccess = HTTPAdvsertisementsListDataAccessor(httpService: httpService, httpConfiguration: httpConfiguration)
        let businessService = AdvertisementListBusinessService(dataAccessor: dataAccess)
        let viewModel = AdvertisementListViewModel(businessService: businessService)
        let viewController = AdvertisementListViewController(viewModel: viewModel, routingDelegate: self)
        
        navigationController.setViewControllers([viewController], animated: true)
    }
}

// MARK: - Handle user outputs from AdvertisementsList screen
extension RootCoordinator: AdvertisementListRoutingDelegate {
    
    func userDidSelectAdvertisement(advertisementViewModel: AdvertisementViewModel) {
        let adDetailViewController = AdvertisementDetailsViewController(with: advertisementViewModel)
        navigationController.pushViewController(adDetailViewController, animated: true)
    }
}
