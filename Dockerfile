FROM python:2.7.15-alpine3.9
LABEL description="ElastAlert suitable for Docker Kubernetes"

MAINTAINER hello_linux@aliyun.com

#Elastalert的release版本号
ENV ELASTALERT_VERSION v0.1.38
ENV ELASTALERT_URL https://github.com/Yelp/elastalert/archive/${ELASTALERT_VERSION}.tar.gz
#Elasticsearch目录设置
ENV ELASTALERT_HOME /opt/elastalert
ENV ELASTALERT_CONFIG /opt/elastalert/config
ENV RULES_DIRECTORY /opt/elastalert/es_rules
ENV ELASTALERT_PLUGIN_DIRECTORY /opt/elastalert/elastalert_modules

#Elasticsearch 工作目录
WORKDIR /opt/elastalert


RUN apk --update upgrade && \
    apk add curl tar musl-dev linux-headers gcc libffi-dev libffi openssl-dev && \
		rm -rf /var/cache/apk/* && \
    mkdir -p ${ELASTALERT_PLUGIN_DIRECTORY} && \
    mkdir -p ${ELASTALERT_CONFIG} && \
    mkdir -p ${RULES_DIRECTORY} && \
    curl -Lo elastalert.tar.gz ${ELASTALERT_URL} && \
    tar -zxvf elastalert.tar.gz -C ${ELASTALERT_HOME} --strip-components 1 && \
    rm -rf elastalert.tar.gz && \
    pip install "setuptools>=11.3" && \
		pip install "elasticsearch>=5.0.0" && \
    python setup.py install && \
		apk del gcc libffi-dev musl-dev && \
		echo "#!/bin/sh" >> /opt/elastalert/run.sh && \
		echo "elastalert-create-index --no-ssl --no-verify-certs --config config/config.yaml" >> run.sh && \
	  echo "elastalert --config --config config/config.yaml" >> run.sh && \
	  chmod +x /opt/elastalert/run.sh

COPY config/config.yaml /opt/elastalert/
COPY ./es_rules/* ${RULES_DIRECTORY}/
COPY ./elastalert_modules/* ${ELASTALERT_PLUGIN_DIRECTORY}/


# Launch Elastalert when a container is started.
CMD ["/bin/sh","run.sh"]
