# AttendanceManagement

## API

### attendances/json(GET)
出席している人の名前を返す

~~~json
[  
  {
      "id": 1,
      "idm": "0101031299182322",
      "name": "山田太郎"
  },
  {
      "id": 2,
      "idm": "1x2c3c4v5b6n7n7",
      "name": "池谷涼平"
    },
  {
      "id": 3,
      "idm": "1lASlAe9e98j",
      "name": "佐藤花子"
    }
]
~~~

type

- users: array

### attendances/cancel(POST)

left(退出)の記録を削除する

#### APIに投げる値

~~~json
{
    "idm": "1lASlAe9e98j"
}
~~~

type

- idm: string

#### APIから返却される値

left記録を正常にキャンセルできた場合 **succeeded**   
何らかの内部的エラーで削除できなかった場合 **failed**

~~~json
{
    "stauts": ["succeeded","failed"]
}
~~~

type

- status: string

### attendances/create(POST)

出席を記録する

#### APIに投げるとき

~~~json
{
    "idm": "1lASlAe9e98j",
    "datetime": "1145/14/19 19:28:26"
}
~~~

type

- idm: string
- datetime: string(%Y/%m/%d %H:%M%S)

#### APIから返却される値

~~~json
{
    "status": ["already", "early", "enter", "left", "error", "nouser"]
}
~~~

type

- status: string

value

- already: すでに今日は退出している
- early: 入場してから１分以内
- enter: 入場が記録されたとき
- left: 退場が記録されたとき
- error: 内部的なエラー
- nouser: 指定されたidmが存在しなかった場合
