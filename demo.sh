set -x
oc login --insecure-skip-tls-verify=true `sudo $(which minishift) ip`:8443 -u admin -p admin
permissions_set=`oc get clusterrole system:hpa-controller -o yaml | grep replicasets`
if [[ -z "$permissions_set" ]]
then
  { oc get clusterrole system:hpa-controller -o yaml ; echo '- {apiGroups: [extensions], attributeRestrictions: null,  resources: [replicasets/scale], verbs: [get,update]}'; }  | oc replace -f -
fi
ansible-playbook provision.yaml -e "project_name=wordpress-ha-demo-$RANDOM"
