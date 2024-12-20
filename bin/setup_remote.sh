user=mangosteen
root=/home/$user/deploys/$version
container_name=mangosteen-prod-1
db_container_name=db-for-mangosteen

function set_env {
  name=$1
  hint=$2
  [[ ! -z "${!name}" ]] && return
  while [ -z "${!name}" ]; do
    [[ ! -z "$hint" ]] && echo "> 请输入 $name: $hint" || echo "> 请输入 $name:"
    read $name
  done
  sed -i "1s/^/export $name=${!name}\n/" ~/.bashrc
  echo "${name} 已保存至 ~/.bashrc"
}
function title {
  echo 
  echo "###############################################################################"
  echo "## $1"
  echo "###############################################################################" 
  echo 
}

title '设置远程机器的环境变量'
set_env DB_HOST
set_env DB_PASSWORD
set_env RAILS_MASTER_KEY

title '确保 Docker 网络存在'
if ! docker network ls | grep -q app-network; then
  docker network create app-network
  echo 'Docker 网络 app-network 创建成功'
else
  echo 'Docker 网络 app-network 已存在'
fi

title '创建数据库'
if [ "$(docker ps -aq -f name=^${db_container_name}$)" ]; then
  echo '已存在数据库'
else
  docker run -d --name $db_container_name \
            --network=app-network \
            -p 5432:5432 \
            -e POSTGRES_USER=mangosteen \
            -e POSTGRES_DB=mangosteen_production \
            -e POSTGRES_PASSWORD=$DB_PASSWORD \
            -e PGDATA=/var/lib/postgresql/data/pgdata \
            -v mangosteen-data:/var/lib/postgresql/data \
            postgres:14
  echo '创建成功'
  echo '等待数据库启动...'
  sleep 3  # 给数据库一些启动时间
fi

title 'docker build'
docker build $root -t mangosteen:$version

if [ "$(docker ps -aq -f name=^mangosteen-prod-1$)" ]; then
  title 'docker rm'
  docker rm -f $container_name
fi

title 'docker run'
docker run -d -p 3000:3000 \
           --network=app-network \
           --name=$container_name \
           -e DB_HOST=$db_container_name \
           -e DB_PASSWORD=$DB_PASSWORD \
           -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
           mangosteen:$version

echo
echo "是否要更新数据库？[y/N]"
read ans
case $ans in
    y|Y|1  )  
        echo "yes"
        title '更新数据库'
        docker exec $container_name bin/rails db:create db:migrate
        
        echo
        echo "是否要执行 seed？[y/N]"
        read seed_ans
        case $seed_ans in
            y|Y|1  )  echo "yes"; title '执行 seed'; docker exec $container_name bin/rails db:seed ;;
            n|N|2  )  echo "no" ;;
            ""     )  echo "no" ;;
        esac
        ;;
    n|N|2  )  echo "no" ;;
    ""     )  echo "no" ;;
esac

title '全部执行完毕'