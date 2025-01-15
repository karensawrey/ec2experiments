#!/bin/bash
# Buildkite Elastic CI Stack Bootstrap Script that will greet the user based on their region

get_aws_region() {
    # Using instance metadata as we're in an EC2 insatnce anyway - yay to the magicIP
    curl -s http://169.254.169.254/latest/meta-data/placement/region
}

get_city_name() {
    local region=$1
    case $region in
        us-east-1)
            echo "Northern Virginia"
            ;;
        us-east-2)
            echo "Ohio"
            ;;
        us-west-1)
            echo "Northern California"
            ;;
        us-west-2)
            echo "Oregon"
            ;;
        af-south-1)
            echo "Cape Town"
            ;;
        ap-east-1)
            echo "Hong Kong"
            ;;
        ap-south-1)
            echo "Mumbai"
            ;;
        ap-northeast-1)
            echo "Tokyo"
            ;;
        ap-northeast-2)
            echo "Seoul"
            ;;
        ap-northeast-3)
            echo "Osaka"
            ;;
        ap-southeast-1)
            echo "Singapore"
            ;;
        ap-southeast-2)
            echo "Sydney"
            ;;
        ca-central-1)
            echo "Montreal"
            ;;
        eu-central-1)
            echo "Frankfurt"
            ;;
        eu-west-1)
            echo "Ireland"
            ;;
        eu-west-2)
            echo "London"
            ;;
        eu-west-3)
            echo "Paris"
            ;;
        eu-north-1)
            echo "Stockholm"
            ;;
        eu-south-1)
            echo "Milan"
            ;;
        me-south-1)
            echo "Bahrain"
            ;;
        sa-east-1)
            echo "São Paulo"
            ;;
        *)
            echo "Unknown Location"
            ;;
    esac
}

# Let's ruuuuuun! 
region=$(get_aws_region)
city=$(get_city_name "$region")
echo "Hello from $city! (AWS Region: $region)"
