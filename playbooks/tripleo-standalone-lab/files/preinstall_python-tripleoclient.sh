!#/bin/bash
pushd /tmp 
cp /var/lib/libvirt/images/CentOS-7-x86_64-GenericCloud.qcow2 /tmp/CentOS-7-x86_64-TripleO-Master-Current-TripleO.qcow2
wget -O delorean.repo https://trunk.rdoproject.org/centos7/current-tripleo/delorean.repo
wget -O delorean-deps.repo https://trunk.rdoproject.org/centos7/delorean-deps.repo

virt-customize -a CentOS-7-x86_64-TripleO-Master-Current-TripleO.qcow2 --upload delorean.repo:/etc/yum.repos.d/ 
virt-customize -a CentOS-7-x86_64-TripleO-Master-Current-TripleO.qcow2 --upload delorean-deps.repo:/etc/yum.repos.d/

virt-customize -a CentOS-7-x86_64-TripleO-Master-Current-TripleO.qcow2 --install python-tripleoclient

cp /tmp/CentOS-7-x86_64-TripleO-Master-Current-TripleO.qcow2 /var/lib/libvirt/images/
