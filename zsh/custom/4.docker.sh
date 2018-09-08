# -------------------------------------------------------------------
# docker
# $ sudo systemctl start docker
# $ sudo service docker start
# -------------------------------------------------------------------
# 杀死所有正在运行的容器.
alias docker-kill-containers='docker kill $(docker ps -a -q)'
# 删除所有已经停止的容器.
alias docker-clean-containers='docker rm $(docker ps -a -q)'
# 删除所有未打标签的镜像.
alias docker-clean-images='docker rmi $(docker images -q -f dangling=true)'
# 删除所有已经停止的容器和未打标签的镜像.
alias docker-clean-all='dockercleanc || true && dockercleani'


# database
MYSQL_PASSWORD=password
POSTGRES_PASSWORD=password
# mysql
alias docker-run-mysql="docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWORD -d mysql"
alias docker-mysql-cli="MYSQL_PWD=$MYSQL_PASSWORD mysql -h 127.0.0.1 -u root"
docker-mysql-import() {
    docker exec -i mysql mysql -uroot -ppassword $1 < $2
}
# mariadb
alias docker-run-mariadb="docker run --name mariadb -p 3307:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWORD -d mariadb"
function docker-mariadb-cli() {
    docker run -it --link mariadb:mysql --rm mariadb sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
}
# postgres
alias docker-run-postgres="docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -d postgres"
alias docker-postgres-cli="docker run -it --rm --link postgres:postgres -e PGPASSWORD=$POSTGRES_PASSWORD postgres psql -h postgres -U postgres"
function docker-postgres-dump-database-schema() {
    docker run -it --rm --link postgres:postgres -e PGPASSWORD=$POSTGRES_PASSWORD postgres pg_dump -h postgres -U postgres --schema-only $1 >> postgres_dump_database_schema_$1.sql
}
function docker-postgres-dump-database() {
    docker run -it --rm --link postgres:postgres -e PGPASSWORD=$POSTGRES_PASSWORD postgres pg_dump -h postgres -U postgres $1 >> postgres_dump_database_$1.sql
}
function docker-postgres-restore() {
    docker run -i --rm --link postgres:postgres -e PGPASSWORD=$POSTGRES_PASSWORD postgres psql -h postgres -U postgres < $1
}
# redis
docker-run-redis() {
    docker run --name redis -p 6379:6379 -d -v "$1":/data redis
}
alias docker-redis-cli='docker run -it --link redis:redis --rm redis redis-cli -h redis -p 6379'
# ssdb
alias docker-run-ssdb='docker run --name ssdb -p 8888:8888 -d wendal/ssdb'
