//
//  StaggeredGrid.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/30.
//

import SwiftUI

struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {

    private var content: (T) -> Content
    private var list: [T]
    
    var columns: Int
    var showIndicaters: Bool
    var spacing: CGFloat
    
    init(columns: Int,
         showIndicaters: Bool = false,
         spacing: CGFloat = 0,
         list: [T], 
         @ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.columns = columns
        self.spacing = spacing
        self.showIndicaters = showIndicaters
        self.list = list
    }
    
    func setupColumnsList() -> [[T]] {
        
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        var currentIndex: Int = 0
        
        for object in self.list {
            gridArray[currentIndex].append(object)
            
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 20, content: {
            
            ForEach(setupColumnsList(), id: \.self) { columnsData in
                
                LazyVStack(spacing: self.spacing) {
                    
                    ForEach(columnsData) { object in
                        
                        // 使用もとの{ }の中に作成したViewを返す
                        content(object)
                    }
                }
                // 左と右のCardViewの列をずらすために、右のCardViewのpadding80を設定する
                .padding(.vertical, getIndex(values: columnsData) == 1 ? 80 : 0)
            }
        })
        .padding(.vertical)
    }
    
    func getIndex(values: [T]) -> Int {
        let index = setupColumnsList().firstIndex(where: { $0 == values} ) ?? 0
        return index
    }
}

//#Preview {
//    StaggeredGrid(
//}
