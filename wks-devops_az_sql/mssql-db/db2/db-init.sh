#wait for the SQL Server to come up
sleep 35s


# Wait 60 seconds for SQL Server to start up by ensuring that 
# calling SQLCMD does not return an error code, which will ensure that sqlcmd is accessible
# and that system and user databases return "0" which means all databases are in an "online" state
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017 
# https://github.com/microsoft/mssql-docker/blob/master/linux/preview/examples/mssql-customize/configure-db.sh

# DBSTATUS=1
# ERRCODE=1
# i=0

# while [[ $DBSTATUS -ne 0 ]] && [[ $i -lt 60 ]] && [[ $ERRCODE -ne 0 ]]; do
# 	i=$i+1
# 	DBSTATUS=$(/opt/mssql-tools/bin/sqlcmd -h -1 -t 1 -U sa -P $SA_PASSWORD -Q "SET NOCOUNT ON; Select SUM(state) from sys.databases")
# 	ERRCODE=$?
# 	sleep 1
# done

# if [ $DBSTATUS -ne 0 ] OR [ $ERRCODE -ne 0 ]; then 
# 	echo "SQL Server took more than 60 seconds to start up or one or more databases are not in an ONLINE state"
# 	exit 1
# fi

#run the setup script to create the DB and the schema in the DB
#/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P safePASSWORD123 -d master -i db-init.sql
#use a Dacpac file 
#/tmp/sqlpackage/sqlpackage /a:Publish /tsn:localhost /tdn:pitchoun-sql-dev /tu:SA /tp:safePASSWORD123 /sf:/tmp/db/database.dacpac 
/tmp/sqlpackage/sqlpackage /a:Publish /tsn:localhost /tdn:DbNameToReplace /tu:SA /tp:PwdToReplace /sf:/tmp/db/database.dacpac 

#use a bacpac file 
#/tmp/sqlpackage/sqlpackage /a:Import /tsn:localhost /tdn:Database /tu:SA /tp:safePASSWORD123 /sf:/tmp/db/database.bacpac 