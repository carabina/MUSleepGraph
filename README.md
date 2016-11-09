# MUSleepGraph
MUSleepGraph is a unique way to show data in curved line graph. 

![alt tag](http://i.giphy.com/cMlArCFZal2P6.gif)


## Requirements
* Xcode 6 or higher
* Apple LLVM compiler
* iOS 7.0 or higher (May work on previous versions, just did not testit. Feel free to edit it).
* ARC

## Demo

Open and run the MUSleepGraph project in Xcode to see MUSleepGraph in action.

## Installation

### Manual install

All you need to do is drop these files into your project and include headers:
* MUSleepGraph.h and .m
* GraphPoints.h and .m
* UILabel+kerning.h and .m
* Constants.h

## Example usage

``` 
MUSleepGraph *graphView = [[MUSleepGraph alloc]  initWithGraphView:self.view];

	//Customize the public properties
	graphView.maxSleepHours = 100;
	graphView.numberOfWeeks = 1;

	NSMutableArray *yValuesArray = [NSMutableArray array];
	for (int i = 0; i < 7 * graphView.numberOfWeeks; i++) {
		//we are going to show sleep graph for one week.
		//put your own values here
		int sleepHours = random()  % self.maxGraphValue;
		[yValuesArray addObject:@(sleepHours)];
	}

	graphView.labelsView = self.view;
	graphView.sleepHours = yValuesArray;
	[graphView drawSleepGraph];

	[self.view addSubview:graphView];
```

## TODO

* Add more customisations

## Contact

Muhammad Usman

- https://github.com/usadmania
- usadmania@gmail.com

## License

The MIT License (MIT)

Copyright (c) 2016 usadmania

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
