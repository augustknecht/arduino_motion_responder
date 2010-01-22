class MotionDetector < ArduinoSketch
  
  input_pin 0, :as => :sensor
  output_pin 7, :as => :motion
  
  serial_begin :rate => 9600
  
  def loop
    motion_in = analogRead sensor
    serial_println motion_in
    
    digitalWrite(motion, motion_in > 500)
    delay 100
  end
    
end
