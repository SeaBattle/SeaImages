# build
docker build --tag seabattle/etcd .
# create & run
docker run -p 2379:2379 --name etcd -d seabattle/etcd
# run
docker start etcd
