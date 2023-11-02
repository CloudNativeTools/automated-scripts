          STATUS="success"
          if [[ $STATUS == 'success' ]]; then
             message="[issue-${STATUS}](https://github.com/CloudNativeTools/automated-scripts/issues/${STATUS}) 中镜像已同步"
          else
             message="[issue-${STATUS}](https://github.com/CloudNativeTools/automated-scripts/issues/${STATUS}) 中镜像同步失败"
	  fi    
	  echo $message   
          curl -X POST -H 'Content-Type: application/json' "WECHAT_WEBHOOK" -d '{
                  "msgtype": "markdown",
                  "markdown": {
                    "content": "'"$message"'"
                  }
              }'


