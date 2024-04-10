//
//  UIView+Extensions.swift
//  iOS12-HW21-Alexey-Cherebayev
//
//  Created by Alex on 10.04.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ addSubview($0) })
    }
}
