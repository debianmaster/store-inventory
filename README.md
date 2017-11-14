

# DATABASE
## Allow anyuid
```sh
oc adm policy add-scc-to-user anyuid -z default
```

## Deploy statefulset
```sh
oc apply -f https://raw.githubusercontent.com/cockroachdb/cockroach/master/cloud/kubernetes/cockroachdb-statefulset.yaml
```

## Init cluster
```sh
oc apply -f https://raw.githubusercontent.com/cockroachdb/cockroach/master/cloud/kubernetes/cluster-init.yaml
```

## Expose UI 

```sh
oc expose svc  cockroachdb-public --port=8080 --name=r1
```

## Scale statefulset
```sh
oc scale statefulset cockroachdb --replicas=4
```

###  Connect to cluster
```sh
oc run cockroachdb -it --image=cockroachdb/cockroach --rm --restart=Never     -- sql --insecure --host=cockroachdb-public
```
```sh
create database store;
use store;
create table inventory (id int,product_id varchar(30),product_cost int,product_availabilty int,product_subcat int);
insert into inventory values (1,'cable_1',10,200,1);
```

# API
### Example app
```sh
oc new-app debianmaster/store-inventory:cockroach --name=inventory \
-e sql_string=postgresql://root@cockroachdb-public:26257/store?sslmode=disable
oc expose svc inventory
```



# Not in Use
```sh
oc new-app mysql -e MYSQL_ROOT_PASSWORD=password
export MYSQL=$(oc get pods -l app=mysql -o jsonpath={.items[0].metadata.name})
oc cp ./script.sql $MYSQL:/tmp/script.sql
oc rsh $MYSQL
mysql -h 127.0.0.1 -u root -p < /tmp/script.sql #inside container.

oc new-app https://github.com/i63/store-inventory --name=inventory
oc env dc inventory sql_db=store sql_host=mysql sql_user=root sql_password=password
```
