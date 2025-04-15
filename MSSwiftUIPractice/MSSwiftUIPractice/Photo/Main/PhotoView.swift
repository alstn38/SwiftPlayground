//
//  PhotoView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct PhotoView: View {
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(PhotoSectionItem.sections, id: \.id) { section in
                        PhotoSectionView(section: section)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .asLargeNavigationTitle("My Random Image")
        }
    }
}

#Preview {
    PhotoView()
}
