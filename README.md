# SCToastAlert: A SwiftUI Custom Toast Alert

# Overview
A library that makes Toast Alert globally available.

# Features
- Change Toast background color: You can change the Toast background color.
- Text customization: You can set title, subtitle (subtitle is optional)
- Font customization: You can set the font weight.
- Set Bottom Padding: You can set the Bottom Padding.
  - Bottom Padding is a padding value calculated based on the bottom of the phone view.

# Requirements
- iOS 13.0 or later
- Swift 5.0 or later
- Xcode 14.0 or later

# Usage

To use SCToastAlert in your SwiftUI view:

```swift
import SCToastAlert

var toast = SCToastAlert()

// only Text | Default Background Color is Black
toast.show(title: "Toast Information")

// add SubTitle
toast.show(title: "Toast Information", subTitle: "Subtitle Information")

// custom BackgroundColor and Text Weight , padding
toast.show(title: "Toast Information", subTitle: "Subtitle Information", type: .black(fontWeight: .bold, bottomPadding: 70))

```

# Contribution
Contributions are welcome! If you'd like to improve SCToastAlert, please feel free to fork the repository, make changes, and submit a pull request.

# License
SCToastAlert is available under the MIT license. See the LICENSE file for more info.

# Acknowledgements
Created by JEJEMEME, a passionate Swift developer and open-source contributor.
