Arduino Motion Responder
=======================================

Upon walking into the office, your computer greets you, turns on the monitors, starts your email client, newsreader, web-browser, and music application.  Ready to go.

motion_detector.rb
-----------------

This code gets compiled down to C and put on the arduino using [RAD]("http://rad.rubyforge.org/").  It reports motion over USB when it detects it.  It also makes an LED light up if it is detecting motion.

data_receiver.rb
-----------------

This code receives the serial input from the arduino and using this data, keeps track of who is around.  When no motion is detected in X number of seconds (specified in the _config_ file), it assumes that there is nobody around and executes system commands that are specified in the _departure\_actions_ file.  When motion is detected for the first time it executes the commands in the _arrival\_actions_ file.

In _config.yml_, specify the serial device, baud rate (default is 9600), and the expire time in seconds.  Expire time is the time until the device thinks that you are gone.

circuit
-----------------

![Motion detector circuit](http://github.com/augustknecht/arduino_motion_responder/raw/master/circuit_diagram.png "Motion detector circuit")

This circuit is built on the arduino using a protoshield, LED, resistor, and a basic [PIR Sensor Module]("http://www.radioshack.com/product/index.jsp?productId=2906724") from Radio Shack.

license
-------
(uiuc/ncsa open source license)

    Copyright (c) 2009 August Knecht.  All rights reserved.
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to
    deal with the Software without restriction, including without limitation the
    rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
      1. Redistributions of source code must retain the above copyright notice,
         this list of conditions and the following disclaimers.
      2. Redistributions in binary form must reproduce the above copyright
         notice, this list of conditions and the following disclaimers in the
         documentation and/or other materials provided with the distribution.
      3. The names of its contributors may not be used to endorse or promote
         products derived from this Software without specific prior written 
         permission.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    WITH THE SOFTWARE.
