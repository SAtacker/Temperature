#include <Wire.h>
#include <Adafruit_MLX90614.h>
#include <ESP8266WebServer.h>
#include <ESP8266WiFi.h>
#include <string>
ESP8266WebServer server(80);
double temp=0;
Adafruit_MLX90614 mlx = Adafruit_MLX90614();
IPAddress staticIP(192,168,31,101);
IPAddress gateway(192,168,1,9);
IPAddress subnet(255,255,255,0);
const char* ssid = "Atre";
const char* password = "atre@714";
void tempsend(){
  for(int i=0;i<100;i++){
  digitalWrite(LED_BUILTIN,LOW);
  delay(10);
  digitalWrite(LED_BUILTIN,HIGH);
  temp += mlx.readObjectTempF();
  }
  temp/=100;
  server.send(200,"text/plain",String((temp-32)/1.8000));
  temp=0;
  // server.send(200,"text/plain","Hello");
}

void setup() 
{
  Serial.begin(9600);
  pinMode(LED_BUILTIN,OUTPUT);
  WiFi.config(staticIP, gateway, subnet);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    digitalWrite(LED_BUILTIN,HIGH);
    delay(500);
    digitalWrite(LED_BUILTIN,LOW);
  }
  digitalWrite(LED_BUILTIN,HIGH);
  Serial.print("Connected\n");
  Serial.print(WiFi.localIP());
  server.begin();
  server.on("/",tempsend);
  mlx.begin();  
}


void loop() 
{
  server.handleClient();
  // Serial.print("Ambient = "); 
  // temp = mlx.readAmbientTempC();
  // Serial.print(temp); 
  // Serial.print("*C\tObject = "); 
  // Serial.print(mlx.readObjectTempC()); 
  // Serial.println("*C");
  // Serial.println();
  // delay(1000);
}