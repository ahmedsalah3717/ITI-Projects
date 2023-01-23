1- Create a namespace haproxy-controller-devops.

2- Create a ServiceAccount haproxy-service-account-devops under the same namespace.

3- Create a ClusterRole which should be named as haproxy-cluster-role-devops, to grant
permissions "get", "list", "watch", "create", "patch", "update" to
"Configmaps",”secrets”,"endpoints","nodes","pods","services",
"namespaces","events","serviceaccounts".

4- Create a ClusterRoleBinding which should be named as
haproxy-cluster-role-binding-devops under the same namespace. Define roleRef apiGroup
should be rbac.authorization.k8s.io, kind should be ClusterRole, name should be
haproxy-cluster-role-devops and subjects kind should be ServiceAccount, name should be
haproxy-service-account-devops and namespace should be haproxy-controller-devops.

5- Create a backend deployment which should be named as backend-deployment-devops
under the same namespace, labels run should be ingress-default-backend under metadata.
Configure spec as replica should be 1, selector's matchLabels run should be
ingress-default-backend. Template's labels run under metadata should be
ingress-default-backend. The container should named as backend-container-devops, use
image gcr.io/google_containers/defaultbackend:1.0 ( use exact name of image as
mentioned ) and its containerPort should be 8080.

6- Create a service for backend which should be named as service-backend-devops under
the same namespace, labels run should be ingress-default-backend. Configure spec as
selector's run should be ingress-default-backend, port should be named as port-backend,
protocol should be TCP, port should be 8080 and targetPort should be 8080.

7- Create a deployment for frontend which should be named haproxy-ingress-devops
under the same namespace. Configure spec as replica should be 1, selector's matchLabels
should be haproxy-ingress, template's labels run should be haproxy-ingress under
metadata. The container name should be ingress-container-devops under the same service
account haproxy-service-account-devops, use image haproxytech/kubernetes-ingress, give
args as --default-backend-service=haproxy-controller-devops/service-backend-devops,
resources requests for cpu should be 500m and for memory should be 50Mi, livenessProbe
httpGet path should be /healthz its port should be 1024. The first port name should be http
and its containerPort should be 80, second port name should be https and its
containerPort should be 443 and third port name should be stat its containerPort should
be 1024. Define environment as first env name should be TZ its value should be Etc/UTC,
second env name should be POD_NAME itsvalueFrom:
fieldRef:
fieldPath: should be metadata.name and third env name should be POD_NAMESPACE
its
valueFrom:
fieldRef:
fieldPath: should be metadata.namespace.

8- Create a service for frontend which should be named as ingress-service-devops under
same namespace, labels run should be haproxy-ingress. Configure spec as selectors' run
should be haproxy-ingress, type should be NodePort. The first port name should be http,
its port should be 80, protocol should be TCP, targetPort should be 80 and nodePort should
be 32456. The second port name should be https, its port should be 443, protocol should
be TCP, targetPort should be 443 and nodePort should be 32567. The third port name
should be stat, its port should be 1024, protocol should be TCP, targetPort should be 1024
and nodePort should be 32678.
