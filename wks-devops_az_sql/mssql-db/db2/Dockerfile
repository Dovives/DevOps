FROM mcr.microsoft.com/mssql/server:2019-latest

ARG PASSWORD
ARG DBNAME
ARG MPID 

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=${PASSWORD}
ENV MSSQL_AGENT_ENABLED=true
#ENV MSSQL_PID=$(MPID)


USER root
RUN apt-get update && apt-get install unzip -y

# SqlPackage taken from https://github.com/Microsoft/mssql-docker/issues/135#issuecomment-389245587 https://go.microsoft.com/fwlink/?linkid=2143497 old: https://go.microsoft.com/fwlink/?linkid=873926
RUN wget -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=873926 \
    && unzip sqlpackage.zip -d /tmp/sqlpackage \
    && chmod +x /tmp/sqlpackage/sqlpackage

COPY ./mssql-db/db2/rewardsdb.dacpac /tmp/db/database.dacpac 

#COPY ./mssql-db/docker/db-init.sql /db-init.sql
COPY ./mssql-db/db2/db-init.sh /db-init.sh
COPY ./mssql-db/db2/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /db-init.sh
#RUN chmod +x /db-init.sql


#Debug 
#RUN echo "Will replace DB Name by : ${DBNAME} or ${PASSWORD}"

RUN   sed -i "s|PwdToReplace|${PASSWORD} |g" /db-init.sh
RUN   sed -i "s|DbNameToReplace|${DBNAME} |g" /db-init.sh

#https://stackoverflow.com/questions/32727594/how-to-pass-arguments-to-shell-script-through-docker-run/32728266
ENTRYPOINT ["/bin/bash"]
CMD ["./entrypoint.sh"]

# CMD /bin/bash ./entrypoint.sh


# grep command to check if SQL server is already started taken from https://stackoverflow.com/a/51589787/488695 https://stackoverflow.com/questions/46888045/docker-mssql-server-linux-how-to-launch-sql-file-during-build-from-dockerfi/51589787#51589787
# RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" \
#     && /tmp/sqlpackage/sqlpackage /a:Import /tsn:localhost,1433 /tdn:Database /tu:sa /tp:yourStrong(!)Password /sf:/tmp/db/database.bacpac \
#     && pkill sqlservr \
#     && rm /tmp/db/database.bacpac