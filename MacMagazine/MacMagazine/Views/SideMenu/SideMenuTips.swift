import CommonLibrary
import SwiftUI
import TipKit

enum SideMenuTips: TipType {
    case favourites
	case categories
	case subscriptions
	case posts
	case settings
	case about

    @available(iOS 17, *)
    private static var favouritesTip: FavouritesTip { FavouritesTip() }

    @available(iOS 17, *)
	private static var categoriesTip: CategoriesTip { CategoriesTip() }

	@available(iOS 17, *)
	private static var subscriptionsTip: SubscriptionsTip { SubscriptionsTip() }

	@available(iOS 17, *)
	private static var postsTip: PostsTip { PostsTip() }

	@available(iOS 17, *)
	private static var settingsTip: OptionsTip { OptionsTip() }

	@available(iOS 17, *)
	private static var aboutTip: AboutTip { AboutTip() }
}

extension SideMenuTips {
	@ViewBuilder
	func tipView(with theme: ThemeColor) -> some View {
		if #available(iOS 17, *) {
			Group {
				switch self {
                case .favourites:
                    TipView(Self.favouritesTip, arrowEdge: .bottom)

                case .categories:
					TipView(Self.categoriesTip, arrowEdge: .bottom)

				case .subscriptions:
					TipView(Self.subscriptionsTip, arrowEdge: .bottom)

				case .posts:
					TipView(Self.postsTip, arrowEdge: .bottom)

				case .settings:
					TipView(Self.settingsTip, arrowEdge: .bottom)

				case .about:
					TipView(Self.aboutTip, arrowEdge: .bottom)
				}
			}
			.style(theme: theme)
		}
	}

	func invalidate() {
		if #available(iOS 17, *) {
			switch self {
            case .favourites: Self.favouritesTip.invalidate(reason: .actionPerformed)
			case .categories: Self.categoriesTip.invalidate(reason: .actionPerformed)
			case .subscriptions: Self.subscriptionsTip.invalidate(reason: .actionPerformed)
			case .posts: Self.postsTip.invalidate(reason: .actionPerformed)
			case .settings: Self.settingsTip.invalidate(reason: .actionPerformed)
			case .about: Self.aboutTip.invalidate(reason: .actionPerformed)
			}
		}
	}

	func show() {
		if #available(iOS 17, *) {
			switch self {
            case .favourites: FavouritesTip.isActive = true
			case .categories: CategoriesTip.isActive = true
			case .subscriptions: SubscriptionsTip.isActive = true
			case .posts: PostsTip.isActive = true
			case .settings: OptionsTip.isActive = true
			case .about: AboutTip.isActive = true
			}
		}
	}
}
