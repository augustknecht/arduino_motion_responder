require 'rubygems'
require 'serialport'

module DataReceiver
  extend self
  
  def read_loop
    initialization
    sp = SerialPort.new @config["serial"], @config["baud_rate"]
    
    loop do
      if(motion_detected?(sp))
        new_motion
      else
        check_expiration
      end
      
      # So we don't eat up processor cycles
      sleep 0.01
    end
  end
  
  def initialization
    @config = read_config("#{File.dirname(__FILE__)}/config.yml")
    @someone_was_here = false
    @expire_timer = Time.new
  end
  
  def read_config(file)
    YAML.load_file(file)["config"]
  end
  
  def motion_detected?(sp)
    sp.read_nonblock(1) rescue false
  end
  
  def new_motion
    reset_timer
    arrival_actions if !@someone_was_here
  end
  
  def reset_timer
    @expire_timer = Time.new
  end
  
  def check_expiration
    departure_actions if (over_threshhold? && @someone_was_here)
  end
  
  def over_threshhold?
    (Time.new - @expire_timer) > @config["expire_time"]
  end
  
  def arrival_actions
    @someone_was_here = true
    execute_file_by_line("#{File.dirname(__FILE__)}/arrival_actions")
  end
  
  def departure_actions
    @someone_was_here = false
    execute_file_by_line("#{File.dirname(__FILE__)}/departure_actions")
  end
  
  def execute_file_by_line(file)
    puts "Executing file #{file}... #{Time.now}"
    f = File.open(file) or die "Unable to open file #{file}!"
    f.each_line { |line| system(line) }
  end
end

DataReceiver.read_loop