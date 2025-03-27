//
//  Environment.swift
//  Clima
//
//  Created by 大西志織 on 2025/03/27.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

enum FlaverType {
  case debug
  case release
  case etc
}

enum BuildType {
  case debug
  case release
}

func getFlaverType() -> FlaverType {
  #if DEBUG
  return .debug
  #elseif RELEASE
  return .release
  #else
  return .debug
  #endif
}

func getBuildType() -> BuildType {
  #if DEBUG
  return .debug
  #elseif RELEASE
  return .release
  #else
  return .debug
  #endif
}

func isDevelop() -> Bool {
  return getFlaverType() == .debug
}

func isProduction() -> Bool {
  return getFlaverType() == .release
}

func isDebug() -> Bool {
  return getBuildType() == .debug
}

func isRelease() -> Bool {
  return getBuildType() == .release
}
