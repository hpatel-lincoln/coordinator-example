// Created by Hardik Patel on 9/4/21.

import Foundation

typealias DeepLink = [DeepLinkComponent]

enum DeepLinkComponent {
  // Auth
  case signup
  
  // Home
  case home
  case push
  case pushFlow
  case pushFlowDetail
  
  // More
  case more
  case about
}
