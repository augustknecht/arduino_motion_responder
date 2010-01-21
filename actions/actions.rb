require 'rubygems'
require 'serialport'

module ActionTaker
  extend self
  
  def read_loop
    sp = SerialPort.new "/dev/tty.usbserial-A70061BP", 9600
  
    while true do
      puts "read: #{sp.readline.to_i}"
    end
  end
  
  
  
end

ActionTaker.read_loop