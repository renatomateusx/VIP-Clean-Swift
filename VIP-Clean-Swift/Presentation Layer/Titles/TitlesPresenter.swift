//
//  TitlesPresenter.swift
//  VIP-Clean-Swift
//
//  Created by Renato Mateus De Moura Santos on 12/10/21.
//

import Foundation


protocol TitlesPresenter: AnyObject {
    func interactor(didRetrieveTitles titles: [Title])
    func interactor(didFailtRetrieveTitles error: Error)
    
    func interactor(didAddTitle title: Title)
    func interactor(didFailAddTitle error: Error)
    
    func interactor(didDeleteTitleAtIndex index: Int)
    func interactor(didFailDeleteTitleAtIndex index: Int)
    
    func interactor(didFindTitle title: Title)
    func interactor(didFailObtainItemId message: Error)
}

class TitlesPresenterImplementation: TitlesPresenter {
    
    weak var viewController: TitlesPresenterOutput?
    
    func interactor(didRetrieveTitles titles: [Title]) {
        let titlesStrings = titles.compactMap { $0.text }
        viewController?.presenter(didRetrieveItems: titlesStrings)
    }
    
    func interactor(didFailtRetrieveTitles error: Error) {
        viewController?.presenter(didFailRetrieveItems: error.localizedDescription)
    }
    
    func interactor(didAddTitle title: Title) {
        viewController?.presenter(didAddItem: title.text)
    }
    
    func interactor(didFailAddTitle error: Error) {
        viewController?.presenter(didFailtAddItem: error.localizedDescription)
    }
    
    func interactor(didDeleteTitleAtIndex index: Int) {
        viewController?.presenter(didDeleteItemAt: index)
    }
    
    func interactor(didFailDeleteTitleAtIndex index: Int) {
        viewController?.presenter(didFailDeleteItemAtIndex: index,
                                  message: "Cound't delete item")
    }
    
    func interactor(didFindTitle title: Title) {
        viewController?.presenter(didObtainItemId: title.id)
    }
    
    func interactor(didFailObtainItemId error: Error) {
        viewController?.presenter(didFailObtainItemId: error.localizedDescription)
    }
}
