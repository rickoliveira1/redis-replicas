# Redis Cluster 3 Master with 3 slaves - OpenShift

Redis Version: **4.0.2**

## Building the Docker image

    docker build -t <tagname> .

## Running the cluster

    kubectl create -f redis-first.yml -f redis-second.yml -f redis-third.yml
