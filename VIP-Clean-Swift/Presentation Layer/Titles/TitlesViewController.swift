//
//  TitlesViewController.swift
//  VIP-Clean-Swift
//
//  Created by Renato Mateus De Moura Santos on 12/10/21.
//

import UIKit

protocol TitlesPresenterOutput: AnyObject {
    func presenter(didRetrieveItems items: [String])
    func presenter(didFailRetrieveItems message: String)
    
    func presenter(didAddItem item: String)
    func presenter(didFailtAddItem message: String)
    
    func presenter(didDeleteItemAt index: Int)
    func presenter(didFailDeleteItemAtIndex index: Int, message: String)
    
    func presenter(didObtainItemId id: Int)
    func presenter(didFailObtainItemId message: String)
}

class TitlesViewController: UIViewController {
    
    // MARK: - Properties
    var titlesView: TitlesView?
    var interactor: TitlesInteractor?
    var router: TitlesRouter?
    
    private var items: [String] = []
    
    lazy var addBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addBarButtonItemTapped)
        )
        return item
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        self.view = titlesView
        
        titlesView?.tableView.delegate = self
        titlesView?.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Titles".uppercased()
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - Actions

extension TitlesViewController {
    @objc func addBarButtonItemTapped() {
        let alert = UIAlertController(
            title: "Add a new title",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addTextField { (textField) in
            textField.placeholder = "Text"
        }
        
        let okAction = UIAlertAction(
            title: "Add",
            style: .default
        ) { [weak self] (action) in
            self?.interactor?.addTapped(with: alert.textFields?.first?.text ?? "")
        }
        
        let cancelAction  = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension TitlesViewController: TitlesPresenterOutput {
    func presenter(didRetrieveItems items: [String]) {
        self.items = items
        self.titlesView?.reloadTableView()
    }
    
    func presenter(didFailRetrieveItems message: String) {
        showError(with: message)
    }
    
    func presenter(didAddItem item: String) {
        self.items.append(item)
        self.titlesView?.insertRowAt(at: self.items.count - 1)
    }
    
    func presenter(didFailtAddItem message: String) {
        showError(with: message)
    }
    
    func presenter(didDeleteItemAt index: Int) {
        self.items.remove(at: index)
        self.titlesView?.deleteRow(at: index)
    }
    
    func presenter(didFailDeleteItemAtIndex index: Int, message: String) {
        showError(with: message)
    }
    
    func presenter(didObtainItemId id: Int) {
        self.router?.routeToDetail(with: id)
    }
    
    func presenter(didFailObtainItemId message: String) {
        showError(with: message)
    }
}

// MARK: - UITableView DataSource & Delegate
extension TitlesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.items.isEmpty ?
            self.titlesView?.showPlaceholder() :
            self.titlesView?.hidePlaceholder()
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = self.items[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.interactor?.didCommitDelete(for: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectRow(at: indexPath.row)
    }
}
