//
//  CustomCorner.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/27.
//

import SwiftUI

struct CustomCorner: Shape {
    
    let corner: UIRectCorner
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: .init(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
    
}
