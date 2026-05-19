//
//  SearchView.swift
//  cisum
//
//  Created by Aarav Gupta on 30/05/24.
//

import SwiftUI

struct SearchView: View {
    let AccentColor = Color(red: 0.9764705882352941, green: 0.17647058823529413, blue: 0.2823529411764706)
    
    @State private var searchFilter: [SearchFilterModel] = SearchFilterModel.SearchFilter.allCases.map { SearchFilterModel(id: $0) }
    @State private var activeFilter: SearchFilterModel.SearchFilter = .songs
    @State private var tabBarScrollState: SearchFilterModel.SearchFilter?
    @State private var viewScrollState: SearchFilterModel.SearchFilter?
    @State private var progress: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    let inputRange = searchFilter.indices.compactMap { return CGFloat($0) }
                    let outputRange = searchFilter.compactMap { return $0.size.width + 30 } // Add 30 for padding
                    let outputPositionRange = searchFilter.compactMap { return $0.minX - 15 } // Adjust position by -15 to center it
                    let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: outputRange)
                    let indicatorPosition = progress.interpolate(inputRange: inputRange, outputRange: outputPositionRange)
                    
                    RoundedRectangle(cornerRadius: 50)
                        .fill(AccentColor.opacity(0.8))
                        .frame(width: indicatorWidth, height: 31.5)
                        .offset(x: indicatorPosition)
                    
                    FilterTabBar()
                }
                Divider()
                
                GeometryReader { geometry in
                    let size = geometry.size
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(searchFilter) { filter in
                                content(for: filter.id)
                                    .frame(width: size.width, height: size.height)
                                    .contentShape(Rectangle())
                            }
                        }
                        .scrollTargetLayout()
                        .rect { rect in
                            progress = -rect.minX / size.width
                        }
                    }
                    .scrollDisabled(true)
                    .scrollPosition(id: $viewScrollState)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                    .onChange(of: viewScrollState) { oldValue, newValue in
                        if let newValue {
                            withAnimation(.snappy) {
                                tabBarScrollState = newValue
                                activeFilter = newValue
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
    
    @ViewBuilder
    func FilterTabBar() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach($searchFilter) { $filter in
                    Button(action: {
                        withAnimation(.snappy) {
                            activeFilter = filter.id
                            tabBarScrollState = filter.id
                            viewScrollState = filter.id
                        }
                    }) {
                        Text(filter.id.rawValue)
                            .padding(.vertical, 12)
                            .foregroundColor(activeFilter == filter.id ? .primary : .gray)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .rect { rect in
                        filter.size = rect.size
                        filter.minX = rect.minX
                    }
                }
            }
            .safeAreaPadding(.horizontal, 30)
        }
        .scrollPosition(id: .init(get: {
            return tabBarScrollState
        }, set: { _ in
            
        }), anchor: .center)
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func content(for filter: SearchFilterModel.SearchFilter) -> some View {
        switch filter {
        case .songs:
            SongSearch()
        case .albums:
            AlbumSearch()
        case .artists:
            ArtistSearch()
        case .playlists:
            PlaylistSearch()
        case .users:
            UserSearch()
        }
    }
}

#Preview {
    SearchView()
}
