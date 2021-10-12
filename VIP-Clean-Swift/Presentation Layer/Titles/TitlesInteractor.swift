//
//  TitlesInteractor.swift
//  VIP-Clean-Swift
//
//  Created by Renato Mateus De Moura Santos on 12/10/21.
//

import Foundation

protocol TitlesInteractor: AnyObject {
    func viewDidLoad()
    func addTapped(with text: String)
    
    func didCommitDelete(for index: Int)
    
    func didSelectRow(at index: Int)
}

class TitlesInteractorImplementation: TitlesInteractor {
    var presenter: TitlesPresenter?
    
    private let titlesService: TitlesServiceImplementation()
    private var titles: [Title] = []
    
    func viewDidLoad() {
        do {
            self.titles = try titlesService.getTitles()
            
            presenter?.interactor(didRetrieveTitles: self.titles)
        } catch {
            presenter?.interactor(didFailRetrieveTitles: error)
        }
    }
    
    func didCommitDelete(for index: Int) {
        do {
            try titlesService.deleteTitle(with: self.titles[index].id!)
            self.titles.remove(at: index)
            presenter?.interactor(didDeleteTitleAtIndex: index)
        } catch {
            presenter?.interactor(didFindTitle: self.titles[index])
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.titles.indices.contains(index) {
            presenter?.interactor(didFindTitle: self.titles[index])
        }
    }
}
