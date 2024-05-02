MYSQL COMANDS

Create a data base if not exist : 

    mysql $> USE db_name

Drope or romve a data base : 

    DROP DATABASE IF EXISTS db_name;

show all data base on the server :
    SHOW DATABASES;

show tables :https://www.youtube.com/watch?v=e62RicDmjcY
    SHOW TABLES;

    /*************************************/
    CREAT USER  IF NOT EXIST 'canis'@'%' IDENTIFYED BY 'canis'

GRANT ALL PRIVILEGES ON *.* TO 'canis'@'%';\

#update the root password 

UPDATE mysql.user SET authentication_string=PASSWORD('lol@ok') WHERE User='root';

FLUSH PRIVILEGES;
    /*************************************/
