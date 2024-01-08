import CommonLibrary
import CoreData
import CoreLibrary
import SwiftUI
import UIComponentsLibrary
import YouTubeLibrary

public struct VideosView: View {
	@Environment(\.theme) private var theme: ThemeColor
	@EnvironmentObject private var viewModel: VideosViewModel

	@State var action: YouTubePlayerAction = .idle

	private var width: CGFloat

	public init(availableWidth: CGFloat) {
		self.width = min(360, availableWidth * 0.82)
	}

	public var body: some View {
		VStack {
			HeaderView(title: "Vídeos", theme: theme) {
				withAnimation {
					viewModel.options = .all
				}
			}

			ErrorView(message: viewModel.status.reason, theme: theme)
				.padding(.top)

			HomeVideosView(api: viewModel.youtube, theme: theme, width: width)
				.padding(.bottom)
				.background(YouTubePlayerView(api: viewModel.youtube,
											  action: $action).opacity(0))

			Spacer()
		}
		.padding(.horizontal)
		.environment(\.managedObjectContext, viewModel.context)

		.task {
			try? await viewModel.youtube.getVideos()
		}

		.onReceive(viewModel.youtube.$selectedVideo) { value in
			guard let videoId = value?.videoId else {
				action = .idle
				return
			}

			action = .cue(videoId, value?.current ?? 0)
		}

		.onChange(of: action) { action in
			switch action {
			case .paused(let videoId, let current):
				viewModel.youtube.update(videoId: videoId, current: current)
				viewModel.youtube.selectedVideo = nil
				self.action = .idle
			default: break
			}
		}
	}
}

struct VideosView_Previews: PreviewProvider {
	static var previews: some View {
		VideosView(availableWidth: 360)
			.environmentObject(VideosViewModel())
			.environment(\.theme, ThemeColor())
	}
}
