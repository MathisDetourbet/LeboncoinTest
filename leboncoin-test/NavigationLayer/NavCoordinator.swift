//
//  NavCoordinator.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import UIKit

protocol NavCoordinator {
    var navigationController: UINavigationController { get }
    func start()
}
