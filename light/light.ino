#include <WiFi.h>
#include <ArduinoJson.h>
#include <binary.h>
#include <PubSubClient.h>

#define WIFI_STA_NAME "" //change to your own ssid
#define WIFI_STA_PASS "" //change to your own password

#define MQTT_SERVER "m16.cloudmqtt.com"
#define MQTT_PORT 16319
#define MQTT_USER_ID "GESTURE01"
#define MQTT_USERNAME "ggaomyqh"
#define MQTT_PASSWORD "3wjA27NFU3ET"

char output[1024];

WiFiClient client;
PubSubClient mqtt(client);

void setup()
{
    Serial.begin(9600);
    pinMode(LED_BUILTIN, OUTPUT);

    Serial.println();
    Serial.println();
    Serial.print("Connecting to ");
    Serial.println(WIFI_STA_NAME);

    WiFi.mode(WIFI_STA);
    WiFi.begin(WIFI_STA_NAME, WIFI_STA_PASS);

    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        Serial.print(".");
        digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
    }

    digitalWrite(LED_BUILTIN, HIGH);
    Serial.println("");
    Serial.println("WiFi connected");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());

    mqtt.setServer(MQTT_SERVER, MQTT_PORT);
}

void loop()
{
    if (mqtt.connected() == false)
    {
        Serial.print("MQTT connection... ");
        if (mqtt.connect(MQTT_USER_ID, MQTT_USERNAME, MQTT_PASSWORD))
        {
            Serial.println("connected");
        }
        else
        {
            Serial.println("failed");
            delay(5000);
        }
    }
    else
    {
        mqtt.loop();

        // GeoLocation Send Here
        sendDataToServer();
    }
}

void sendDataToServer()

{
    long prob = 0;
    StaticJsonDocument<1024> doc;

    doc["type"] = "ferry";
    doc["ship_id"] = ""; //add docID same with firebase per each ship
    doc["lat"] = 0.0;
    doc["lng"] = 0.0;

    delay(100);

    serializeJson(doc, output);

    delay(100);

    mqtt.publish("/locations", output);
}
