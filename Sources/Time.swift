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
	public static var Now: Time {
		return Time(value: Double(mach_absolute_time() * Base) / 1_000_000_000, unit: .Seconds)
	}

	public static func FromMachTimeStamp(_ ts: UInt64) -> Time {
		return Time(value: Double(ts * Base) / 1_000_000_000, unit: .Seconds)
	}

	public var machTimeStamp: UInt64 {
		return UInt64(convert(to: .Nanoseconds).value) / Time.Base
	}

	public func convert(to: Unit) -> Time {
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
		var info = mach_timebase_info(numer: 0, denom: 0)
		mach_timebase_info(&info)
		return UInt64(info.numer / info.denom)
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
