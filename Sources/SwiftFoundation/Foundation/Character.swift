//
//  Character.swift
//  SwiftFoundation
//
//  Created by Vlad Andrieiev on 16.07.2025.
//

public extension Character {
    /// Returns `true` if the character is an ASCII digit between "0" and "9".
    ///
    /// If you need to check for numeric values in any Unicode script (e.g., "١", "Ⅷ"), use `Character.isNumber` instead.
    var isNumeric: Bool { "0" ... "9" ~= self }
}
