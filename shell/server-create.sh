#!/bin/bash




if [ "$1" = ""] | [ "$2" = ""] ; then
    echo -e "\e[31m \n Valid options are component -name or all and env \e[0m \n \e[33m Ex: \n\t bash create-server.sh payment dev \n \e[0m "
    exit 1
fi 

#AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=devops" | jq '.Images[].ImageId' | sed -e 's/"//g')
AMI_ID="ami-0db68915b3e8a3ce3"

COMPONENT=$1
ENV=$2
SGID="sg-03ec6d3f23f96aefd"
echo $AMI_ID
#SERVER_CREATE(){
#    PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID  --instance-type t3.micro  --security-group-ids $SGID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g') 
#    echo $PRIVATE_IP


    ##ip creation
#    sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}/" route53.json > /tmp/record.json
#    aws route53 change-resource-record-sets --hosted-zone-id Z05313022PGNHL8COSD1E --change-batch file:///tmp/record.json | jq


#}

create_server() {
    echo "$COMPONENT Server Creation in progress"
    PRIVATE_IP=$(aws ec2 run-instances --security-group-ids $SGID --image-id  $AMI_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

    # # Changing the IP Address and DNS Name as per the component
    sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}-${ENV}/" route53.json > /tmp/record.json 
    aws route53 change-resource-record-sets --hosted-zone-id Z05313022PGNHL8COSD1E --change-batch file:///tmp/record.json | jq 
}






if [ "$1" == "all" ] ; then
    for component in catalogue cart user shipping payment frontend mongodb mysql rabbitmq redis ; do
        COMPONENT=$component
        create_server
    done
else
    create_server
fi
