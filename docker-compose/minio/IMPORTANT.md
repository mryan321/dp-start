## IMPORTANT! ##

### Do not delete the `data` directory! ###
This directory has special permissions
properties to allow minio to read and write to it. If you do need to
recreate it, make sure to change ownership to user 1001:1001

    sudo chown -R 1001:1001 data

Note that these permissions settings mean you will need to use super-user
privileges to directly edit files in this directory
