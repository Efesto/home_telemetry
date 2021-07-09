helm-install:
	kubectl apply -f ingress.yml
	helm install -f values.yml --set envRenderSecret.INFLUX_DB_USER=${INFLUX_DB_USER},envRenderSecret.INFLUX_DB_PASSWORD=${INFLUX_DB_PASSWORD} grafana grafana/grafana --wait && \
	kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

helm-upgrade: 
	helm upgrade -f values.yml --set envRenderSecret.INFLUX_DB_USER=${INFLUX_DB_USER},envRenderSecret.INFLUX_DB_PASSWORD=${INFLUX_DB_PASSWORD} grafana grafana/grafana