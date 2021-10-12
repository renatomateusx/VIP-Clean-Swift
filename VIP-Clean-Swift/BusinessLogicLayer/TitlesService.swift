//
//  TitlesService.swift
//  VIP-Clean-Swift
//
//  Created by Renato Mateus De Moura Santos on 12/10/21.
//

import Foundation

protocol TitlesService: AnyObject {
    func getTitles() throws -> [Title]
}

class TitlesServiceImplementation: TitlesService {
    var titles: [Title] = []
    func getTitles() throws -> [Title] {
        
//        titles.append(Title(id: 1, text: "TitleOne"))
//        titles.append(Title(id: 2, text: "TitleTwo"))
//        titles.append(Title(id: 3, text: "TitleThree"))
//        titles.append(Title(id: 4, text: "TitleFour"))
//        titles.append(Title(id: 5, text: "TitleFive"))
        
        return titles
    }
    
    func addTitle(text: String) throws -> Title {
        let index = titles.count - 1
        let title = Title(id: index, text: text)
        titles.append(title)
        
        return title
    }
    
    func deleteTitle(with id: Int) throws {
        if let index = self.titles.firstIndex(where: { $0.id == id }) {
            self.titles.remove(at: index)
        }
    }
}
