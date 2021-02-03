#!/usr/bin/env bash
export masterNode=$(oc get nodes -l node-role.kubernetes.io/master -o jsonpath=’{.items[0].metadata.name}’)
oc debug node/$masterNode --image rhel7/rhel-tools -- chroot /host /usr/local/bin/cluster-backup.sh /home/core/assets/backup
oc debug node/$masterNode --image rhel7/rhel-tools -- bash -c ‘cat /host/home/core/assets/backup/snapshot_*’ > snapshot.db
oc debug node/$masterNode --image rhel7/rhel-tools -- bash -c ‘cat /host/home/core/assets/backup/static_kuberesources_*’ > static_kuberesources.tar.gz
oc debug node/$masterNode --image rhel7/rhel-tools -- chroot /host rm home/core/assets/backup/snapshot_* home/core/assets/backup/static_*
