# time
A small utility to handle mach_absolute_time and timestamps.

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()
[![GitHub release](https://img.shields.io/github/release/randymarsh77/time.svg)]()
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Build Status](https://api.travis-ci.org/randymarsh77/time.svg?branch=master)](https://travis-ci.org/randymarsh77/time)
[![codecov.io](https://codecov.io/gh/randymarsh77/time/branch/master/graphs/badge.svg)](https://codecov.io/gh/randymarsh77/time/branch/master)
[![codebeat badge](https://codebeat.co/badges/bbf19ae9-35d5-4eb5-a47f-561480300607)](https://codebeat.co/projects/github-com-randymarsh77-time)

# Usage

Create some time
```
let now = Time.Now
```

Get the mach value
```
let mach = now.machTimeStamp
```

Create some time with a mach value
```
_ = Time.FromMachTimeStamp(mach)
```

Add a second
```
let aSecondFromNow = now + Time(value: 1, unit: .Seconds)
```

Subtract some micros
```
_ = aSecondFromNow - Time(value: 1234, unit: .Microseconds)
```

Compare
```
_ = aSecondFromNow == now
_ = aSecondFromNo != now
```

Make a second
```
aSecond = aSecondFromNow - now
```
