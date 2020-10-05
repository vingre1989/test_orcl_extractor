FROM ubuntu@sha256:2e70e9c81838224b5311970dbf7ed16802fbfe19e7a70b3cbfa3d7522aa285b4
##### User ENV
ENV DBUSERNAME=
ENV DBPASSWORD=
ENV DBCONNECTIONSTRING=
#DBADMINTYPE must be SYSDBA, SYSOPER, or NONADMIN
ENV DBADMINTYPE=
ENV DBTYPE=ORACLE
ENV DBMAXCONNECTIONS=25


RUN mkdir /usr/lib/instantclient_12_1
COPY instantclient_12_1 /usr/lib/instantclient_12_1
RUN apt update && \
    apt install libaio1 && \
    ln /usr/lib/instantclient_12_1/libclntsh.so.12.1 /usr/lib/libclntsh.so && \
    ln /usr/lib/instantclient_12_1/libocci.so.12.1 /usr/lib/libocci.so && \
    ln /usr/lib/instantclient_12_1/libociei.so /usr/lib/libociei.so && \
    ln /usr/lib/instantclient_12_1/libnnz12.so /usr/lib/libnnz12.so

ENV ORACLE_BASE /usr/lib/instantclient_12_1
ENV LD_LIBRARY_PATH /usr/lib/instantclient_12_1
ENV TNS_ADMIN /usr/lib/instantclient_12_1
ENV ORACLE_HOME /usr/lib/instantclient_12_1

COPY testprog /usr/bin
