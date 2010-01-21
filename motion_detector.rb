class MotionDetector < ArduinoSketch
  
  input_pin 0, :as => :sensor
  
  serial_begin :rate => 9600
  
  def loop
    serial_println analogRead sensor
    delay 200
  end
    
end
