install-db:
	echo "deb https://repos.influxdata.com/ubuntu bionic stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
	curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
		
	sudo apt-get install influxdb -y
	influx -import -path=db.import -precision=s

install-nginx:
	sudo apt-get install nginx -y
	sudo cp nginx/grafana_viewer /etc/nginx/sites-enabled/default
	sudo systemctl restart nginx.service

install-grafana:
	sudo apt-get install -y adduser libfontconfig1
	wget https://dl.grafana.com/oss/release/grafana_7.0.3_armhf.deb
	sudo dpkg -i grafana_7.0.3_armhf.deb
	sudo systemctl enable grafana-server.service
	sudo systemctl start grafana-server
	sudo systemctl status grafana-server
