# Apache Beeline client with Apache Hive

* Prerequisites
  * A Hadoop cluster on HDInsight.
  * URI scheme for your cluster's primary storage
  * An SSH client
* Run a Hive query
  * Open an SSH connection to the cluster with the code below. Replace sshuser with the SSH user for your cluster, and replace CLUSTERNAME with the name of your cluster. When prompted, enter the password for the SSH user account.
    * ssh sshuser@CLUSTERNAME-ssh.azurehdinsight.net
  * Connect to HiveServer2 with your Beeline client from your open SSH session by entering the following command:
    * beeline -u 'jdbc:hive2://headnodehost:10001/;transportMode=http'
  * Beeline commands begin with a ! character, for example !help displays help. However the ! can be omitted for some commands. For example, help also works.
  * There's !sql, which is used to execute HiveQL statements. However, HiveQL is so commonly used that you can omit the preceding !sql. The following two statements are equivalent:
    * !sql show tables;
    * show tables;
  * Use the following command to display the schema for the hivesampletable:
    * describe hivesampletable;
  * Enter the following statements to create a table named log4jLogs by using sample data provided with the HDInsight cluster:
    * DROP TABLE log4jLogs;
      CREATE EXTERNAL TABLE log4jLogs (
      t1 string,
      t2 string,
      t3 string,
      t4 string,
      t5 string,
      t6 string,
      t7 string)
      ROW FORMAT DELIMITED FIELDS TERMINATED BY ' '
      STORED AS TEXTFILE LOCATION 'wasbs:///example/data/';
      SELECT t4 AS sev, COUNT(*) AS count FROM log4jLogs
      WHERE t4 = '[ERROR]' AND INPUT__FILE__NAME LIKE '%.log'
      GROUP BY t4;
  * Exit Beeline
    * !exit

* Run a HiveQL file
  * Use the following command to create a file named query.hql:
    * nano query.hql
  * Use the following text as the contents of the file. This query creates a new 'internal' table named errorLogs:
    * CREATE TABLE IF NOT EXISTS errorLogs (t1 string, t2 string, t3 string, t4 string, t5 string, t6 string, t7 string) STORED AS ORC;
INSERT OVERWRITE TABLE errorLogs SELECT t1, t2, t3, t4, t5, t6, t7 FROM log4jLogs WHERE t4 = '[ERROR]' AND INPUT__FILE__NAME LIKE '%.log';
  * To save the file, use Ctrl+X, then enter Y, and finally Enter.
  * Use the following to run the file using Beeline
    * beeline -u 'jdbc:hive2://headnodehost:10001/;transportMode=http' -i query.hql
  * To verify that the errorLogs table was created, use the following statement to return all the rows from errorLogs
    * SELECT * from errorLogs;



