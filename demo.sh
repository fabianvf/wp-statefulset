set -x
oc login --insecure-skip-tls-verify=true `sudo $(which minishift) ip`:8443 -u admin -p admin
oc new-project wp-demo-$RANDOM
oc create -f volumes.yml
oc get pv | awk '{print $1 " " $2 " " $5 " " $6}'  | column -t
oc get pvc | awk '{print $1" " $2" " $3}' | column -t
oc create -f etcd.yml
oc get pods
oc create -f mysql.yml
oc get pods
oc create -f wordpress.yml
