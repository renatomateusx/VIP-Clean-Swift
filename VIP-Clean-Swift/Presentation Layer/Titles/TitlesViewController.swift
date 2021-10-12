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
    
    func presenter(didObtainItemId id: String)
    func presenter(didFailObtainItemId message: String)
}

class TitlesViewController: UIViewController {
    
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
}
