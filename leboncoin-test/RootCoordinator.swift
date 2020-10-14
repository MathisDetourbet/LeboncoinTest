//
//  RootCoordinator.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 14/10/20.
//

import UIKit

final class RootCoordinator {
    private let navigationController: UINavigationController
    
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
        
    }
}
