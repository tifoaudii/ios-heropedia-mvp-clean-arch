//
//  AppDIContainer.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

import Foundation

final class AppDIContainer {
    
    // MARK:- Create Scene DI Container
    func createHeroSceneDIContainer() -> HeroSceneDIContainer {
        return HeroSceneDIContainer()
    }
}
