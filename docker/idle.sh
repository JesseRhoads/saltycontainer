#!/bin/bash                                                                
# Parts from  https://gist.github.com/ikbear/56b28f5ecaed76ebb0ca                                                                           

# Starting salt from Dockerfile doesn't persist, and upstart/init don't appear to work well in docker, so we start the service here in the CMD script.
/usr/bin/service salt-minion start

echo "Container is now running."

# output the host name if running interactively
hostname -f
                                                                           
cleanup ()                                                                 
{                                                                          
  kill -s SIGTERM $!                                                         
  exit 0                                                                     
}                                                                          
                                                                           
trap cleanup SIGINT SIGTERM                                                
                                                                           
while [ 1 ]                                                                
do                                                                         
  sleep 60 &                                                             
  wait $!                                                                
done
