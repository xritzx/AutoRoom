#include <FirebaseArduino.h>
#include <ESP8266WiFi.h>
#include <DNSServer.h>
#include <ESP8266WebServer.h>
#include <WiFiManager.h>
#include <EEPROM.h>

//#define SWITCH_PIN D6

//EEPROM address definition
#define Start_Address 0

#define OnOff_Address_1 Start_Address + sizeof(int)
#define OnOff_Address_2 OnOff_Address_1 + sizeof(int)
#define OnOff_Address_3 OnOff_Address_2 + sizeof(int)
#define OnOff_Address_4 OnOff_Address_3 + sizeof(int)

//Firebase Database URL and KEY
#define FIREBASE_DATABASE_URL "Your Firebase URL"
#define FIREBASE_KEY "Your Firebase Secret"

//Set the ID to the device id used in the index.json file
static const String STRMDEVID[4] =  {"1", "2", "3", "4"};
static const String STRMDEVID_1 =  "1";
static const String STRMDEVID_2 =  "2";
static const String STRMDEVID_3 =  "3";
static const String STRMDEVID_4 =  "4";

//Variables for OnOffvalue
bool OnOffvalue;

void setup() {

//  pinMode(SWITCH_PIN, OUTPUT);
  pinMode(D1, OUTPUT);
  pinMode(D2, OUTPUT);
  pinMode(D5, OUTPUT);
  pinMode(D6, OUTPUT);
  Serial.begin(115200);
  
  EEPROM.begin(256);
  EEPROM.get(OnOff_Address_1, OnOffvalue);
  digitalWrite(D1, OnOffvalue);
  EEPROM.get(OnOff_Address_2, OnOffvalue);
  digitalWrite(D2, OnOffvalue);
  EEPROM.get(OnOff_Address_3, OnOffvalue);
  digitalWrite(D5, OnOffvalue);
  EEPROM.get(OnOff_Address_4, OnOffvalue);
  digitalWrite(D6, OnOffvalue);

  //WiFi Manager
  WiFiManager wifiManager;
  wifiManager.autoConnect("MW-Smart-Device", "mwsd1234");
  Serial.println("Connected..");

  //Firebase Declaration
  Firebase.begin(FIREBASE_DATABASE_URL, FIREBASE_KEY);
  Firebase.stream("");
}


void loop() {
  //Check Firebase connection
  if (Firebase.failed()) {
    Serial.println("Streaming Error");
    Serial.println(Firebase.error());
  }
  if (Firebase.available()) {
    FirebaseObject event = Firebase.readEvent();
    String eventType = event.getString("type");
    eventType.toLowerCase();
    Serial.println(eventType);
    String path = event.getString("path");
    Serial.println(path);
    if (eventType == "patch" || eventType == "put") {
      
//      if (path == "/1/OnOff" || path == "/2/OnOff" || path == "/3/OnOff" || path == "/4/OnOff") {
//        
//        bool OnOffvalue = Firebase.getBool("/" + STRMDEVID_1 + "/OnOff/on");
//        // Due to this relay, invert it.
//        Serial.println(i + " <= " + OnOffvalue);
////          digitalWrite(SWITCH_PIN, OnOffvalue);
//        if (i==0){
//          digitalWrite(D1, OnOffvalue);
//          EEPROM.put(OnOff_Address_1, OnOffvalue);
//        } else if (i==1) {
//          digitalWrite(D2, OnOffvalue);
//          EEPROM.put(OnOff_Address_2, OnOffvalue);
//        } else if (i==2) {
//          digitalWrite(D5, OnOffvalue);
//          EEPROM.put(OnOff_Address_3, OnOffvalue);
//        } else if (i==3) {
//          digitalWrite(D6, OnOffvalue);
//          EEPROM.put(OnOff_Address_4, OnOffvalue);
//        }
////          EEPROM.put(OnOff_Address, OnOffvalue);
//        EEPROM.commit();
//        EEPROM.end();
//      }     

      if(path == "/1/OnOff") {
        bool OnOffvalue = Firebase.getBool("/" + STRMDEVID_1 + "/OnOff/on");
        Serial.print("Switch One => ");
        Serial.println(OnOffvalue);
        digitalWrite(D1, OnOffvalue);
        EEPROM.put(OnOff_Address_1, OnOffvalue);
        EEPROM.commit();
        EEPROM.end();
      } else if(path == "/2/OnOff") {
        bool OnOffvalue = Firebase.getBool("/" + STRMDEVID_2 + "/OnOff/on");
        Serial.print("Switch Two => ");
        Serial.println(OnOffvalue);
        digitalWrite(D2, OnOffvalue);
        EEPROM.put(OnOff_Address_2, OnOffvalue);
        EEPROM.commit();
        EEPROM.end();
      } else if(path == "/3/OnOff") {
        bool OnOffvalue = Firebase.getBool("/" + STRMDEVID_3 + "/OnOff/on");
        Serial.print("Switch Two => ");
        Serial.println(OnOffvalue);
        digitalWrite(D5, OnOffvalue);
        EEPROM.put(OnOff_Address_3, OnOffvalue);
        EEPROM.commit();
        EEPROM.end();
      } else if(path == "/4/OnOff") {
        bool OnOffvalue = Firebase.getBool("/" + STRMDEVID_4 + "/OnOff/on");
        Serial.print("Switch Two => ");
        Serial.println(OnOffvalue);
        digitalWrite(D6, OnOffvalue);
        EEPROM.put(OnOff_Address_4, OnOffvalue);
        EEPROM.commit();
        EEPROM.end();
      }
      // 4 Cases, can add more.
    }
  }

}