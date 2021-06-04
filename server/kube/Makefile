apply-grafana: apply-grafana-provisioning
	kubectl apply -f grafana.yml

apply-grafana-provisioning:
	kubectl apply -f grafana_provisioning.yml

restart-grafana:
	kubectl rollout restart deployment grafana