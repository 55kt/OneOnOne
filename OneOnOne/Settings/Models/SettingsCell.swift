//
//  SettingsCell.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import Foundation
import SwiftUI

struct SettingsCell {
    let imageName: String
    let backgroundColor: Color
    let title: String
}

extension SettingsCell {
    static let avatar = SettingsCell(
        imageName: "photo",
        backgroundColor: .blue,
        title: "Change Profile Photo"
    )
    
    static let broadCastLists = SettingsCell(
        imageName: "megaphone.fill",
        backgroundColor: .green,
        title: "Broadcast Lists"
    )
    
    static let starredMessages = SettingsCell(
        imageName: "star.fill",
        backgroundColor: .yellow,
        title: "Starred Messages"
    )
    
    static let linkedDevices = SettingsCell(
        imageName: "laptopcomputer",
        backgroundColor: .green,
        title: "Linked Devices"
    )
    
    static let account = SettingsCell(
        imageName: "key.fill",
        backgroundColor: .blue,
        title: "Account"
    )
    
    static let privacy = SettingsCell(
        imageName: "lock.fill",
        backgroundColor: .cyan,
        title: "Privacy"
    )
    
    static let chats = SettingsCell(
        imageName: "message",
        backgroundColor: .orange,
        title: "Chats"
    )
    
    static let notifications = SettingsCell(
        imageName: "bell.badge.fill",
        backgroundColor: .red,
        title: "Notifications"
    )
    
    static let storage = SettingsCell(
        imageName: "arrow.up.arrow.down",
        backgroundColor: .green,
        title: "Storage and Data"
    )
    
    static let help = SettingsCell(
        imageName: "info",
        backgroundColor: .blue,
        title: "Help"
    )
    
    static let tellFriend = SettingsCell(
        imageName: "heart.fill",
        backgroundColor: .red,
        title: "Tell a Friend"
    )
}

// MARK: Contact Info Data
extension SettingsCell {
    static let media = SettingsCell(
        imageName: "photo",
        backgroundColor: .blue,
        title: "Media, Links and Docs"
    )
    
    static let mute = SettingsCell(
        imageName: "speaker.wave.2.fill",
        backgroundColor: .green,
        title: "Mute"
    )
    
    static let wallpaper = SettingsCell(
        imageName: "circles.hexagongrid",
        backgroundColor: .mint,
        title: "Wallpaper & Sound"
    )
    
    static let saveToCameraRoll = SettingsCell(
        imageName: "square.and.arrow.down",
        backgroundColor: .yellow,
        title: "Save to Camera Roll"
    )
    
    static let encryption = SettingsCell(
        imageName: "lock.fill",
        backgroundColor: .blue,
        title: "Encryption"
    )
    
    static let disappearingMessages = SettingsCell(
        imageName: "timer",
        backgroundColor: .blue,
        title: "Disappearing Messages"
    )
    
    static let lockChat = SettingsCell(
        imageName: "lock.doc.fill",
        backgroundColor: .blue,
        title: "Lock Chat"
    )
    
    static let contactDetails = SettingsCell(
        imageName: "person.circle",
        backgroundColor: .gray,
        title: "Contact Details"
    )
}
