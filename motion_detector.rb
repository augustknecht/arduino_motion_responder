class MotionDetector < ArduinoSketch
  input_pin 7, :as => :sensor
  output_pin 6, :as => :led
  
  serial_begin :rate => 9600
  
  def loop
    motion = sensor.digitalRead
    
    # Light up LED if there is motion
    led.digitalWrite motion
    
    #print to serial if there is motion
    serial_print("1") if motion
    
    delay 100
  end
end