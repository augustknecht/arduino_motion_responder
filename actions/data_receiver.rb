require 'rubygems'
require 'serialport'

module DataReceiver
  extend self
  
  # 0 = People not here
  # 1 = People here
  @previous_state = 0
  @expire_timer = Time.new
  
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
  
  def is_motion?(sensor_reading)
    sensor_reading > 500 # May need to be calibrated
  end
  
  def over_threshhold?
    (Time.new - @expire_timer) > 10
  end
  
  def reset_timer
    @expire_timer = Time.new
  end
  
  def new_motion
    arrival_actions if @previous_state == 0
    reset_timer
  end
  
  def check_expiration
    departure_actions if (over_threshhold? && @previous_state == 1)
  end
  
  def arrival_actions
    @previous_state = 1
    execute_file_by_line("arrival_actions")
  end
  
  def departure_actions
    @previous_state = 0
    execute_file_by_line("departure_actions")
  end
  
  def execute_file_by_line(file)
    puts "Executing file #{file}..."
    f = File.open(file) or die "Unable to open file #{file}!"
    f.each_line { |line| system(line) }
  end
end

DataReceiver.read_loop