build:
	MIX_TARGET=rpi mix firmware

upload_firmware: build
	 ./upload.sh ${COLLECTOR_IP} _build/rpi_dev/nerves/images/home_telemetry.fw