//
//  ColorScheme.swift
//  TexDocs
//
//  Created by Noah Peeters on 12.11.17.
//  Copyright © 2017 TexDocs. All rights reserved.
//

import Cocoa

struct Theme: Decodable {
    let colors: Colors
    func color(forKey key: ColorKey) -> NSColor? {
        return colors[key]
    }

    init(colors: [ColorKey: NSColor]) {
        self.colors = Colors.init(colors: colors)
    }

    struct Colors: Decodable {
        private var colors: [ColorKey: NSColor]

        subscript(_ key: ColorKey) -> NSColor? {
            return colors[key]
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: ColorKey.self)

            colors = try Dictionary(uniqueKeysWithValues: container.allKeys.map { key in
                let components = try container.decode([CGFloat].self, forKey: key)
                return (key, NSColor(red: components[0], green: components[1], blue: components[2], alpha: components[3]))
            })
        }

        init(colors: [ColorKey: NSColor]) {
            self.colors = colors
        }
    }
}

let defaultColorScheme = Theme(colors: [
    .text: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
    .comment: #colorLiteral(red: 0, green: 0.456, blue: 0, alpha: 1),
    .keyword: #colorLiteral(red: 0.665, green: 0.052, blue: 0.569, alpha: 1),
    .variable: #colorLiteral(red: 0.11, green: 0, blue: 0.81, alpha: 1),
    .escapedCharacter: #colorLiteral(red: 0.77, green: 0.102, blue: 0.086, alpha: 1),
    .inlineMath: #colorLiteral(red: 0, green: 0.456, blue: 0, alpha: 1)
])


