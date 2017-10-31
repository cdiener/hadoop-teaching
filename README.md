# Teaching image for Apache Hadoop

This is a small-ish (hadoop binaries are huge) image that runs a minimal
Hadoop cluster. It leverages the [Hadoop MiniCluster](http://hadoop.apache.org/docs/r2.8.2/hadoop-project-dist/hadoop-common/CLIMiniCluster.html)
to create a fully functional pseudo cluster with HDFS and YARN.

## Usage

Pull the image with

```bash
docker pull cdiener/hadoop
```

Run the server with

```bash
docker run -d cdiener/hadoop
```

This will take a few seconds and the startup process can be checked using
`docker logs <container-name>`.
After the server has been started you can attach to it and run any of the usual
Hadoop commands:

```bash
docker exec -ti <container-name> bash
bash-4.3# hdfs dfsadmin -report
Configured Capacity: 21451767808 (19.98 GB)
Present Capacity: 15696965632 (14.62 GB)
DFS Remaining: 15507980288 (14.44 GB)
DFS Used: 188985344 (180.23 MB)
DFS Used%: 1.20%
Under replicated blocks: 2
Blocks with corrupt replicas: 0
Missing blocks: 0
Missing blocks (with replication factor 1): 0
Pending deletion blocks: 0

-------------------------------------------------
Live datanodes (1):

Name: 127.0.0.1:38241 (localhost)
Hostname: 127.0.0.1
Decommission Status : Normal
Configured Capacity: 21451767808 (19.98 GB)
DFS Used: 188985344 (180.23 MB)
Non DFS Used: 5754802176 (5.36 GB)
DFS Remaining: 15507980288 (14.44 GB)
DFS Used%: 0.88%
DFS Remaining%: 72.29%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 1
Last contact: Tue Oct 31 21:08:36 GMT 2017
```

The Hadoop Web UI is exposed on port 8088. You can use it with the IP of the
associated docker network. Alternatively you can also publish the port when
starting the container:

docker run -d -p 8088:8088 cdiener/hadoop

## Example data

The default version also includes the latest Python as well as a small script
to generate an artificial example data set of retail information for fictional
Mexican company consisting of the following columns:

- id of the report
- date for the report
- name of the responsible employee
- contact phone
- contact E-mail
- street address
- city
- postal code
- state
- revenue
- expenses

(several reports can be filed on any given location and day).

The data can be generated as a CSV with

```bash
make_data.py 1000000
```

Here, the argument denotes the number of reports. 1M reports will clock in at
about 180 MB, 10M at 1.8 GB, and so on. It is meant to create a simple exercise
for MapReduce using Hadoop Streaming. Example questions:

- what are the total revenue and expenses by state, what is the profit?
- what is the cumulative profit over the year?
- which states generate a negative profit?

If you do not want any of that there is also a "simple" version that only
includes Hadoop and that can be pulled with

```bash
docker pull cdiener/hadoop:simple
```
