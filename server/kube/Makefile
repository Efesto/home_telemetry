deploy: deploy-provisioning
	kubectl apply -f grafana.yml

deploy-provisioning:
	kubectl apply -f grafana_provisioning.yml

# this for forcing the provisioning after an update
restart-grafana:
	kubectl rollout restart deployment grafana