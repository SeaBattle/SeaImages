#!/bin/sh
USERNAME="sailor"
DATABASE="seabattle"
CLASSPATH=postgresql-9.4.1212.jar
PASSWORD="sea_wind_arrr"
CHANGELOG=db.changelog-master.xml

if [[ -z "$DB_URL" ]]
then
    URL="jdbc:postgresql://localhost/"$DATABASE
else
    URL=$DB_URL
fi

case ${1} in
   "update")
        liquibase --driver=org.postgresql.Driver \
        --url=$URL \
        --changeLogFile=$CHANGELOG \
        --classpath=$CLASSPATH \
        --username=$USERNAME \
        --password=$PASSWORD update
   ;;
   "roll")
        liquibase --driver=org.postgresql.Driver \
        --url=$URL \
        --classpath=$CLASSPATH \
        --username=$USERNAME \
        --password=$PASSWORD \
        --changeLogFile=$CHANGELOG \
        rollback ${2}
   ;;
   "tag")
        liquibase --driver=org.postgresql.Driver \
         --url=$URL \
         --classpath=$CLASSPATH \
         --username=$USERNAME \
         --password=$PASSWORD \
         --changeLogFile=$CHANGELOG tag ${2}
   ;;
   *) echo "`basename ${0}`:usage: [update] | [roll name] | [tag name]"
      exit 1
      ;;
esac
