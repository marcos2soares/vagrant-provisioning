# Instala lonhhorn
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.0/deploy/longhorn.yaml

# Instala s3 simulador

kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.0/deploy/backupstores/minio-backupstore.yaml


#s3://backupbucket@us-east-1/

#minio-secret

# Cria Ingress

rm auth 2>/dev/null
USER=admin; PASSWORD=admin; echo "${USER}:$(openssl passwd -stdin -apr1 <<< ${PASSWORD})" >> auth


kubectl -n longhorn-system create secret generic basic-auth --from-file=auth



echo "
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: longhorn-ingress
  namespace: longhorn-system
  annotations:
    kubernetes.io/ingress.class: "nginx-prd"
    # type of authentication
    nginx.ingress.kubernetes.io/auth-type: basic
    # prevent the controller from redirecting (308) to HTTPS
    nginx.ingress.kubernetes.io/ssl-redirect: 'false'
    # name of the secret that contains the user/password definitions
    nginx.ingress.kubernetes.io/auth-secret: basic-auth
    # message to display with an appropriate context why the authentication is required
    nginx.ingress.kubernetes.io/auth-realm: 'Authentication Required '
spec:
  rules:
  - host: longhorn.kubeprd.msdigital.xyz
    http:
      paths:
      - path: /
        backend:
          serviceName: longhorn-frontend
          servicePort: 80
" | kubectl -n longhorn-system create -f -
