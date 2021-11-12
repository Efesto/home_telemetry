install:
	helm dependency build ./the-place	
	helm install --set envRenderSecret.INFLUX_DB_USER=${INFLUX_DB_USER},envRenderSecret.INFLUX_DB_PASSWORD=${INFLUX_DB_PASSWORD} the-place ./the-place --wait && \
	kubectl get secret --namespace default the-place-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

upgrade: 
	helm dependency build ./the-place
	helm upgrade --set envRenderSecret.INFLUX_DB_USER=${INFLUX_DB_USER},envRenderSecret.INFLUX_DB_PASSWORD=${INFLUX_DB_PASSWORD} the-place ./the-place