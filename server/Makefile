install:
	helm dependency build ./the-place	
	helm install --set envRenderSecret.INFLUX_DB_USER=${INFLUX_DB_USER},envRenderSecret.INFLUX_DB_PASSWORD=${INFLUX_DB_PASSWORD} the-place ./the-place --wait && \
	kubectl get secret --namespace default the-place-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

upgrade: 
	helm upgrade the-place ./the-place

install-db:
	echo "deb https://repos.influxdata.com/ubuntu bionic stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
	curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
		
	sudo apt-get install influxdb -y
	influx -import -path=db.import -precision=s