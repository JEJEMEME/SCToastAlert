// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct ToastAlert {
    private var toastAlert = SCToastAlertUIView()
    
    public mutating func show(title: String, subTitle: String? = nil, type: ConfigType = .black()) {
        toastAlert.show(title: title, subTitle: subTitle, type: type)
    }
}

@available(iOS 13.0, *)
struct SCToastAlertUIView: UIViewRepresentable {
    
    private var view = UIHostingController(rootView: SCToastView())
    
    internal func makeUIView(context: Context) -> some UIView {
        return view.view
    }

    internal func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    public mutating func show(title: String,
                              subTitle: String? = nil,
                              type: ConfigType = .black()) {
        
        self.view = UIHostingController(rootView: SCToastView(title: title, subTitle: subTitle, type: type))
        self.view.view.alpha = 0.0
        view.view.backgroundColor = .clear
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.addSubview(view.view)
        
        view.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.view.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            view.view.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            view.view.topAnchor.constraint(equalTo: window.topAnchor),
            view.view.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])
        
        view.view.isUserInteractionEnabled = false
        
        presentAnimate(dismiss: true)
        
    }
    
    private func presentAnimate(dismiss: Bool = true) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.view.alpha = 1.0
        })
        
        if dismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.hide()
            })
        }
    }
    
    public func hide() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.view.alpha = 0.0
        }, completion: { _ in
            view.view.removeFromSuperview()
        })
        
        
    }
}


@available(iOS 13.0, *)
public enum ConfigType {
    case white(fontWeight: Font.Weight = .medium, bottomPadding: CGFloat = 70)
    case black(fontWeight: Font.Weight = .medium, bottomPadding: CGFloat = 70)
}

@available(iOS 13.0, *)
internal struct SCToastView: View {
    
    internal let title: String
    internal let subTitle: String?
    internal let config: Config
    
    internal init(title: String = "", subTitle: String? = nil, type: ConfigType = .black()) {
        self.title = title
        self.subTitle = subTitle
        
        switch type {
        case .black(let fontWeight, let bottomPadding):
            self.config = Config.init(titleColor: Color.white,
                                      titleFont: .system(size: 15, weight: fontWeight),
                                      backgroundColor: Color.black.opacity(0.8),
                                      bottomPadding: bottomPadding)
        case .white(let fontWeight, let bottomPadding):
            self.config = Config.init(titleColor: Color.black,
                                      titleFont: .system(size: 15, weight: fontWeight),
                                      backgroundColor: Color.white.opacity(0.9),
                                      bottomPadding: bottomPadding)
        }
    }
    
    internal struct Config {
        let titleColor: Color
        let titleFont: Font
        let subTitleColor: Color
        let subTitleFont: Font
        let backgroundColor: Color
        let duration: TimeInterval
        let transition: AnyTransition
        let animation: Animation
        let bottomPadding: CGFloat
        var textAlignment: HorizontalAlignment = .center
        var fullSize: Bool
        
        internal init(titleColor: Color = Color(red: 44 / 255, green: 44 / 255, blue: 44 / 255),
             titleFont: Font = .system(size: 14),
             subTitleColor: Color = Color(red: 44 / 255, green: 44 / 255, blue: 44 / 255),
             subTitleFont: Font = .system(size: 14),
             backgroundColor: Color = Color.white.opacity(0.9),
             duration: TimeInterval = 2.0,
             transition: AnyTransition = .opacity,
             animation: Animation = .linear(duration: 0.3),
             bottomPadding: CGFloat = 18,
             textAlignment: HorizontalAlignment = .center,
             fullSize: Bool = false
        ) {
                self.titleColor = titleColor
                self.titleFont = titleFont
                self.subTitleColor = subTitleColor
                self.subTitleFont = subTitleFont
                self.backgroundColor = backgroundColor
                self.duration = duration
                self.transition = transition
                self.animation = animation
                self.bottomPadding = bottomPadding
                self.textAlignment = textAlignment
                self.fullSize = fullSize
        }
    }

    internal var body: some View {
        ZStack {
            toastView
        }
    }

    private var toastView: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                
                if config.fullSize {
                    HStack {
                        Spacer()
                    }
                }
                
                HStack {
                    if config.textAlignment == .trailing {
                        Spacer()
                    }
                    
                    Text(NSLocalizedString(title, value: title, comment: ""))
                        .foregroundColor(config.titleColor)
                        .font(config.titleFont)
                        .lineSpacing(4)
                        .multilineTextAlignment(config.fullSize ? .leading : .center)
                    
                    
                    if config.textAlignment == .leading {
                        Spacer()
                    }
                }
                
                if subTitle != nil {
                    Text(subTitle!)
                        .foregroundColor(config.subTitleColor)
                        .font(config.subTitleFont)
                }
                
            }.multilineTextAlignment(.center)
            .frame(minWidth: UIScreen.main.bounds.width - 130, minHeight: 25)
            .padding(.horizontal, config.fullSize ? 25 : 16)
            .padding(.vertical, config.fullSize ? 10 : 7)
            .background(config.backgroundColor)
            .cornerRadius(config.fullSize ? 10 : 6)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, config.bottomPadding)
        .transition(config.transition)
        
    }
}
