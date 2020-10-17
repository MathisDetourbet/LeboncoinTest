//
//  CategoryPickerViewController.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 17/10/20.
//

import UIKit

protocol CategoryPickerDelegate: class {
    func didSelectCategory(_ category: CategoryEntity)
}

final class CategoryPickerViewController: UIViewController {
    
    private var tableView: UITableView!
    private let viewModel: CategoryPickerViewModel
    private weak var delegate: CategoryPickerDelegate?
    
    static func prompt(
        on viewController: UIViewController,
        delegate: CategoryPickerDelegate
    ) {
        let vc = CategoryPickerViewController()
        vc.delegate = delegate
        viewController.present(vc, animated: true, completion: nil)
    }
    
    private init() {
        self.viewModel = CategoryPickerViewModel()
        
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
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
}

extension CategoryPickerViewController: UITableViewDataSource {
    
    private static let tableViewHeaderTitle = "Select a category:"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CategoryPickerViewController.tableViewHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = viewModel.elementAt(indexPath)
        
        // No need to reuse cell here, too few of categories
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = category.description
        cell.imageView?.image = UIImage(named: category.imageName)
        return cell
    }
}

extension CategoryPickerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let categorySelected = viewModel.elementAt(indexPath)
        
        dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectCategory(categorySelected)
        }
    }
}
