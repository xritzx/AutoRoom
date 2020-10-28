#include "DHT.h"
#include <FirebaseArduino.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include <Adafruit_NeoPixel.h>

#define FIREBASE_HOST "xxxxxxxxxxxxx"
#define WIFI_SSID "xxxxxxxxxxxxxx"
#define WIFI_PASSWORD "xxxxxxxxxxxxxx"
#define FIREBASE_AUTH "xxxxxxxxxxxxxx" //Database Secret 

#define FAIL_INDICATOR 16
#define FAN_PIN 4
#define LIGHT_PIN 5
#define PIXEL_PIN 14
#define DHT_PIN 2
#define DHTTYPE DHT11
#define PIXEL_COUNT 60

uint32_t TIME = 0;
uint32_t TIMER = 10000;

Adafruit_NeoPixel strip = Adafruit_NeoPixel(PIXEL_COUNT, PIXEL_PIN, NEO_GRB + NEO_KHZ800);
DHT dht(DHT_PIN, DHTTYPE); 
// Global Variables for temperature and humidity
int humidity;
int temp;
String user = "xritzx";

void setup() {

  // Initializing
  Serial.begin(9600);
  dht.begin();
  strip.begin();

  // Defining the pinMode
  pinMode(LIGHT_PIN, OUTPUT);
  pinMode(FAN_PIN, OUTPUT);
  pinMode(FAIL_INDICATOR, OUTPUT);

  strip.setBrightness(255);
  strip.show();
  
  //Connect to the WiFi 
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to your WiFi SSID ");
  Serial.println(WIFI_SSID);
  delay(1000);

  // Blocking Connection
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(600);
  }

  // Connection established
  Serial.print("\n Connected on ");
  Serial.println(WiFi.localIP());

  // Establish the connection with Firebase
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.stream(user);
  Serial.println("Firebase Connection Failed !");
  Serial.println(Firebase.failed());
  Serial.println(Firebase.error());
  delay(1000);

}

//-----------HELPER FUNCTIONS--------------//

int getNeopixelIndex(String path){
  String num = "";
  if(path.indexOf("range")!=-1)return -2;
  for(int i = path.length()-1; i>0; i--){
    if(isDigit(path[i])){
      num=path[i]+num;
    }
    else break;
  }
  return num.length()>0? num.toInt(): -1;
}

void updateNeopixel(int index, JsonObject& object){
    static uint8_t r,g,b;
    static uint32_t color;
    static String range;
    int ranges[2];
    r = object.get<String>("r").toInt();
    g = object.get<String>("g").toInt();
    b = object.get<String>("b").toInt();
    range = object.get<String>("range");
    
    color = strip.Color(r, g, b);

    if(range!=NULL || range!="" || index==-2){
      // Tokenizer block
      range+=",";
      int j=0;
      String buff="";
      for(int i=0;i<range.length();i++){
        if(j>1)break;
        if(range[i]==','){
          ranges[j]=buff.toInt();
          j++;
          buff = "";
        }
        else buff+=range[i];
      }
      for(j=ranges[0];j<=ranges[1];j++){
        strip.setPixelColor(j, color);
      }
    }
    else{
      if(index>=0) strip.setPixelColor(index, color);
      else strip.fill(color);
    }
    strip.show();
}

void updateFan(String value){
 Serial.println(value.toInt());
 value.toInt()? digitalWrite(FAN_PIN, 1): digitalWrite(FAN_PIN, 0);
}

void updateLight(String value){
  int val = map(value.toInt(), 255, 0, 0, 1023);
  Serial.println(val);
  analogWrite(LIGHT_PIN, val);
}

void readTnH(){
  if(millis() > TIME + TIMER){
    humidity = dht.readHumidity();
    temp = dht.readTemperature();

    String json = "{\"temp\":"+String(temp)+",\"humidity\":"+String(humidity)+"}";
    StaticJsonBuffer<100> jsonBuffer;
    JsonVariant params = jsonBuffer.parse(json);
    Firebase.set("/"+user+"/params", params);
    params.printTo(Serial);  
                                                                                                                                                                              
    TIME = millis();
    TIMER = 10000;
  }
}

void loop(){
  
  if(Firebase.failed()){
    analogWrite(FAIL_INDICATOR, 200);
  }

  if(Firebase.available()){
    analogWrite(FAIL_INDICATOR, 1012);
    FirebaseObject event = Firebase.readEvent();
    String eventType = event.getString("type");
    String path = event.getString("path");
    eventType.toLowerCase();
    Serial.println(eventType);
    Serial.println(path);
    
    JsonVariant jsonVariant = event.getJsonVariant("data");    
    JsonObject& object = jsonVariant.as<JsonObject>();
    object.printTo(Serial);

    if(path.indexOf("neopixels")>0){
      int index = getNeopixelIndex(path);
      updateNeopixel(index, object);
    }

    String fan = object.get<String>("fan");
    String light = object.get<String>("light");

    if(fan != NULL) updateFan(fan);
    if(light != NULL) updateLight(light);

  }
//  readTnH();  
}
