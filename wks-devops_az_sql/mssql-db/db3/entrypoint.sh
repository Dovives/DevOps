#start SQL Server, start the script to create/setup the DB
#You need a non-terminating process to keep the container alive. 
#In a series of commands separated by single ampersands the commands to the left of the right-most ampersand are run in the background. 
#So - if you are executing a series of commands simultaneously using single ampersands, the command at the right-most position needs to be non-terminating
 /db-init.sh & /opt/mssql/bin/sqlservr


#another way could be as explain here : https://github.com/twright-msft/mssql-node-docker-demo-app 
#start SQL Server, start the script to create the DB and import the data, start the app
#/opt/mssql/bin/sqlservr & /usr/src/app/import-data.sh

#import-data.sh 
#wait for the SQL Server to come up
#sleep 90s

#run the setup script to create the DB and the schema in the DB
#/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Yukon900 -d master -i setup.sql

#import the data from the csv file
#/opt/mssql-tools/bin/bcp DemoData.dbo.Products in "/usr/src/app/Products.csv" -c -t',' -S localhost -U sa -P Yukon900

#RUN /opt/mssql/bin/sqlserver.sh & sleep 20 \
#&& /opt/mssql/bin/sqlpackage /Action:Publish /TargetServerName:localhost /TargetUser:SA /TargetPassword:$SA_PASSWORD /SourceFile:/scripts/dacpac/MyDB.dacpac /Profile:/scripts/dacpac/MyDB.publish.xml /p:BlockOnPossibleDataLoss=false \
#&& sleep 20 \
#&& /opt/mssql/bin/sqlservr