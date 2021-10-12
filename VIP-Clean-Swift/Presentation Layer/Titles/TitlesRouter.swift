//
//  TitlesRouter.swift
//  VIP-Clean-Swift
//
//  Created by Renato Mateus De Moura Santos on 12/10/21.
//

import UIKit

protocol TitlesRouter: AnyObject {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail(with id: Int)
}

class TitlesRouterImplementation: TitlesRouter {
    weak var navigationController: UINavigationController?
    
    func routeToDetail(with id: Int) {
//        let viewController = TitleDetailViewController()
//        TitleDetailConfigurator.configureModule(titleId: id,
//                                                viewController: viewController)
//        navigationController?.pushViewController(viewController, animated: true)
        print("Detail ViewController called here")
    }
}
