import Foundation

public enum Unit
{
	case Seconds
	case Milliseconds
	case Microseconds
	case Nanoseconds
}

public struct Time
{
	public var value: Double
	public var unit: Unit
}

public extension Time
{
	static var Now: Time {
		return Time(value: Double(SystemNanos()) / 1_000_000_000, unit: .Seconds)
	}

	static func FromSystemTimeStamp(_ ts: UInt64) -> Time {
		return Time(value: Double(NanosFromSystemTimeStamp(ts)) / 1_000_000_000, unit: .Seconds)
	}

	static func FromInterval(_ interval: Double, unit: Unit) -> Time {
		return Time(value: interval, unit: unit)
	}

	var systemTimeStamp: UInt64 {
		return UInt64(convert(to: .Nanoseconds).value) / Time.Base
	}

	func convert(to: Unit) -> Time {
		return Time(value: value * Time.GetConversionFactor(unit, to), unit: to)
	}

	private static func GetConversionFactor(_ from: Unit, _ to: Unit) -> Double {
		return Time.GetUnitConversionValue(from) / Time.GetUnitConversionValue(to)
	}

	private static func GetUnitConversionValue(_ unit: Unit) -> Double {
		switch unit {
		case .Seconds:
			return 1_000_000_000
		case .Milliseconds:
			return 1_000_000
		case .Microseconds:
			return 1_000
		case .Nanoseconds:
			return 1
		}
	}

	private static func InitializeBase() -> UInt64 {
#if os(Linux)
		return 1
#else
		var info = mach_timebase_info(numer: 0, denom: 0)
		mach_timebase_info(&info)
		return UInt64(info.numer / info.denom)
#endif
	}

	private static func SystemNanos() -> UInt64 {
#if os(Linux)
		var ts = timespec()
		let r = clock_gettime(CLOCK_MONOTONIC_RAW, &ts)
		if r != 0 {
			fatalError("Failure in call to clock_gettime: \(r)")
		}
		return UInt64(ts.tv_sec) * 1_000_000_000 + UInt64(ts.tv_nsec)
#else
		return mach_absolute_time() * Base
#endif
	}

	private static  func NanosFromSystemTimeStamp(_ ts: UInt64) -> UInt64 {
#if os(Linux)
		return ts
#else
		return ts * Base
#endif
	}

	private static var Base: UInt64 = InitializeBase()
}

public extension Time
{
	static func + (left: Time, right: Time) -> Time {
		return Time(value: left.value + right.convert(to: left.unit).value, unit: left.unit)
	}

	static func - (left: Time, right: Time) -> Time {
		return Time(value: left.value - right.convert(to: left.unit).value, unit: left.unit)
	}

	static func == (left: Time, right: Time) -> Bool {
		return left.value == right.convert(to: left.unit).value
	}

	static func != (left: Time, right: Time) -> Bool {
		return !(left == right)
	}
}
