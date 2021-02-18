//
//  NetworkCacheRepositoryMock.swift
//  HeropediaTests
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

@testable import Heropedia
import Foundation

class NetworkCacheRepositoryMock: NetworkCacheRepository {
    
    let mockHeroResponse = [
        Hero(id: 1, name: "Anti_Mage", localizedName: "Anti Mage ", primaryAttr: .agi, attackType: .melee, roles: [.carry, .disabler], img: "", icon: "", baseHealth: 300, baseHealthRegen: 300, baseMana: 300, baseManaRegen: 456, baseArmor: 123, baseMr: 323, baseAttackMin: 213, baseAttackMax: 424, baseStr: 433, baseAgi: 1221, baseInt: 43, strGain: 344, agiGain: 213, intGain: 343, attackRange: 35, projectileSpeed: 787, attackRate: 343, moveSpeed: 534, turnRate: 2437, cmEnabled: false, legs: 989, heroID: 4342, turboPicks: 78, turboWINS: 983, proBan: 983, proWin: 478, proPick: 23, the1_Pick: 4239, the1_Win: 892, the2_Pick: 3, the2_Win: 984, the3_Pick: 3829, the3_Win: 48, the4_Pick: 238, the4_Win: 489, the5_Pick: 89, the5_Win: 89, the6_Pick: 89, the6_Win: 89, the7_Pick: 89, the7_Win: 89, the8_Pick: 89, the8_Win: 89, nullPick: 89, nullWin: 89)
    ]
    
    
    func load(onSuccess: @escaping ([Hero]) -> Void, onFailure: @escaping (Error) -> Void) {
        onSuccess(mockHeroResponse)
    }
    
    func save(data: [Hero]) {}
}
