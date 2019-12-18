//
//  StringExtension.swift
//  Torq
//
//  Created by Jean Paul Marinho on 21/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
