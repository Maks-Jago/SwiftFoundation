# SwiftFoundation

SwiftFoundation is a collection of useful extensions and utilities for the Swift programming language. This library provides a variety of enhancements to existing Swift types, making common tasks more convenient and efficient. It also includes features for working with URLs, HTTP requests, date and time formatting, encoding/decoding, and more.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Extensions](#extensions)
  - [Array](#array)
  - [Bool](#bool)
  - [Bundle](#bundle)
  - [Calendar](#calendar)
  - [CharacterSet](#characterset)
  - [CLLocation](#cllocation)
  - [CNMutablePostalAddress](#cnmutablepostaladdress)
  - [CodingUserInfoKey](#codinguserinfokey)
  - [Data](#data)
  - [Date](#date)
  - [DateFormatter](#dateformatter)
  - [Dictionary](#dictionary)
  - [Double](#double)
  - [Encodable](#encodable)
  - [Formatter](#formatter)
  - [Int](#int)
  - [JSONDecoder](#jsondecoder)
  - [KeyedDecodingContainer](#keyeddecodingcontainer)
  - [NSSortDescriptor](#nssortdescriptor)
  - [Numeric](#numeric)
  - [String](#string)
  - [URL](#url)
  - [URLRequest](#urlrequest)
- [Utilities](#utilities)
  - [AnyCodable](#anycodable)
  - [EquatableNoop](#equatablenoop)
  - [Faking](#faking)
  - [HashableNoop](#hashablenoop)
  - [IndexedCollection](#indexedcollection)
  - [S3MediaResource](#s3mediaresource)
  - [StorableValue](#storablevalue)
  - [SafetyStorage](#safetystorage)
- [License](#license)

## Installation

To use SwiftFoundation in your project, you can simply include the source files in your project or add it as a Swift Package.

## Usage

Each extension and utility included in this library extends existing Swift types or provides new functionality to make your code more concise and expressive. Refer to the extensions listed below for details on usage.

## Extensions

### Array
- `jsonArray`
- `sorted(keyPath:ascending:)`
- `toggle(_:)`
- `removeFirst(_:)`
- `safeIndex`
- `toDictionary(_:)`
- `ids`
- `mutate(_:)`

### Bool
- `init(_:)`
- `toggle()`

### Bundle
- `appVersion`
- `buildNumber`
- `appVersionWithBuildNumber`

### Calendar
- `generateDates(inside:matching:)`

### CharacterSet
- `urlQueryValueAllowed`

### CLLocation
- `isValid`
- `isZero`
- `string`
- `whiteHouse`
- `isWhiteHouse`
- `vCard(title:)`

### CNMutablePostalAddress
- `init(placemark:)`

### CodingUserInfoKey
- `codingKeys`

### Data
- `unwrapJSONDataBy(key:)`
- `applyBlockForEachJSONObject(_:)`
- `applyBlockForJSONObject(_:)`

### Date
- `yesterday`
- `tomorrow`
- `startOfDay`
- `endOfDay`
- `dateByAdding(days:)`
- `noon`
- `day`
- `month`
- `startOfMonth`
- `endOfMonth`
- `isLastDayOfMonth`
- `setTime(from:)`
- `daysDiff(from:)`
- `add(_:)`
- `add(_:to:)`
- `add(_:)`

### DateFormatter
- `iso8601`
- `medium`
- `full`
- `mediumWithTime`
- `monthFull`
- `monthShort`
- `weekday`
- `weekdayShort`
- `year`

### Dictionary
- `jsonString`
- `percentEscaped`

### Double
- `SecondsConvertibleComponent`
- `seconds(in:_:)`
- `secondsAs(_:)`

### Encodable
- `dictionary`

### Formatter
- `withSeparator`
- `roundingDownWithSeparator`

### Int
- `init(_:)`

### JSONDecoder
- `snakeCaseDecoder`

### KeyedDecodingContainer
- `decode(_:as:)`
- `decodeIfPresent(_:)`
- `decodeSafely(_:)`
- `decodeSafelyIfPresent(_:)`

### NSSortDescriptor
- `byId(asending:)`

### Numeric
- `formattedWithSeparator`
- `roundingDownWithSeparator`

### String
- `capitalizingFirstLetter()`
- `toData(using:)`
- `evaluate(withRegex:)`
- `id`
- `toBase64()`
- `fromBase64()`
- `format(parameters:...)`
- `sliceIncluding(from:to:)`
- `convertHtml()`

### URL
- `id`
- `queryFirstValue`
- `queryDict`

### URLRequest
- `init(url:method:headers:multipartFormData:)`

## Utilities

### AnyCodable
- Provides a type-erased wrapper for Codable types.

### EquatableNoop
- A property wrapper that makes a value conform to `Equatable` without actually comparing its wrapped value.

### Faking
- Provides functionality to generate fake instances of types conforming to the `Faking` protocol.

### HashableNoop
- A property wrapper that makes a value conform to `Hashable` without affecting its hash value.

### IndexedCollection
- A wrapper for collections that provides access to both the index and the element.

### S3MediaResource
- Represents a media resource with support for generating scaled image URLs.

### StorableValue
- A property wrapper that provides an interface for storing values in `SafetyStorage`.

### SafetyStorage
- A protocol for safely saving and loading data.

## License

This library is released under the MIT license. See [LICENSE](License) for details.
