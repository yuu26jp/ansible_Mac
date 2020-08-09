# ansible-mac
Mac開発環境セットアップ用Ansible

## 実行手順
```bash
# リポジトリ取得
$ curl -sLo ./ansible-mac.zip https://github.com/yuu26jp/ansible-mac/archive/master.zip
$ unzip ansible-mac.zip

# Ansibleセットアップ
$ cd ansible-mac-master
$ ./setup.sh

# Ansible実行
$ ansible-playbook -i hosts mac.yml -DC
$ ansible-playbook -i hosts mac.yml -D
```
