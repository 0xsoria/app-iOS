import SwiftUI

struct MenuView<Content: View>: View {
	@Binding var isShowing: Bool
	@ViewBuilder let menu: AnyView
	@ViewBuilder let content: Content
	@EnvironmentObject private var viewModel: MainViewModel

	var body: some View {
		VStack {
			HStack{
				if viewModel.isLoading {
					ProgressView()
				} else {
					Button {
						isShowing.toggle()
					} label: {
						Image("menu")
							.resizable()
                            .aspectRatio(contentMode: .fit)
							.frame(width: 40)
					}
				}
				menu
			}
			.padding([.leading, .bottom])

			content
		}
		.padding(.top, 10)
	}
}

struct SideMenu: View {
	@Binding var isShowing: Bool
	let transition: AnyTransition = .move(edge: .leading)
	let content: AnyView

	var body: some View {
		ZStack {
			if isShowing {
				Color.black.opacity(0.4)
					.ignoresSafeArea()
					.onTapGesture { isShowing.toggle() }

				content
					.transition(transition)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		.animation(.easeInOut, value: isShowing)
	}
}
