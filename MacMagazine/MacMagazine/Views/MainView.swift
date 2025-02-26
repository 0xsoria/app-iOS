import CommonLibrary
import News
import Settings
import SwiftUI
import Videos
import UIComponentsLibrarySpecial
import YouTubeLibrary

struct MainView: View {
	@Environment(\.theme) private var theme: ThemeColor
	@EnvironmentObject private var viewModel: MainViewModel
	@EnvironmentObject private var videosViewModel: VideosViewModel

	@State var isPresentingMenu = false
	@State var selection = MainViewModel.Page.home
    @State var path = NavigationPath()

	init() {}

	var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                theme.main.background.color
                    .edgesIgnoringSafeArea(.all)
                
                TabView(selection: $selection) {
                    MenuView(isShowing: $isPresentingMenu,
                             menu: { AnyView(SectionsView()) },
                             content: { HomeView() })
                    .tag(MainViewModel.Page.home)
                    
                    FavouritesView()
                        .environment(\.managedObjectContext, viewModel.newsViewModel.mainContext)
                        .tag(MainViewModel.Page.favourites)

                    NewsView(filter: .highlights, fit: .infinity, style: .fullscreen)
                        .environment(\.managedObjectContext, viewModel.newsViewModel.mainContext)
                        .tag(MainViewModel.Page.highlights)
                    
                    NewsView(filter: .news, fit: .infinity, style: .fullscreen)
                        .environment(\.managedObjectContext, viewModel.newsViewModel.mainContext)
                        .tag(MainViewModel.Page.news)
                    
                    VideosFullView()
                        .tag(MainViewModel.Page.videos)
                    
                    NewsView(filter: .appletv, fit: .infinity, style: .fullscreen)
                        .environment(\.managedObjectContext, viewModel.newsViewModel.mainContext)
                        .tag(MainViewModel.Page.appletv)
                    
                    NewsView(filter: .reviews, fit: .infinity, style: .fullscreen)
                        .environment(\.managedObjectContext, viewModel.newsViewModel.mainContext)
                        .tag(MainViewModel.Page.reviews)
                    
                    NewsView(filter: .tutoriais, fit: .infinity, style: .fullscreen)
                        .environment(\.managedObjectContext, viewModel.newsViewModel.mainContext)
                        .tag(MainViewModel.Page.tutoriais)
                    
                    NewsView(filter: .rumors, fit: .infinity, style: .fullscreen)
                        .environment(\.managedObjectContext, viewModel.newsViewModel.mainContext)
                        .tag(MainViewModel.Page.rumors)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                .onReceive(viewModel.$selectedTab) { value in
                    selection = value
                    isPresentingMenu = false
                }
                
                SideMenu(isShowing: $isPresentingMenu,
                         content: AnyView(SideMenuView(selectedView: $viewModel.selectedTab,
                                                       isPresentingMenu: $isPresentingMenu)))
            }
        }
    }
}

#Preview {
    let viewModel = MainViewModel()
    return MainView()
        .environmentObject(viewModel)
        .environmentObject(VideosViewModel())
        .environmentObject(NewsViewModel(inMemory: true))
        .environmentObject(viewModel.settingsViewModel)
        .environment(\.theme, ThemeColor())
        .task {
            viewModel.isLoading = false
        }
}
