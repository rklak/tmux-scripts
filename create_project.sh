#!/usr/bin/env bash

keycloak_host="host.docker.internal:8090"
api_host="localhost:1337"
app_host="localhost:3000"

# Define adjectives and nouns as strings separated by newline characters
adjectives="Red\nBlue\nGreen\nYellow\nOrange\nPurple\nPink\nBlack\nWhite"
nouns="Lion\nTiger\nElephant\nMonkey\nBear\nWolf\nFox\nRabbit\nSnake"

# Concatenate adjectives and nouns, then shuffle the list
names=$(printf "$adjectives$nouns" | shuf)

# Select the first adjective and noun from the shuffled list
random_name=$(echo "$names" | head -n 2 | tr -d '\n')

current_date=$(date +%Y-%m-%d)
tommorow_date=$(date -d "tomorrow" +%Y-%m-%d)


# Calls start
echo "Get token"
token=$(curl --request POST --data 'username=superadmin&password=superadmin&grant_type=password&client_id=rad-security-public' -s http://host.docker.internal:8090/auth/realms/rad-security-auth/protocol/openid-connect/token | jq -r .access_token)

echo "Create client $random_name"
client_id=$(curl -s "http://$api_host/api/clients" \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H "Authorization: Bearer $token" \
  --data-raw "{\"name\":\"$random_name\",\"industries\":[\"Advertising\"],\"country\":\"Afghanistan\",\"accountNumber\":\"32451\"}" \
  -H 'Content-Type: application/json' | jq -r .clientId)

echo "Create lead 'Project Iceberg $random_name'"
lead_id=$(curl -s "http://$api_host/api/projects/create-lead" \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H "Authorization: Bearer $token" \
  --data-raw "{\"name\":\"Project Iceberg $random_name\",\"description\":\"Iceberg make it easy to work in worldwide development team\",\"attributes\":[\"Greenfield\",\"Existing code\"],\"startDate\":\"$tommorow_date\",\"currency\":\"EUR\",\"tags\":[\"worldwide\"],\"category\":\"A\",\"rateCard\":{\"items\":[{\"specialization\":\"PM\",\"seniority\":\"JUNIOR\",\"amount\":500},{\"specialization\":\"PM\",\"seniority\":\"MID\",\"amount\":1000},{\"specialization\":\"PM\",\"seniority\":\"SENIOR\",\"amount\":1500},{\"specialization\":\"DevOps\",\"seniority\":\"SENNA\",\"amount\":1000}],\"currency\":\"EUR\",\"appliesFrom\":\"$current_date\"},\"clientId\":\"$client_id\"}" \
  -H 'Content-Type: application/json' | jq -r .leadId)

people=$(curl -s "http://$api_host/api/people?page=1&sort\[name\]=ASC&availability_status\[\]=AVAILABLE&availability_status\[\]=AVAILABLE_SOON&include_unemployed=false&non_dev_roles=false&limit=50" \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H "Authorization: Bearer $token" \
  --compressed)


first_person=$(echo "$people" | jq -r '.people[0].employeeId')
second_person=$(echo "$people" | jq -r '.people[1].employeeId')

echo "Assing person with id $first_person"
assign_first_person=$(curl -s "http://$api_host/api/projects/$lead_id/assign-person" \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H "Authorization: Bearer $token" \
  --data-raw "{\"assignment\":{\"personId\":$first_person,\"fte\":40,\"startDate\":\"$tommorow_date\",\"endDate\":null,\"role\":\"PM\",\"seniority\":\"JUNIOR\"},\"force\":true,\"temporary\":false}" \
  -H 'Content-Type: application/json' \
  --compressed)

echo "Assing person with id $second_person"
assign_person=$(curl -s "http://$api_host/api/projects/$lead_id/assign-person" \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H "Authorization: Bearer $token" \
  --data-raw "{\"assignment\":{\"personId\":$second_person,\"fte\":40,\"startDate\":\"$tommorow_date\",\"endDate\":null,\"role\":\"PM\",\"seniority\":\"JUNIOR\"},\"force\":true,\"temporary\":false}" \
  -H 'Content-Type: application/json' \
  --compressed)

echo "Start a project $random_name"
start=$(curl -s "http://$api_host/api/projects/$lead_id/start" \
  -H 'Accept: application/json, text/plain, */*' \
  -X 'PATCH' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: application/json' \
  --data-raw "{\"startDate\":\"$current_date\"}")

echo "Go to project page: http://$app_host/projects/$lead_id/overview"

