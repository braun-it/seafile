    #!/bin/bash

    NOW=date +%d.%m.%Y

    #looking for 7 days old database backups and delete them
    find /mnt/storagebox/seafile/database -maxdepth 1 -mtime +7 -type f -delete

    #stop seafile
    systemctl stop seafile.service

    #create a full backup of complete seafile files
    rsync -az --delete --exclude 'ccnet.sock' /home/seafile/ /mnt/storagebox/seafile/files/

    mysqldump -h localhost -u root -p<<password>> ccnet-db > /mnt/storagebox/seafile/database/sqlbkp-$NOW-ccnet.sql
    mysqldump -h localhost -u root -p<<password>> seafile-db > /mnt/storagebox/seafile/database/sqlbkp-$NOW-seafile.sql
    mysqldump -h localhost -u root -p<<password>> seahub-db > /mnt/storagebox/seafile/database/sqlbkp-$NOW-seahub.sql

    #start seafile
    systemctl start seafile.service
