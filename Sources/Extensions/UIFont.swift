//
//  File.swift
//
//
//  Created by Furkan Kaplan on 21.06.2023.
//

import UIKit

extension UIFont {
    class var header: UIFont {
        UIFont.boldSystemFont(ofSize: 18)
    }

    class var body: UIFont {
        UIFont.systemFont(ofSize: 14)
    }

    class var caption: UIFont {
        UIFont.boldSystemFont(ofSize: 14)
    }

    class var small: UIFont {
        UIFont.systemFont(ofSize: 12)
    }
}
