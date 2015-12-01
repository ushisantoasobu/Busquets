# Busquets

[![CI Status](http://img.shields.io/travis/ushisantoasobu/Busquets.svg?style=flat)](https://travis-ci.org/ushisantoasobu/Busquets)
[![Version](https://img.shields.io/cocoapods/v/Busquets.svg?style=flat)](http://cocoapods.org/pods/Busquets)
[![License](https://img.shields.io/cocoapods/l/Busquets.svg?style=flat)](http://cocoapods.org/pods/Busquets)
[![Platform](https://img.shields.io/cocoapods/p/Busquets.svg?style=flat)](http://cocoapods.org/pods/Busquets)

Simple Swift in-memory LRU cache

## Install

### CocoaPods

Busquets is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Busquets"
```

## Requirements

- iOS 9.X (iOS 8.X is not tested yet)
- Swift 2.0

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```Swift
let stringCache = Busquets<String>()
stringCache.set("nickname", value: "ushisantoasobu")
print(stringCache.get("nickname"))

let intCache = Busquets<Int>()
intCache.set("age", value: 31)
print(intCache.get("age"))
```

### get

```swift
get(key :String) -> AnyObject?
```

### set

```swift
set(key :String, value :AnyObject) -> Bool
```

### hasValue

```swift
hasValue(key :String) -> Bool
```

### getCapacity

```swift
getCapacity() -> Int
```

### getCount

```swift
getCount() -> Int
```

### getKeys

```swift
getKeys() -> Array<String>
```

### getValues

```swift
getValues() -> Array<AnyObject>
```

### remove

```swift
remove(key :String)
```

### removeAll

```swift
removeAll()
```

## Author

ushisantoasobu, babblemann.shunsee@gmail.com

## License

Busquets is available under the MIT license. See the LICENSE file for more info.
