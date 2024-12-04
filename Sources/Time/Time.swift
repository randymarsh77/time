import Foundation

public enum Unit {
	case seconds
	case milliseconds
	case microseconds
	case nanoseconds
}

public struct Time {
	public var value: Double
	public var unit: Unit
}

extension Time {
	public static var now: Time {
		return Time(value: Double(systemNanos()) / 1_000_000_000, unit: .seconds)
	}

	public static func fromSystemTimeStamp(_ ts: UInt64) -> Time {
		return Time(value: Double(nanosFromSystemTimeStamp(ts)) / 1_000_000_000, unit: .seconds)
	}

	public static func fromInterval(_ interval: Double, unit: Unit) -> Time {
		return Time(value: interval, unit: unit)
	}

	public var systemTimeStamp: UInt64 {
		return UInt64(convert(to: .nanoseconds).value) / Time.Base
	}

	public func convert(to: Unit) -> Time {
		return Time(value: value * Time.getConversionFactor(unit, to), unit: to)
	}

	private static func getConversionFactor(_ from: Unit, _ to: Unit) -> Double {
		return Time.getUnitConversionValue(from) / Time.getUnitConversionValue(to)
	}

	private static func getUnitConversionValue(_ unit: Unit) -> Double {
		switch unit {
		case .seconds:
			return 1_000_000_000
		case .milliseconds:
			return 1_000_000
		case .microseconds:
			return 1_000
		case .nanoseconds:
			return 1
		}
	}

	private static func initializeBase() -> UInt64 {
		#if os(Linux) || arch(arm64)
			return 1
		#else
			var info = mach_timebase_info(numer: 0, denom: 0)
			mach_timebase_info(&info)
			return UInt64(info.numer / info.denom)
		#endif
	}

	private static func systemNanos() -> UInt64 {
		#if os(Linux)
			var ts = timespec()
			let r = clock_gettime(CLOCK_MONOTONIC_RAW, &ts)
			if r != 0 {
				fatalError("Failure in call to clock_gettime: \(r)")
			}
			return UInt64(ts.tv_sec) * 1_000_000_000 + UInt64(ts.tv_nsec)
		#else
			return clock_gettime_nsec_np(CLOCK_UPTIME_RAW) * Base
		#endif
	}

	private static func nanosFromSystemTimeStamp(_ ts: UInt64) -> UInt64 {
		#if os(Linux) || arch(arm64)
			return ts
		#else
			return ts * Base
		#endif
	}

	private static let Base: UInt64 = initializeBase()
}

extension Time {
	public static func + (left: Time, right: Time) -> Time {
		return Time(value: left.value + right.convert(to: left.unit).value, unit: left.unit)
	}

	public static func - (left: Time, right: Time) -> Time {
		return Time(value: left.value - right.convert(to: left.unit).value, unit: left.unit)
	}

	public static func == (left: Time, right: Time) -> Bool {
		return left.value == right.convert(to: left.unit).value
	}

	public static func != (left: Time, right: Time) -> Bool {
		return !(left == right)
	}
}
