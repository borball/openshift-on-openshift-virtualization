```
# ./install-mno.sh vacm1
Will use /root/github/openshift-on-openshift-virtualization/mno-with-abi/instances/vacm1/config-resolved.yaml as the configuration in other mno-* scripts.
Container runtime crun(4.18+):                         default
Local Storage Operator                                 enabled
Red Hat Advanced Cluster Management for Kubernetes     enabled
Topology Aware Lifecycle Manager                       enabled
OpenShift Data Foundation                              enabled
Red Hat OpenShift GitOps                               enabled
Copy customized CRs from extra-manifests folder if present

Generating boot image...

INFO Configuration has 3 master replicas and 0 worker replicas
INFO The rendezvous host IP (node0 IP) is 192.168.58.51
INFO Extracting base ISO from release payload
INFO Verifying cached file
INFO Using cached Base ISO /root/.cache/agent/image_cache/coreos-x86_64.iso
INFO Consuming Extra Manifests from target directory
INFO Consuming Agent Config from target directory
INFO Consuming Install Config from target directory
INFO Generated ISO at /root/github/openshift-on-openshift-virtualization/mno-with-abi/instances/vacm1/agent.x86_64.iso.

------------------------------------------------
kubeconfig: /root/github/openshift-on-openshift-virtualization/mno-with-abi/instances/vacm1/auth/kubeconfig.
kubeadmin password: /root/github/openshift-on-openshift-virtualization/mno-with-abi/instances/vacm1/auth/kubeadmin-password.
------------------------------------------------

Next step: Go to your BMC console and boot the node from ISO: /root/github/openshift-on-openshift-virtualization/mno-with-abi/instances/vacm1/agent.x86_64.iso.
You can also run ./mno-install.sh to boot the node from the image automatically if you have a HTTP server serves the image.
Enjoy!
ISO created and copied to /var/www/html/iso/vacm1.iso, which is served by the web server http://192.168.58.15/iso

Creating the VMs...
namespace/vacm1 unchanged
networkattachmentdefinition.k8s.cni.cncf.io/localnet-network unchanged
virtualmachine.kubevirt.io/master1 created
virtualmachine.kubevirt.io/master2 created
virtualmachine.kubevirt.io/master3 created

Waiting for all the VMs being ready...
datavolume.cdi.kubevirt.io/master1-cdrom phase null is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master1-cdrom DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master1-data phase null is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master1-data DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master1-rootdisk phase ImportScheduled is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master1-rootdisk DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master2-cdrom phase ImportInProgress is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master2-cdrom DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master3-cdrom phase ImportInProgress is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master3-cdrom DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master3-data phase ImportInProgress is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master3-data DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master3-rootdisk phase ImportInProgress is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master3-rootdisk DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master1-cdrom phase ImportScheduled is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master1-cdrom DataVolume to be and succeed...
datavolume.cdi.kubevirt.io/master1-rootdisk phase ImportInProgress is not Succeeded yet; Waiting for the datavolume.cdi.kubevirt.io/master1-rootdisk DataVolume to be and succeed...
All the VMs are ready to power on.
Powering on the VMs to start the installation.
VM master1 was scheduled to start
VM master2 was scheduled to start
VM master3 was scheduled to start

Monitoring the installation...
Fetching the API token...
API token: eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoX3NjaGVtZSI6InVzZXJBdXRoIn0.LNP5CCoZJNWUh5CQyDQNHg9xDETRiqo8mCUApngiuyvlwNl0ocgwzQJDZlenp0FvV7qNx2MHmnYUZc9iJBWz4w

Fetching the Assisted REST URL...
Assisted REST URL: http://192.168.58.51:8090/api/assisted-install/v2/clusters

.......
Installing in progress...
-------------------------------
{"enabled_host_count":2,"name":"vacm1","status":"insufficient","status_info":"Cluster is not ready for install","status_updated_at":"2025-08-14T15:51:26.907Z","total_host_count":2,"updated_at":"2025-08-14T15:51:28.561116Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"failure","message":"The cluster has hosts that are not ready to install."},{"status":"failure","message":"The cluster must have exactly 3 dedicated control plane nodes. Add or remove hosts, or change their roles configurations to meet the requirement."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"failure","message":"api vips <192.168.58.50> are not verified yet.;api vips <2600:52:7:58::50> are not verified yet."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"failure","message":"ingress vips <192.168.58.54> are not verified yet.;ingress vips <2600:52:7:58::54> are not verified yet."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"insufficient","status_info":"Cluster is not ready for install","status_updated_at":"2025-08-14T15:51:26.907Z","total_host_count":3,"updated_at":"2025-08-14T15:51:35.629246Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"failure","message":"The cluster has hosts that are not ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"failure","message":"api vips <192.168.58.50> are not verified yet.;api vips <2600:52:7:58::50> are not verified yet."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"failure","message":"ingress vips <192.168.58.54> are not verified yet.;ingress vips <2600:52:7:58::54> are not verified yet."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"insufficient","status_info":"Cluster is not ready for install","status_updated_at":"2025-08-14T15:51:26.907Z","total_host_count":3,"updated_at":"2025-08-14T15:51:35.629246Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"failure","message":"The cluster has hosts that are not ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"failure","message":"api vips <192.168.58.50> are not verified yet.;api vips <2600:52:7:58::50> are not verified yet."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"failure","message":"ingress vips <192.168.58.54> are not verified yet.;ingress vips <2600:52:7:58::54> are not verified yet."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"insufficient","status_info":"Cluster is not ready for install","status_updated_at":"2025-08-14T15:51:26.907Z","total_host_count":3,"updated_at":"2025-08-14T15:51:35.629246Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"failure","message":"The cluster has hosts that are not ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"failure","message":"api vips <192.168.58.50> are not verified yet.;api vips <2600:52:7:58::50> are not verified yet."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"failure","message":"ingress vips <192.168.58.54> are not verified yet.;ingress vips <2600:52:7:58::54> are not verified yet."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"insufficient","status_info":"Cluster is not ready for install","status_updated_at":"2025-08-14T15:51:26.907Z","total_host_count":3,"updated_at":"2025-08-14T15:51:35.629246Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"failure","message":"The cluster has hosts that are not ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"failure","message":"api vips <192.168.58.50> are not verified yet.;api vips <2600:52:7:58::50> are not verified yet."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"failure","message":"ingress vips <192.168.58.54> are not verified yet.;ingress vips <2600:52:7:58::54> are not verified yet."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"insufficient","status_info":"Cluster is not ready for install","status_updated_at":"2025-08-14T15:51:26.907Z","total_host_count":3,"updated_at":"2025-08-14T15:52:41.064383Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"failure","message":"The cluster has hosts that are not ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","ready_host_count":3,"status":"insufficient","status_info":"Cluster is not ready for install","status_updated_at":"2025-08-14T15:51:26.907Z","total_host_count":3,"updated_at":"2025-08-14T15:52:51.062081Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"failure","message":"The cluster has hosts that are not ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"preparing-for-installation","status_info":"Preparing cluster for installation","status_updated_at":"2025-08-14T15:53:10.867Z","total_host_count":3,"updated_at":"2025-08-14T15:53:10.86783Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"success","message":"All hosts in the cluster are ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"preparing-for-installation","status_info":"Preparing cluster for installation","status_updated_at":"2025-08-14T15:53:10.867Z","total_host_count":3,"updated_at":"2025-08-14T15:53:28.718889Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"success","message":"All hosts in the cluster are ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"preparing-for-installation","status_info":"Preparing cluster for installation","status_updated_at":"2025-08-14T15:53:10.867Z","total_host_count":3,"updated_at":"2025-08-14T15:53:28.718889Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"success","message":"All hosts in the cluster are ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"preparing-for-installation","status_info":"Preparing cluster for installation","status_updated_at":"2025-08-14T15:53:10.867Z","total_host_count":3,"updated_at":"2025-08-14T15:53:28.718889Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"success","message":"All hosts in the cluster are ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"preparing-for-installation","status_info":"Preparing cluster for installation","status_updated_at":"2025-08-14T15:53:10.867Z","total_host_count":3,"updated_at":"2025-08-14T15:53:28.718889Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"success","message":"All hosts in the cluster are ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}
-------------------------------
{"enabled_host_count":3,"name":"vacm1","status":"installing","status_info":"Installation in progress","status_updated_at":"2025-08-14T15:54:21.058Z","total_host_count":3,"updated_at":"2025-08-14T15:54:21.058629Z","user_name":"admin","validations_info":{"configuration":[{"status":"success","message":"Platform requirements satisfied"},{"status":"success","message":"The pull secret is set."}],"hosts-data":[{"status":"success","message":"All hosts in the cluster are ready to install."},{"status":"success","message":"The cluster has the exact amount of dedicated control plane nodes."}],"network":[{"status":"success","message":"API virtual IPs are defined."},{"status":"success","message":"api vips 192.168.58.50, 2600:52:7:58::50 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Cluster Network CIDR is defined."},{"status":"success","message":"The base domain is defined."},{"status":"success","message":"Ingress virtual IPs are defined."},{"status":"success","message":"ingress vips 192.168.58.54, 2600:52:7:58::54 belongs to the Machine CIDR and is not in use."},{"status":"success","message":"The Machine Network CIDR is defined."},{"status":"success","message":"The Cluster Machine CIDR is equivalent to the calculated CIDR."},{"status":"success","message":"The Cluster Network prefix is valid."},{"status":"success","message":"The cluster has a valid network type"},{"status":"success","message":"Same address families for all networks."},{"status":"success","message":"No CIDRS are overlapping."},{"status":"success","message":"No ntp problems found"},{"status":"success","message":"The Service Network CIDR is defined."}],"operators":[{"status":"success","message":"cnv is disabled"},{"status":"success","message":"lso is disabled"},{"status":"success","message":"lvm is disabled"},{"status":"success","message":"mce is disabled"},{"status":"success","message":"mtv is disabled"},{"status":"success","message":"node-feature-discovery is disabled"},{"status":"success","message":"nvidia-gpu is disabled"},{"status":"success","message":"odf is disabled"},{"status":"success","message":"openshift-ai is disabled"},{"status":"success","message":"pipelines is disabled"},{"status":"success","message":"serverless is disabled"},{"status":"success","message":"servicemesh is disabled"}]}}

-------------------------------

Installation in progress: completed 10/100
Installation in progress: completed 35/100......
Installation in progress: completed 45/100....
Installation in progress: completed 50/100.......
Installation in progress: completed 59/100
Installation in progress: completed 65/100.......................
Installation in progress: completed 68/100......
Installation in progress: completed 70/100..
-------------------------------
Nodes Rebooted...
23 minutes and 11 seconds elapsed.
Waiting for the cluster to be stable...
clusteroperators/authentication is unavailable and progressing at 2025-08-14T16:12:04Z
................................................
clusteroperators/authentication is still unavailable and progressing after 1m10s
...................................................................
clusteroperators/authentication is still unavailable and progressing after 2m20s
..............................................................
clusteroperators/authentication is still unavailable and progressing after 3m30s
............................................
clusteroperators/authentication is still unavailable and progressing after 4m40s
..................................
clusteroperators/authentication is still unavailable and progressing after 5m50s
..................................
clusteroperators/authentication is still progressing after 7m0s
.............................
clusteroperators/console stabilized at 2025-08-14T16:20:14Z after 20s
.....................
clusteroperators/etcd is still progressing after 8m10s
.............
clusteroperators/etcd is still progressing after 9m20s
.............
clusteroperators/kube-apiserver is still progressing after 11m40s
......
clusteroperators/kube-apiserver is still progressing after 12m50s
.......
All clusteroperators are still stable after 1m0s
......
All clusteroperators are still stable after 2m10s
......
All clusteroperators are still stable after 3m20s
......
All clusteroperators are still stable after 4m30s
....
All clusteroperators are stable
Virtualization cluster info:
--------------------------------
NAME                                 STATUS   ROLES                         AGE   VERSION
master1.vacm1.outbound.vz.bos2.lab   Ready    control-plane,master,worker   16m   v1.31.10
master2.vacm1.outbound.vz.bos2.lab   Ready    control-plane,master,worker   32m   v1.31.10
master3.vacm1.outbound.vz.bos2.lab   Ready    control-plane,master,worker   32m   v1.31.10
--------------------------------
NAME      VERSION   AVAILABLE   PROGRESSING   SINCE   STATUS
version   4.18.21   True        False         10m     Cluster version is 4.18.21
--------------------------------
NAME                                       VERSION   AVAILABLE   PROGRESSING   DEGRADED   SINCE   MESSAGE
authentication                             4.18.21   True        False         False      11m
baremetal                                  4.18.21   True        False         False      28m
cloud-controller-manager                   4.18.21   True        False         False      32m
cloud-credential                           4.18.21   True        False         False      32m
cluster-autoscaler                         4.18.21   True        False         False      28m
config-operator                            4.18.21   True        False         False      29m
console                                    4.18.21   True        False         False      14m
control-plane-machine-set                  4.18.21   True        False         False      28m
csi-snapshot-controller                    4.18.21   True        False         False      29m
dns                                        4.18.21   True        False         False      28m
etcd                                       4.18.21   True        False         False      25m
image-registry                             4.18.21   True        False         False      19m
ingress                                    4.18.21   True        False         False      18m
insights                                   4.18.21   True        False         False      28m
kube-apiserver                             4.18.21   True        False         False      25m
kube-controller-manager                    4.18.21   True        False         False      25m
kube-scheduler                             4.18.21   True        False         False      24m
kube-storage-version-migrator              4.18.21   True        False         False      29m
machine-api                                4.18.21   True        False         False      24m
machine-approver                           4.18.21   True        False         False      29m
machine-config                             4.18.21   True        False         False      28m
marketplace                                4.18.21   True        False         False      28m
monitoring                                 4.18.21   True        False         False      14m
network                                    4.18.21   True        False         False      29m
node-tuning                                4.18.21   True        False         False      16m
olm                                        4.18.21   True        False         False      18m
openshift-apiserver                        4.18.21   True        False         False      19m
openshift-controller-manager               4.18.21   True        False         False      25m
openshift-samples                          4.18.21   True        False         False      18m
operator-lifecycle-manager                 4.18.21   True        False         False      28m
operator-lifecycle-manager-catalog         4.18.21   True        False         False      28m
operator-lifecycle-manager-packageserver   4.18.21   True        False         False      19m
service-ca                                 4.18.21   True        False         False      29m
storage                                    4.18.21   True        False         False      29m
--------------------------------
NAME                                          DISPLAY                            VERSION
cephcsi-operator.v4.18.8-rhodf                CephCSI operator                   4.18.8-rhodf
local-storage-operator.v4.18.0-202507211933   Local Storage                      4.18.0-202507211933
mcg-operator.v4.18.8-rhodf                    NooBaa Operator                    4.18.8-rhodf
ocs-client-operator.v4.18.8-rhodf             OpenShift Data Foundation Client   4.18.8-rhodf
ocs-operator.v4.18.8-rhodf                    OpenShift Container Storage        4.18.8-rhodf
odf-csi-addons-operator.v4.18.8-rhodf         CSI Addons                         4.18.8-rhodf
odf-dependencies.v4.18.8-rhodf                Data Foundation Dependencies       4.18.8-rhodf
odf-operator.v4.18.8-rhodf                    OpenShift Data Foundation          4.18.8-rhodf
odf-prometheus-operator.v4.18.8-rhodf         Prometheus Operator                4.18.8-rhodf
packageserver                                 Package Server                     0.0.1-snapshot
recipe.v4.18.8-rhodf                          Recipe                             4.18.8-rhodf
rook-ceph-operator.v4.18.8-rhodf              Rook-Ceph                          4.18.8-rhodf
Copying extra manifests for day2 operations from /root/github/openshift-on-openshift-virtualization/abi-configs/extra-manifests/vacm1/day2/ to /root/github/openshift-on-openshift-virtualization/mno-with-abi/extra-manifests/day2/
------------------------------------------------
NAME      VERSION   AVAILABLE   PROGRESSING   SINCE   STATUS
version   4.18.21   True        False         10m     Cluster version is 4.18.21

NAME                                 STATUS   ROLES                         AGE   VERSION
master1.vacm1.outbound.vz.bos2.lab   Ready    control-plane,master,worker   16m   v1.31.10
master2.vacm1.outbound.vz.bos2.lab   Ready    control-plane,master,worker   32m   v1.31.10
master3.vacm1.outbound.vz.bos2.lab   Ready    control-plane,master,worker   32m   v1.31.10

NAME                                       VERSION   AVAILABLE   PROGRESSING   DEGRADED   SINCE   MESSAGE
authentication                             4.18.21   True        False         False      11m
baremetal                                  4.18.21   True        False         False      28m
cloud-controller-manager                   4.18.21   True        False         False      32m
cloud-credential                           4.18.21   True        False         False      32m
cluster-autoscaler                         4.18.21   True        False         False      28m
config-operator                            4.18.21   True        False         False      29m
console                                    4.18.21   True        False         False      14m
control-plane-machine-set                  4.18.21   True        False         False      28m
csi-snapshot-controller                    4.18.21   True        False         False      29m
dns                                        4.18.21   True        False         False      28m
etcd                                       4.18.21   True        False         False      25m
image-registry                             4.18.21   True        False         False      19m
ingress                                    4.18.21   True        False         False      18m
insights                                   4.18.21   True        False         False      28m
kube-apiserver                             4.18.21   True        False         False      25m
kube-controller-manager                    4.18.21   True        False         False      25m
kube-scheduler                             4.18.21   True        False         False      24m
kube-storage-version-migrator              4.18.21   True        False         False      29m
machine-api                                4.18.21   True        False         False      24m
machine-approver                           4.18.21   True        False         False      29m
machine-config                             4.18.21   True        False         False      28m
marketplace                                4.18.21   True        False         False      28m
monitoring                                 4.18.21   True        False         False      14m
network                                    4.18.21   True        False         False      29m
node-tuning                                4.18.21   True        False         False      16m
olm                                        4.18.21   True        False         False      18m
openshift-apiserver                        4.18.21   True        False         False      19m
openshift-controller-manager               4.18.21   True        False         False      25m
openshift-samples                          4.18.21   True        False         False      18m
operator-lifecycle-manager                 4.18.21   True        False         False      28m
operator-lifecycle-manager-catalog         4.18.21   True        False         False      28m
operator-lifecycle-manager-packageserver   4.18.21   True        False         False      19m
service-ca                                 4.18.21   True        False         False      29m
storage                                    4.18.21   True        False         False      29m

NAME                                                   AGE
advanced-cluster-management.open-cluster-management    28m
cephcsi-operator.openshift-storage                     26m
local-storage-operator.openshift-local-storage         28m
mcg-operator.openshift-storage                         26m
ocs-client-operator.openshift-storage                  26m
ocs-operator.openshift-storage                         26m
odf-csi-addons-operator.openshift-storage              26m
odf-dependencies.openshift-storage                     26m
odf-operator.openshift-storage                         28m
odf-prometheus-operator.openshift-storage              26m
openshift-gitops-operator.openshift-operators          28m
recipe.openshift-storage                               26m
rook-ceph-operator.openshift-storage                   26m
topology-aware-lifecycle-manager.openshift-operators   28m

NAMESPACE                 NAME                                                                         PACKAGE                            SOURCE             CHANNEL
open-cluster-management   advanced-cluster-management                                                  advanced-cluster-management        redhat-operators
openshift-local-storage   local-storage-operator                                                       local-storage-operator             redhat-operators   stable
openshift-operators       openshift-gitops-operator                                                    openshift-gitops-operator          redhat-operators
openshift-operators       openshift-topology-aware-lifecycle-manager-subscription                      topology-aware-lifecycle-manager   redhat-operators   stable
openshift-storage         cephcsi-operator-stable-4.18-redhat-operators-openshift-marketplace          cephcsi-operator                   redhat-operators   stable-4.18
openshift-storage         mcg-operator-stable-4.18-redhat-operators-openshift-marketplace              mcg-operator                       redhat-operators   stable-4.18
openshift-storage         ocs-client-operator-stable-4.18-redhat-operators-openshift-marketplace       ocs-client-operator                redhat-operators   stable-4.18
openshift-storage         ocs-operator-stable-4.18-redhat-operators-openshift-marketplace              ocs-operator                       redhat-operators   stable-4.18
openshift-storage         odf-csi-addons-operator-stable-4.18-redhat-operators-openshift-marketplace   odf-csi-addons-operator            redhat-operators   stable-4.18
openshift-storage         odf-dependencies                                                             odf-dependencies                   redhat-operators   stable-4.18
openshift-storage         odf-operator                                                                 odf-operator                       redhat-operators   stable-4.18
openshift-storage         odf-prometheus-operator-stable-4.18-redhat-operators-openshift-marketplace   odf-prometheus-operator            redhat-operators   stable-4.18
openshift-storage         recipe-stable-4.18-redhat-operators-openshift-marketplace                    recipe                             redhat-operators   stable-4.18
openshift-storage         rook-ceph-operator-stable-4.18-redhat-operators-openshift-marketplace        rook-ceph-operator                 redhat-operators   stable-4.18

clusterserviceversion.operators.coreos.com/cephcsi-operator.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/local-storage-operator.v4.18.0-202507211933
clusterserviceversion.operators.coreos.com/mcg-operator.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/ocs-client-operator.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/ocs-operator.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/odf-csi-addons-operator.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/odf-dependencies.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/odf-operator.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/odf-prometheus-operator.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/packageserver
clusterserviceversion.operators.coreos.com/recipe.v4.18.8-rhodf
clusterserviceversion.operators.coreos.com/rook-ceph-operator.v4.18.8-rhodf

------------------------------------------------
Applying day2 operations....

Node labels:                                                 enabled
Label master1.vacm1.outbound.vz.bos2.lab                     cluster.ocs.openshift.io/openshift-storage=
node/master1.vacm1.outbound.vz.bos2.lab labeled
Label master2.vacm1.outbound.vz.bos2.lab                     cluster.ocs.openshift.io/openshift-storage=
node/master2.vacm1.outbound.vz.bos2.lab labeled
Label master3.vacm1.outbound.vz.bos2.lab                     cluster.ocs.openshift.io/openshift-storage=
node/master3.vacm1.outbound.vz.bos2.lab labeled


Disable operators auto upgrade                               true
operator advanced-cluster-management subscription installPlanApproval: Manual
subscription.operators.coreos.com/advanced-cluster-management patched (no change)
operator local-storage-operator subscription installPlanApproval: Manual
subscription.operators.coreos.com/local-storage-operator patched
operator openshift-gitops-operator subscription installPlanApproval: Manual
subscription.operators.coreos.com/openshift-gitops-operator patched (no change)
operator openshift-topology-aware-lifecycle-manager-subscription subscription installPlanApproval: Manual
subscription.operators.coreos.com/openshift-topology-aware-lifecycle-manager-subscription patched
operator cephcsi-operator-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/cephcsi-operator-stable-4.18-redhat-operators-openshift-marketplace patched
operator mcg-operator-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/mcg-operator-stable-4.18-redhat-operators-openshift-marketplace patched
operator ocs-client-operator-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/ocs-client-operator-stable-4.18-redhat-operators-openshift-marketplace patched
operator ocs-operator-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/ocs-operator-stable-4.18-redhat-operators-openshift-marketplace patched
operator odf-csi-addons-operator-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/odf-csi-addons-operator-stable-4.18-redhat-operators-openshift-marketplace patched
operator odf-dependencies subscription installPlanApproval:  Manual
subscription.operators.coreos.com/odf-dependencies patched
operator odf-operator subscription installPlanApproval:      Manual
subscription.operators.coreos.com/odf-operator patched
operator odf-prometheus-operator-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/odf-prometheus-operator-stable-4.18-redhat-operators-openshift-marketplace patched
operator recipe-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/recipe-stable-4.18-redhat-operators-openshift-marketplace patched
operator rook-ceph-operator-stable-4.18-redhat-operators-openshift-marketplace subscription installPlanApproval: Manual
subscription.operators.coreos.com/rook-ceph-operator-stable-4.18-redhat-operators-openshift-marketplace patched

Local Storage Operator day2:                                 enabled
localvolumediscovery.local.storage.openshift.io/auto-discover-devices created
localvolumeset.local.storage.openshift.io/odf-localdisk created
OpenShift Data Foundation day2:                              enabled
storagecluster.ocs.openshift.io/ocs-storagecluster created


Done.
day2 operations done.
```