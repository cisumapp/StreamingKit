//
//  Songs Search.swift
//  cisum
//
//  Created by Aarav Gupta on 09/03/24.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct SongSearch: View {
    let AccentColor = Color(red : 0.9764705882352941, green: 0.17647058823529413, blue: 0.2823529411764706)
    @State private var animateContent: Bool = false
    @State var expandPlayer: Bool = false
    @Namespace var animation
    @State private var editingKeyword: String = ""
    @State private var searchResults: JioSaavnSongResponse?
    @State private var isLoading: Bool = false
    @State private var error: Error?
    var body: some View {
        VStack {
            
            self.inputBox
                .padding()
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: nil) {
                    
                    if isLoading {
                        ProgressView()
                    } else if let error {
                        Text(error.localizedDescription)
                    } else if let results = searchResults?.data.results {
                        
                        ForEach(results.indices, id: \.self) { index in
                            let result = results[index]
                            self.buildResultItemContainer(result)
                        }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    private var inputBox: some View {
        TextField("Search Songs",
                  text: $editingKeyword,
                  prompt: nil)
        .textFieldStyle(.roundedBorder)
        .onSubmit {
            self.runSearch()
        }
    }
    
    private func buildResultItemContainer(_ item: JioSaavnSongResponse.JioSaavnSongData.JioSaavnSongResult) -> some View {
        let imageUrl = item.image.first?.url == nil ? nil : URL(string: item.image.first!.url)
        let artists = item.artists.all.map { $0.name }.joined(separator: "&")
        return HStack {
            AsyncImage(url: imageUrl)
                .frame(width: 55, height: 55)
            
            VStack(alignment: .leading,
                   spacing: 2.5) {
                Text(item.name)
                    .font(.system(size: 17))
                Text(artists)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
            
            Spacer(minLength: .zero)
        }
        .lineLimit(1)
    }
    
    func runSearch() {
        guard !editingKeyword.isEmpty else {
            return
        }
        self.isLoading = true
        let controller = APIController.shared
        controller.searchSongs(query: editingKeyword,
                              page: 1, limit: 10) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.error = nil
                    self.searchResults = results
                case .failure(let error):
                    self.error = error
                    self.searchResults = nil
                }
                self.isLoading = false
            }
        }
    }
}

//struct SearchView: View {
//  let AccentColor = Color(red : 0.9764705882352941, green: 0.17647058823529413, blue: 0.2823529411764706)
//  //Animation Properties
//  @State private var animateContent: Bool = false
//  @State var expandPlayer: Bool = false
//  @Namespace var animation
//  @EnvironmentObject var viewModel: PlayerViewModel
//  @StateObject private var searchViewModel = SearchViewModel()
//  @StateObject var mainViewModel = MainViewModel()
//
//  var body: some View {
//    if !isUserSearchEnabled {
//        NavigationView {
//          VStack {
//            Picker("Filter", selection: $searchViewModel.filter) {
//              ForEach(SearchFilter.allCases, id: \.self) { filter in
//                Text(filter.rawValue)
//              }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding(.horizontal)
//            .padding(.vertical, 5)
//            .clipped()
//
//            if searchViewModel.isLoading {
//              ProgressView()
//            } else if searchViewModel.videos.isEmpty && !searchViewModel.searchText.isEmpty {
//              Text("Please search for \"\(searchViewModel.searchText)\" again.")
//                .padding()
//            } else {
//              listContent
//            }
//          }
//          .safeAreaInset(edge: .bottom) {
//            FloatingPlayer()
//          }
//          .overlay {
//            if expandPlayer {
//                Player(animation: animation, expandPlayer: $expandPlayer, videoID: viewModel.videoID ?? mainViewModel.videoID)
//                .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
//            }
//          }
//          .toolbar(expandPlayer ? .hidden : .visible, for: .navigationBar)
//          .toolbar(expandPlayer ? .hidden : .visible, for: .tabBar)
//          .searchable(text: $searchViewModel.searchText, prompt: "Search \(searchViewModel.filter.rawValue)")
//          .navigationTitle("Search")
//          .navigationBarLargeTitleItems(visible: true, trailingItems: {
//              Toggle("User Search", isOn: $isUserSearchEnabled)
//                  .padding(.trailing)
//                  .toggleStyle(.switch)
//                  .tint(AccentColor)
//          })
//          .navigationBarTitleDisplayMode(.automatic)
//        }
//    } else {
//        UserSearch(isUserSearchEnabled: $isUserSearchEnabled)
//    }
//  }
//
//  //MARK: Floating Player
//  @ViewBuilder
//  func FloatingPlayer() -> some View {
//    //MARK: Player Expand Animation
//    ZStack {
//      if expandPlayer {
//        Rectangle()
//          .fill(.clear)
//      } else {
//        RoundedRectangle(cornerRadius: 12)
//          .fill(.thickMaterial)
//          .overlay {
//            //Music Info
//            MusicInfo(title: viewModel.title ?? "Not Playing", artistName: viewModel.artistName ?? "", thumbnailURL: viewModel.thumbnailURL ?? "musicnote", animation: animation, expandPlayer: $expandPlayer)
//          }
//          .matchedGeometryEffect(id: "Background", in: animation)
//      }
//    }
//    .offset(y: -10.5)
//    .frame(width: 370, height: 58)
//  }
//
//  private var loadingView: some View {
//    ProgressView("Loading...")
//      .progressViewStyle(.circular)
//      .padding()
//  }
//
//  private var emptyStateView: some View {
//    Text("Please search for \"\(searchViewModel.searchText)\" again.")
//      .padding()
//      .foregroundColor(.gray)
//  }
//
//  private var listContent: some View {
//    ScrollView {
//      LazyVGrid(columns: Array(repeating: GridItem(spacing: 6), count: 2), spacing: 6) {
//        ForEach(searchViewModel.videos) { video in
//          videoColumn(for: video)
//        }
//      }
//      .padding(.horizontal)
//    }
//  }
//
//  private func videoColumn(for video: JioSaavnSongResponse) -> some View {
//    VStack(alignment: .leading, spacing: 6) {
//      videoThumbnail(for: video)
//        .frame(width: 171.5, height: 171.5)
//
//      Text(video.title)
//        .font(.caption)
//        .foregroundColor(.primary)
//        .lineLimit(1)
//        .frame(maxWidth: .infinity, alignment: .center)
//    }
//    .onTapGesture {
//      updateCurrentVideo(to: video)
//      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//      expandPlayer = true
//    }
//    .frame(width: 171.5, height: 200, alignment: .leading)
//    .padding(.vertical, 4)
//  }
//
//  private func updateCurrentVideo(to video: VideoResponse) {
//    viewModel.videoID = video.id
//    viewModel.title = video.title
//    viewModel.duration = video.duration
//    viewModel.artistName = video.artistName
//    viewModel.thumbnailURL = video.thumbnailURL
//    viewModel.expandPlayer = true
//  }
//
//  private func videoThumbnail(for video: JioSaavnSongResponse) -> some View {
//    WebImage(url: URL(string: video.thumbnailURL)) { phase in
//      switch phase {
//      case .empty:
//        ProgressView()
//      case .success(let image):
//        image.resizable()
//          .interpolation(.high)
//          .aspectRatio(contentMode: .fill)
//          .frame(width: 171.5, height: 171.5)
//          .clipShape(RoundedRectangle(cornerRadius: 12))
//          .matchedGeometryEffect(id: video.id, in: animation)
//      case .failure:
//        Image(systemName: "musicnote")
//          .resizable()
//          .aspectRatio(contentMode: .fill)
//          .frame(width: 171.5, height: 171.5)
//          .clipShape(RoundedRectangle(cornerRadius: 12))
//      }
//    }
//  }
//}
