require 'rubygems'
require 'serialport'

module ActionTaker
  extend self
  
  @expire_timer = Time.new
  
  def is_motion?(sensor_reading)
    sensor_reading > 500
  end
  
  def over_threshhold?
    (Time.new - @expire_timer) > 10
  end
  
  def reset_timer
    puts "Reset Timer"
    @expire_timer = Time.new
  end
  
  def read_loop
    sp = SerialPort.new "/dev/tty.usbserial-A70061BP", 9600
  
    while true do
      if(is_motion?(sp.readline.to_i))
        new_motion
      else
        check_expiration
      end
    end
  end
  
  def new_motion
    here_actions if over_threshhold?
    reset_timer
  end
  
  def check_expiration
    gone_actions if over_threshhold?
  end
  
  def here_actions
    puts "Someone is here"
  end
  
  def gone_actions
    puts "Everyone is gone!!!"
  end
end

ActionTaker.read_loop