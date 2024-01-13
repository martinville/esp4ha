#!/usr/bin/with-contenv bashio
while :
do
CONFIG_PATH=/data/options.json

ESP_API_KEY=""
YOUR_AREAD_ID=""
Refresh_rate=1800

ESP_API_KEY="$(bashio::config 'ESP_API_KEY')"
YOUR_AREAD_ID="$(bashio::config 'YOUR_AREAD_ID')"
HA_LongLiveToken="$(bashio::config 'HA_LongLiveToken')"
Home_Assistant_IP="$(bashio::config 'Home_Assistant_IP')"
HTTP_Connect_Type="$(bashio::config 'HTTP_Connect_Type')"
Home_Assistant_PORT="$(bashio::config 'Home_Assistant_PORT')"
Refresh_rate="$(bashio::config 'Refresh_rate')"



echo "-------------------------------------------------------------------------------"
echo "ESP4HA Starting up..."
echo "-------------------------------------------------------------------------------"
echo "ESP_API_KEY="$ESP_API_KEY
echo "YOUR_AREAD_ID="$YOUR_AREAD_ID
echo "Refresh_rate="$Refresh_rate
echo "-------------------------------------------------------------------------------"
echo "ESP information"
echo "-------------------------------------------------------------------------------"

#Fetch Data to file.
curl -s -X GET -H "Content-Type: application/json" -H "token:  $ESP_API_KEY" https://developer.sepush.co.za/business/2.0/api_allowance -o "espquota.json"
curl -s -X GET -H "Content-Type: application/json" -H "token:  $ESP_API_KEY" https://developer.sepush.co.za/business/2.0/status -o "ls_stage.json"
curl -s -X GET -H "Content-Type: application/json" -H "token:  $ESP_API_KEY" https://developer.sepush.co.za/business/2.0/area?id=$YOUR_AREAD_ID -o "ls_myarea.json"
#lsMyArea='{"events":[{"end":"2024-01-05T22:30:00+02:00","note":"Stage 3","start":"2024-01-05T20:00:00+02:00"},{"end":"2024-01-06T06:30:00+02:00","note":"Stage 3","start":"2024-01-06T04:00:00+02:00"},{"end":"2024-01-06T22:30:00+02:00","note":"Stage 3","start":"2024-01-06T20:00:00+02:00"},{"end":"2024-01-07T05:00:00+02:00","note":"Stage 3","start":"2024-01-07T04:00:00+02:00"}],"info":{"name":"Doornpoort (16)","region":"City of Tshwane"},"schedule":{"days":[{"date":"2024-01-05","name":"Friday","stages":[[],["20:00-22:30"],["12:00-14:30","20:00-22:30"],["04:00-06:30","12:00-14:30","20:00-22:30"],["00:00-02:30","04:00-06:30","12:00-14:30","20:00-22:30"],["00:00-02:30","04:00-06:30","12:00-14:30","20:00-00:30"],["00:00-02:30","04:00-06:30","12:00-16:30","20:00-00:30"],["00:00-02:30","04:00-08:30","12:00-16:30","20:00-00:30"]]},{"date":"2024-01-06","name":"Saturday","stages":[["04:00-06:30"],["04:00-06:30"],["04:00-06:30","20:00-22:30"],["04:00-06:30","12:00-14:30","20:00-22:30"],["04:00-08:30","12:00-14:30","20:00-22:30"],["04:00-08:30","12:00-14:30","20:00-22:30"],["04:00-08:30","12:00-14:30","20:00-00:30"],["04:00-08:30","12:00-16:30","20:00-00:30"]]},{"date":"2024-01-07","name":"Sunday","stages":[["12:00-14:30"],["04:00-06:30","12:00-14:30"],["04:00-06:30","12:00-14:30"],["04:00-06:30","12:00-14:30","20:00-22:30"],["04:00-06:30","12:00-16:30","20:00-22:30"],["04:00-08:30","12:00-16:30","20:00-22:30"],["04:00-08:30","12:00-16:30","20:00-22:30"],["04:00-08:30","12:00-16:30","20:00-00:30"]]},{"date":"2024-01-08","name":"Monday","stages":[["20:00-22:30"],["12:00-14:30","20:00-22:30"],["04:00-06:30","12:00-14:30","20:00-22:30"],["04:00-06:30","12:00-14:30","20:00-22:30"],["04:00-06:30","12:00-14:30","20:00-00:30"],["04:00-06:30","12:00-16:30","20:00-00:30"],["04:00-08:30","12:00-16:30","20:00-00:30"],["04:00-08:30","12:00-16:30","20:00-00:30"]]},{"date":"2024-01-09","name":"Tuesday","stages":[[],["18:00-20:30"],["10:00-12:30","18:00-20:30"],["02:00-04:30","10:00-12:30","18:00-20:30"],["02:00-04:30","10:00-12:30","18:00-20:30"],["02:00-04:30","10:00-12:30","18:00-22:30"],["02:00-04:30","10:00-14:30","18:00-22:30"],["02:00-06:30","10:00-14:30","18:00-22:30"]]},{"date":"2024-01-10","name":"Wednesday","stages":[["02:00-04:30"],["02:00-04:30"],["02:00-04:30","18:00-20:30"],["02:00-04:30","10:00-12:30","18:00-20:30"],["02:00-06:30","10:00-12:30","18:00-20:30"],["02:00-06:30","10:00-12:30","18:00-20:30"],["02:00-06:30","10:00-12:30","18:00-22:30"],["02:00-06:30","10:00-14:30","18:00-22:30"]]},{"date":"2024-01-11","name":"Thursday","stages":[["10:00-12:30"],["02:00-04:30","10:00-12:30"],["02:00-04:30","10:00-12:30"],["02:00-04:30","10:00-12:30","18:00-20:30"],["02:00-04:30","10:00-14:30","18:00-20:30"],["02:00-06:30","10:00-14:30","18:00-20:30"],["02:00-06:30","10:00-14:30","18:00-20:30"],["02:00-06:30","10:00-14:30","18:00-22:30"]]}],"source":"http://www.tshwane.gov.za/sites/Departments/Public-works-and-infrastructure/Pages/Load-Shedding.aspx"}}'
#echo "$lsMyArea" > ls_myarea.json



ESPQuota=$(jq -r '.allowance.count' espquota.json) 
ESPQuotaLimit=$(jq -r '.allowance.limit' espquota.json) 
ESPStage=$(jq -r '.status.eskom.stage' ls_stage.json) 
#ESPStage="2" #DELME in FUTURE and Un comment above



echo "Your quota is:" $ESPQuota "of" $ESPQuotaLimit "requests."
echo "Current loadshedding stage is:" $ESPStage

JSONESPStage=$(($ESPStage-1))

if [ $ESPStage == "0" ]
then 
	ESPStage="No Loadshedding" 
fi




LoadSheddingDate=$(jq -r '.schedule.days[0].date' ls_myarea.json)
echo "Updating the following loadshedding entity..."
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Current Loadshedding Stage"}, "state": "'"$ESPStage"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_currentstage | jq -r '.entity_id'


TodayScheduleSlot1=$(jq -r '.schedule.days[0].stages['$JSONESPStage'][0]' ls_myarea.json)
TodayScheduleSlot2=$(jq -r '.schedule.days[0].stages['$JSONESPStage'][1]' ls_myarea.json)
TodayScheduleSlot3=$(jq -r '.schedule.days[0].stages['$JSONESPStage'][2]' ls_myarea.json)
TodayScheduleSlot4=$(jq -r '.schedule.days[0].stages['$JSONESPStage'][3]' ls_myarea.json)
TodayScheduleSlot5=$(jq -r '.schedule.days[0].stages['$JSONESPStage'][4]' ls_myarea.json)

echo "Schedule for" $LoadSheddingDate "-" $YOUR_AREAD_ID


TodayScheduleSlot1From=$(cut -c 1-5 <<< $TodayScheduleSlot1)
TodayScheduleSlot1To=$(cut -c 7-12 <<< $TodayScheduleSlot1)
TodayScheduleSlot2From=$(cut -c 1-5 <<< $TodayScheduleSlot2)
TodayScheduleSlot2To=$(cut -c 7-12 <<< $TodayScheduleSlot2)
TodayScheduleSlot3From=$(cut -c 1-5 <<< $TodayScheduleSlot3)
TodayScheduleSlot3To=$(cut -c 7-12 <<< $TodayScheduleSlot3)
TodayScheduleSlot4From=$(cut -c 1-5 <<< $TodayScheduleSlot4)
TodayScheduleSlot4To=$(cut -c 7-12 <<< $TodayScheduleSlot4)
TodayScheduleSlot5From=$(cut -c 1-5 <<< $TodayScheduleSlot5)
TodayScheduleSlot5To=$(cut -c 7-12 <<< $TodayScheduleSlot5)
echo "Slot 1:" $TodayScheduleSlot1From"-"$TodayScheduleSlot1To
echo "Slot 2:" $TodayScheduleSlot2From"-"$TodayScheduleSlot2To
echo "Slot 3:" $TodayScheduleSlot3From"-"$TodayScheduleSlot3To
echo "Slot 4:" $TodayScheduleSlot4From"-"$TodayScheduleSlot4To
echo "Slot 5:" $TodayScheduleSlot5From"-"$TodayScheduleSlot5To

echo "Posting the following entities to homeassistant URL: " $HTTP_Connect_Type"://"$Home_Assistant_IP":"$Home_Assistant_PORT
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 1 From Time"}, "state": "'"$TodayScheduleSlot1From"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot1_from | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 1 To Time"}, "state": "'"$TodayScheduleSlot1To"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot1_to | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 2 From Time"}, "state": "'"$TodayScheduleSlot2From"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot2_from | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 2 To Time"}, "state": "'"$TodayScheduleSlot2To"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot2_to | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 3 From Time"}, "state": "'"$TodayScheduleSlot3From"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot3_from | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 3 To Time"}, "state": "'"$TodayScheduleSlot3To"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot3_to | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 4 From Time"}, "state": "'"$TodayScheduleSlot4From"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot4_from | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 4 To Time"}, "state": "'"$TodayScheduleSlot4To"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot4_to | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 5 From Time"}, "state": "'"$TodayScheduleSlot5From"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot5_from | jq -r '.entity_id'
curl -s -X POST -H "Authorization: Bearer $HA_LongLiveToken" -H "Content-Type: application/json" -d '{"attributes": {"device_class": "time", "state_class":"measurement", "unit_of_measurement": "", "friendly_name": "ESP4HA Today Loadshedding Slot 5 To Time"}, "state": "'"$TodayScheduleSlot5To"'"}' $HTTP_Connect_Type://$Home_Assistant_IP:$Home_Assistant_PORT/api/states/sensor.espforha_area1_lstodayslot5_to | jq -r '.entity_id'


rm -rf *.json
echo "All Done! Waiting " $Refresh_rate " sesonds to rinse and repeat."
sleep $Refresh_rate
done