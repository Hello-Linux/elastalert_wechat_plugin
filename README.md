Elastalert_Wechat_Plugin
====

基于ElastAlert的微信企业号报警插件
-----

## 使用说明
    申请企业微信公众号在这里我就不详细说明了,大家可以看看网上的教程去申请
    下面主要介绍一下该插件的使用方法

### `第一步:`

    首先你要确保你已经安装好了python的报警框架elastalert(https://github.com/Yelp/elastalert.git)
    具体的安装方法可以参考官方的文档https://elastalert.readthedocs.io/en/latest/running_elastalert.html

下面我以克隆仓库安装为例

* (1)克隆代码
```Bash
git clone https://github.com/Yelp/elastalert.git
```
* (2)使用python2.7的pip管理工具安装依赖包
```Bash
pip install -r requirements.txt
pip install -r requirements-dev.txt
```
* (3)执行安装
```Bash
python2.7 setup.py install
```

### `第二步`

    修改配置文件
    打开config.yaml按照里面的说明进行配置,其中es_rules中放置的是我写的一个wechat规则模板大家可以简单修改一下继续使用

### `第三步`

    将elastalert_wechat_plugin目录下的所有文件拷贝到elastalert目录下即可

### `第四步`

    创建Elasticsearch索引
    进入我们的项目目录./elastalert/elastalert/ 执行
```Bash
$ python2.7 create_index.py --host es_host --port ex_post --username es_username --password es_password --no-ssl --no-verify-certs
```
    这个命令会在elasticsearch创建索引，便于ElastAlert将有关其查询及其警报的信息和元数据保存回Elasticsearch。这不是必须的步骤，但是强烈建议创建。因为对于审计，测试很有用，并且重启elastalert不影响计数和发送alert。默认情况下，创建的索引叫 elastalert_status

### `第五步`
    启动
```Bash
python2.7 -m elastalert.elastalert --verbose --config config.yaml --rule es_rules/wechart.yaml
```
    config指定配置文件路径  rule指定你的微信报警文件

如果需要更加详细的安装过程以及说明请参考我的今日头条呦[今日头条](https://www.toutiao.com/i6652174479763964419) 

# 运行样例截图:
![image](https://github.com/Hello-Linux/elastalert_wechat_plugin/blob/master/images/elastalert.jpg)
