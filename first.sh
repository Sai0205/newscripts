#!/bin/bash




echo "deepak"
echo "suresh"
echo "suneel"


person1=deepak
person2=suresh
person3=suneel

echo "$person1 ,$person2 ,$person3 are intellegent "

#assigning the linux command soutput to the variable using $()
DATE=$(date)

echo "todays date is $DATE"

echo


#aasining commmand line inputs as variables 

person1=$1
person2=$2

echo "$person1 and $person2 are friends"


#arithematic operations hould only be done in $(())

p1=$3
p2=$4

sum=$((p1+p2))
echo "$sum"