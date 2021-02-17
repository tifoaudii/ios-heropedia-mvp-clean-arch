//
//  Hero.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 15/02/21.
//

import Foundation

// MARK: - Hero
struct Hero: Codable {
    let id: Int
    let name, localizedName: String
    let primaryAttr: PrimaryAttr
    let attackType: AttackType
    let roles: [Role]
    let img, icon: String
    let baseHealth: Int
    let baseHealthRegen: Double?
    let baseMana: Int
    let baseManaRegen, baseArmor: Double
    let baseMr, baseAttackMin, baseAttackMax, baseStr: Int
    let baseAgi, baseInt: Int
    let strGain, agiGain, intGain: Double
    let attackRange, projectileSpeed: Int
    let attackRate: Double
    let moveSpeed: Int
    let turnRate: Double
    let cmEnabled: Bool
    let legs, heroID, turboPicks, turboWINS: Int
    let proBan, proWin, proPick, the1_Pick: Int
    let the1_Win, the2_Pick, the2_Win, the3_Pick: Int
    let the3_Win, the4_Pick, the4_Win, the5_Pick: Int
    let the5_Win, the6_Pick, the6_Win, the7_Pick: Int
    let the7_Win, the8_Pick, the8_Win, nullPick: Int
    let nullWin: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles, img, icon
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case moveSpeed = "move_speed"
        case turnRate = "turn_rate"
        case cmEnabled = "cm_enabled"
        case legs
        case heroID = "hero_id"
        case turboPicks = "turbo_picks"
        case turboWINS = "turbo_wins"
        case proBan = "pro_ban"
        case proWin = "pro_win"
        case proPick = "pro_pick"
        case the1_Pick = "1_pick"
        case the1_Win = "1_win"
        case the2_Pick = "2_pick"
        case the2_Win = "2_win"
        case the3_Pick = "3_pick"
        case the3_Win = "3_win"
        case the4_Pick = "4_pick"
        case the4_Win = "4_win"
        case the5_Pick = "5_pick"
        case the5_Win = "5_win"
        case the6_Pick = "6_pick"
        case the6_Win = "6_win"
        case the7_Pick = "7_pick"
        case the7_Win = "7_win"
        case the8_Pick = "8_pick"
        case the8_Win = "8_win"
        case nullPick = "null_pick"
        case nullWin = "null_win"
    }
}

enum AttackType: String, Codable {
    case melee = "Melee"
    case ranged = "Ranged"
}

enum PrimaryAttr: String, Codable {
    case agi = "agi"
    case int = "int"
    case str = "str"
}

enum Role: String, CaseIterable, Codable {
    case all = "All"
    case carry = "Carry"
    case disabler = "Disabler"
    case durable = "Durable"
    case escape = "Escape"
    case initiator = "Initiator"
    case jungler = "Jungler"
    case nuker = "Nuker"
    case pusher = "Pusher"
    case support = "Support"
}
