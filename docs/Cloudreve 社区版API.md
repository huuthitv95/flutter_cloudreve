---
title: Cloudreve 社区版API
language_tabs:
  - shell: Shell
  - http: HTTP
  - javascript: JavaScript
  - ruby: Ruby
  - python: Python
  - php: PHP
  - java: Java
  - go: Go
toc_footers: []
includes: []
search: true
code_clipboard: true
highlight_theme: darkula
headingLevel: 2
generator: "@tarslib/widdershins v4.0.28"

---

# Cloudreve 社区版API

Base URLs:

# Authentication

# auth

## POST 用户登录

POST /user/session

> Body 请求参数

```json
{
  "userName": "{{userName}}",
  "Password": "{{Password}}",
  "captchaCode": ""
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|object| 否 |none|
|» userName|body|string| 是 |登录邮箱|
|» Password|body|string| 是 |登录密码|
|» captchaCode|body|string| 是 |人机验证信息|

> 返回示例

```json
{
  "code": 0,
  "data": {
    "id": "l6hY",
    "user_name": "admin@cloudreve.org",
    "nickname": "admin",
    "status": 0,
    "avatar": "",
    "created_at": "2024-05-01T11:04:25.490486+08:00",
    "preferred_theme": "",
    "anonymous": false,
    "group": {
      "id": 1,
      "name": "Admin",
      "allowShare": true,
      "allowRemoteDownload": true,
      "allowArchiveDownload": true,
      "shareDownload": true,
      "compress": true,
      "webdav": true,
      "sourceBatch": 1000,
      "advanceDelete": true,
      "allowWebDAVProxy": false
    },
    "tags": []
  },
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|请求状态|none|
|» data|[User](#schemauser)|true|none||none|
|»» id|string|true|none||用户ID|
|»» user_name|string|true|none||用户邮箱|
|»» nickname|string|true|none||用户昵称|
|»» status|integer|true|none||用户状态|
|»» avatar|string|true|none||头像|
|»» created_at|string|true|none||注册时间|
|»» preferred_theme|string|true|none||默认主题|
|»» anonymous|boolean|true|none||登录状态|
|»» group|object|true|none||none|
|»»» id|integer|true|none||组ID|
|»»» name|string|true|none||组名称|
|»»» allowShare|boolean|true|none||是否允许组内用户分享|
|»»» allowRemoteDownload|boolean|true|none||是否允许组内用户离线下载|
|»»» allowArchiveDownload|boolean|true|none||是否允许组内用户打包下载|
|»»» shareDownload|boolean|true|none||none|
|»»» compress|boolean|true|none||none|
|»»» webdav|boolean|true|none||是否允许组内用户使用WebDAV|
|»»» sourceBatch|integer|true|none||none|
|»»» advanceDelete|boolean|true|none||是否允许组内用户使用高级删除|
|»»» allowWebDAVProxy|boolean|true|none||none|
|»» tags|[string]|true|none||none|
|» msg|string|true|none|错误信息|none|

## POST 用户登录(OTP)

POST /user/2fa

需要先进行普通登录，服务端会返回“需要OTP密钥”，这时才可以请求OTP登录，需要携带普通登录的cookies

> Body 请求参数

```json
{
  "code": "000000"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|object| 否 |none|
|» code|body|string| 是 |OTP密钥|

> 返回示例

```json
{
  "code": 0,
  "data": {
    "id": "l6hY",
    "user_name": "admin@cloudreve.org",
    "nickname": "admin",
    "status": 0,
    "avatar": "",
    "created_at": "2024-05-01T11:04:25.490486+08:00",
    "preferred_theme": "",
    "anonymous": false,
    "group": {
      "id": 1,
      "name": "Admin",
      "allowShare": true,
      "allowRemoteDownload": true,
      "allowArchiveDownload": true,
      "shareDownload": true,
      "compress": true,
      "webdav": true,
      "sourceBatch": 1000,
      "advanceDelete": true,
      "allowWebDAVProxy": false
    },
    "tags": []
  },
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|请求状态|none|
|» data|[User](#schemauser)|true|none||none|
|»» id|string|true|none||用户ID|
|»» user_name|string|true|none||用户邮箱|
|»» nickname|string|true|none||用户昵称|
|»» status|integer|true|none||用户状态|
|»» avatar|string|true|none||头像|
|»» created_at|string|true|none||注册时间|
|»» preferred_theme|string|true|none||默认主题|
|»» anonymous|boolean|true|none||登录状态|
|»» group|object|true|none||none|
|»»» id|integer|true|none||组ID|
|»»» name|string|true|none||组名称|
|»»» allowShare|boolean|true|none||是否允许组内用户分享|
|»»» allowRemoteDownload|boolean|true|none||是否允许组内用户离线下载|
|»»» allowArchiveDownload|boolean|true|none||是否允许组内用户打包下载|
|»»» shareDownload|boolean|true|none||none|
|»»» compress|boolean|true|none||none|
|»»» webdav|boolean|true|none||是否允许组内用户使用WebDAV|
|»»» sourceBatch|integer|true|none||none|
|»»» advanceDelete|boolean|true|none||是否允许组内用户使用高级删除|
|»»» allowWebDAVProxy|boolean|true|none||none|
|»» tags|[string]|true|none||none|
|» msg|string|true|none|错误信息|none|

## GET 存储空间

GET /user/storage

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 是 |cookie|

> 返回示例

```json
{
  "code": 0,
  "data": {
    "used": 1597,
    "free": 1073740227,
    "total": 1073741824
  },
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|object|true|none||none|
|»» used|integer|true|none||已用空间（字节）|
|»» free|integer|true|none||可用空间（字节）|
|»» total|integer|true|none||总空间（字节）|
|» msg|string|true|none|错误信息|none|

# 用户管理

## GET 用户信息

GET /admin/user/id

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 是 |cookie|
|id|query|string| 是 |用户id|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## POST 修改用户

POST /admin/user

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# fs

## GET 文件目录

GET /directory{path}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|path|path|string| 是 |经过URL Encode的网盘路径|

> 返回示例

```json
{
  "code": 0,
  "data": {
    "parent": "9zh3",
    "objects": [
      {
        "id": "bbTL",
        "name": "my_folder",
        "path": "/",
        "thumb": false,
        "size": 0,
        "type": "dir",
        "date": "2024-05-01T11:19:12.1733916+08:00",
        "create_date": "2024-05-01T11:19:12.1733916+08:00",
        "source_enabled": false
      },
      {
        "id": "j6hJ",
        "name": "yixiangzhilv.com.zone",
        "path": "/",
        "thumb": false,
        "size": 1597,
        "type": "file",
        "date": "2024-04-30T15:25:46.424+08:00",
        "create_date": "2024-05-01T11:05:21.8852154+08:00",
        "source_enabled": false
      }
    ],
    "policy": {
      "id": "z3hJ",
      "name": "Default storage policy",
      "type": "local",
      "max_size": 0,
      "file_type": []
    }
  },
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|object|true|none||none|
|»» parent|string|true|none||当前目录对应文件夹的ID|
|»» objects|[[Object](#schemaobject)]|true|none||文件列表|
|»»» id|string|true|none||文件ID|
|»»» name|string|true|none||文件名称|
|»»» path|string|true|none||文件所在文件夹相对根目录路径|
|»»» thumb|boolean|true|none||none|
|»»» size|integer|true|none||大小（字节）|
|»»» type|string|true|none||类型，指示文件或文件夹|
|»»» date|string(date-time)|true|none||修改时间|
|»»» create_date|string(date-time)|true|none||创建时间|
|»»» source_enabled|boolean|true|none||none|
|»» policy|[Policy](#schemapolicy)|true|none||文件夹的文件存储策略|
|»»» id|string|true|none||存储策略ID|
|»»» name|string|true|none||存储策略名称|
|»»» type|string|true|none||存储方式|
|»»» max_size|integer|true|none||文件大小限制|
|»»» file_type|[string]|true|none||文件扩展名限制|
|» msg|string|true|none|错误信息|none|

## POST 创建文件

POST /file/create

> Body 请求参数

```json
{
  "path": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|body|body|object| 否 |none|
|» path|body|string| 是 |文件路径，支持自动创建不存在的文件夹|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

## POST 获取文件外链

POST /file/source

请注意：由于Cloudreve API设计问题，传入多个文件ID时，返回的数据无序且不包含文件ID，此场景下请慎用。

> Body 请求参数

```json
{
  "items": [
    "xxxxx"
  ]
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|body|body|object| 否 |none|
|» items|body|[string]| 是 |none|

> 返回示例

```json
{
  "code": 0,
  "data": [
    {
      "url": "https://cloud.yixiangzhilv.com/f/DLCZ/97-1.txt",
      "name": "97-1.txt",
      "parent": 1110
    }
  ],
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|[object]|true|none||none|
|»» url|string|false|none||直链地址|
|»» name|string|false|none||文件名称|
|»» parent|integer|false|none||文件所在文件夹的原始ID|
|» msg|string|true|none|错误信息|none|

## GET 文件（夹）详情

GET /object/property/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|id|path|string| 是 |文件或文件夹ID|
|is_folder|query|boolean| 否 |是否为文件夹|
|trace_root|query|boolean| 否 |是否返回path数据（若为false返回数据中path为空）|

> 返回示例

```json
{
  "code": 0,
  "data": {
    "created_at": "2024-05-01T11:05:21.8852154+08:00",
    "updated_at": "2024-04-30T15:25:46.424+08:00",
    "policy": "Default storage policy",
    "size": 1597,
    "child_folder_num": 0,
    "child_file_num": 0,
    "path": "",
    "query_date": "2024-05-01T11:20:07.6083989+08:00"
  },
  "msg": ""
}
```

```json
{
  "code": 0,
  "data": {
    "created_at": "2024-05-01T11:04:25.491493+08:00",
    "updated_at": "2024-05-01T11:04:25.491493+08:00",
    "policy": "",
    "size": 1597,
    "child_folder_num": 1,
    "child_file_num": 1,
    "path": "",
    "query_date": "2024-05-01T11:20:50.7077079+08:00"
  },
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|[Property](#schemaproperty)|true|none||none|
|»» created_at|string(date-time)|true|none||创建时间|
|»» updated_at|string(date-time)|true|none||更新时间|
|»» policy|string|true|none||存储策略名称|
|»» size|integer|true|none||文件（夹）大小|
|»» child_folder_num|integer|true|none||文件夹中子文件夹数（若为文件属性则返回0）|
|»» child_file_num|integer|true|none||文件夹中子文件数（若为文件属性则返回0）|
|»» path|string|true|none||若为文件则返回所在目录，若为文件夹该参数无效|
|»» query_date|string(date-time)|true|none||查询日期（即请求到达服务器的时间）|
|» msg|string|true|none|错误信息|none|

## PUT 创建文件夹

PUT /directory

> Body 请求参数

```json
{
  "path": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|body|body|object| 否 |none|
|» path|body|string| 是 |文件夹目录，支持自动创建不存在的文件夹|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

## PUT 下载文件

PUT /file/download/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |cookie|
|id|path|string| 是 |要下载的文件ID|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "data": "string",
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|string|true|none|下载链接|临时下载链接|
|» msg|string|true|none|错误信息|none|

## DELETE 删除

DELETE /object

> Body 请求参数

```json
{
  "items": [
    "EWlPFJ"
  ],
  "dirs": [],
  "force": false,
  "unlink": false
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|body|body|object| 否 |none|
|» items|body|[string]| 是 |要删除的文件列表|
|» dirs|body|[string]| 是 |要删除的文件夹列表|
|» force|body|boolean| 是 |（针对高级删除选项）强制删除文件|
|» unlink|body|boolean| 是 |（针对高级删除选项）仅解除链接|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

## PATCH 移动

PATCH /object

> Body 请求参数

```json
{
  "action": "move",
  "src_dir": "/a",
  "src": {
    "dirs": [],
    "items": [
      "xxxxx"
    ]
  },
  "dst": "/b"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|body|body|object| 否 |none|
|» action|body|string| 是 |none|
|» src_dir|body|string| 是 |文件来源目录|
|» src|body|object| 是 |none|
|»» dirs|body|[string]| 是 |要移动的文件夹|
|»» items|body|[string]| 是 |要移动的文件|
|» dst|body|string| 是 |目标目录|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

## POST 创建分享

POST /share

- 密码：若不想设置请传递空字符串
- 自动过期：downloads和expire必须同时开启。若不需要开启，请设置downloads的值为`-1`。expire设置为0或负数会导致分享立即过期。

> Body 请求参数

```json
{
  "id": "dmLxcN",
  "is_dir": false,
  "password": "",
  "downloads": -1,
  "expire": 86400,
  "preview": true
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |cookie|
|body|body|object| 否 |none|
|» id|body|string| 是 |分享的文件ID|
|» is_dir|body|boolean| 是 |是否为文件夹|
|» password|body|string| 是 |若要设置密码则填写，否则空串|
|» downloads|body|integer| 是 |多少次下载后自动过期，设置为-1时自动过期不生效（即使同时设置了expire）|
|» expire|body|integer| 是 |过期时间（自现在开始经过多少秒），若downloads为-1则不生效|
|» preview|body|boolean| 是 |是否允许预览|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "data": "string",
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|string|true|none|分享链接|none|
|» msg|string|true|none|错误信息|none|

## POST 重命名

POST /object/rename

> Body 请求参数

```json
{
  "action": "rename",
  "src": {
    "dirs": [],
    "items": [
      "dmLxcN"
    ]
  },
  "new_name": "97-1.txt"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|body|body|object| 否 |none|
|» action|body|string| 是 |none|
|» src|body|object| 是 |被重命名的文件（夹）|
|»» dirs|body|[string]| 是 |若为文件夹，在此填写文件夹ID|
|»» items|body|[string]| 是 |若为文件，在此填写文件ID|
|» new_name|body|string| 是 |新名称|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

## POST 复制

POST /object/copy

> Body 请求参数

```json
{
  "src_dir": "/a",
  "src": {
    "dirs": [],
    "items": [
      "xxxxxx"
    ]
  },
  "dst": "/b"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|cloudreve-session|cookie|string| 否 |none|
|body|body|object| 否 |none|
|» src_dir|body|string| 是 |文件来源目录|
|» src|body|object| 是 |none|
|»» dirs|body|[string]| 是 |要复制的文件夹|
|»» items|body|[string]| 是 |要复制的文件|
|» dst|body|string| 是 |新目录|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

# fs/上传-服务器本地存储

## POST 上传到服务器

POST /file/upload/{sessionID}/0

猜测请求地址最后的0与分片有关，大家可以自行测试
该存储策略不需要确认上传完成，本接口请求成功后文件即上传成功

> Body 请求参数

```yaml
string

```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|sessionID|path|string| 是 |上传文件接口中获得的sessionID|
|body|body|string(binary)| 否 |none|

> 返回示例

```json
{
  "code": 0,
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

# fs/上传-Onedrive

## PUT 上传文件

PUT /file/upload

> Body 请求参数

```json
{
  "path": "/test/b",
  "size": 188,
  "name": "1.py",
  "policy_id": "kVfW",
  "last_modified": 1714481625683,
  "mime_type": ""
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|object| 否 |none|
|» path|body|string| 是 |文件上传路径（相对网盘根目录）|
|» size|body|integer| 是 |文件大小（字节）|
|» name|body|string| 是 |文件名|
|» policy_id|body|string| 是 |存储策略ID，可从接口“文件管理/列目录”中获得|
|» last_modified|body|integer| 是 |待上传文件修改日期的毫秒级时间戳|
|» mime_type|body|string| 是 |待上传文件类型，可留空|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "data": {
    "sessionID": "string",
    "chunkSize": 0,
    "expires": 0,
    "uploadURLs": [
      "string"
    ]
  },
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|object|true|none||none|
|»» sessionID|string|true|none||用于上传完成后确认|
|»» chunkSize|integer|true|none||上传分片大小|
|»» expires|integer|true|none||上传会话过期时间|
|»» uploadURLs|[string]|true|none||上传地址（长度应为1）|
|» msg|string|true|none|错误信息|none|

## POST 确认上传完成

POST /callback/onedrive/finish/{sessionID}

> Body 请求参数

```json
{}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|sessionID|path|string| 是 |上传文件时获得的sessionID|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» msg|string|true|none|错误信息|none|

## PUT 上传到Onedrive

PUT /

参考链接：https://learn.microsoft.com/zh-cn/graph/api/driveitem-createuploadsession?view=graph-rest-1.0#upload-bytes-to-the-upload-session
注意：仅完成“将字节上传到上传会话”部分即可，“完成上传”部分将由服务端完成

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# webdav

## GET 当前用户的WebDAV账户

GET /webdav/accounts

> 返回示例

```json
{
  "code": 0,
  "data": {
    "accounts": [
      {
        "ID": 3,
        "CreatedAt": "2022-07-13T13:50:16.733477315+08:00",
        "UpdatedAt": "2022-07-13T13:50:16.733477315+08:00",
        "DeletedAt": null,
        "Name": "HFR-Cloud挂载",
        "Password": "xxxxx",
        "UserID": 1,
        "Root": "/HFR-Cloud",
        "Readonly": false,
        "UseProxy": false
      }
    ],
    "folders": [
      {
        "id": "abcd",
        "name": "/",
        "policy_name": "HFR-Cloud"
      }
    ]
  },
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|string|true|none||WebDAV账户|
|» msg|string|true|none|错误信息|none|

# public

## GET 站点信息

GET /site/config

> 返回示例

```json
{
  "code": 0,
  "data": {
    "title": "Cloudreve",
    "loginCaptcha": false,
    "regCaptcha": false,
    "forgetCaptcha": false,
    "emailActive": false,
    "themes": "{\"#3f51b5\":{\"palette\":{\"primary\":{\"main\":\"#3f51b5\"},\"secondary\":{\"main\":\"#f50057\"}}},\"#2196f3\":{\"palette\":{\"primary\":{\"main\":\"#2196f3\"},\"secondary\":{\"main\":\"#FFC107\"}}},\"#673AB7\":{\"palette\":{\"primary\":{\"main\":\"#673AB7\"},\"secondary\":{\"main\":\"#2196F3\"}}},\"#E91E63\":{\"palette\":{\"primary\":{\"main\":\"#E91E63\"},\"secondary\":{\"main\":\"#42A5F5\",\"contrastText\":\"#fff\"}}},\"#FF5722\":{\"palette\":{\"primary\":{\"main\":\"#FF5722\"},\"secondary\":{\"main\":\"#3F51B5\"}}},\"#FFC107\":{\"palette\":{\"primary\":{\"main\":\"#FFC107\"},\"secondary\":{\"main\":\"#26C6DA\"}}},\"#8BC34A\":{\"palette\":{\"primary\":{\"main\":\"#8BC34A\",\"contrastText\":\"#fff\"},\"secondary\":{\"main\":\"#FF8A65\",\"contrastText\":\"#fff\"}}},\"#009688\":{\"palette\":{\"primary\":{\"main\":\"#009688\"},\"secondary\":{\"main\":\"#4DD0E1\",\"contrastText\":\"#fff\"}}},\"#607D8B\":{\"palette\":{\"primary\":{\"main\":\"#607D8B\"},\"secondary\":{\"main\":\"#F06292\"}}},\"#795548\":{\"palette\":{\"primary\":{\"main\":\"#795548\"},\"secondary\":{\"main\":\"#4CAF50\",\"contrastText\":\"#fff\"}}}}",
    "defaultTheme": "#3f51b5",
    "home_view_method": "icon",
    "share_view_method": "list",
    "authn": false,
    "user": {
      "id": "l6hY",
      "user_name": "admin@cloudreve.org",
      "nickname": "admin",
      "status": 0,
      "avatar": "",
      "created_at": "2024-05-01T11:04:25.490486+08:00",
      "preferred_theme": "",
      "anonymous": false,
      "group": {
        "id": 1,
        "name": "Admin",
        "allowShare": true,
        "allowRemoteDownload": true,
        "allowArchiveDownload": true,
        "shareDownload": true,
        "compress": true,
        "webdav": true,
        "sourceBatch": 1000,
        "advanceDelete": true,
        "allowWebDAVProxy": false
      },
      "tags": []
    },
    "captcha_ReCaptchaKey": "defaultKey",
    "captcha_type": "normal",
    "tcaptcha_captcha_app_id": "",
    "registerEnabled": true,
    "app_promotion": true,
    "wopi_exts": null
  },
  "msg": ""
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|object|true|none||none|
|»» title|string|true|none||站点标题|
|»» loginCaptcha|boolean|true|none||登录需要人机验证|
|»» regCaptcha|boolean|true|none||注册需要人机验证|
|»» forgetCaptcha|boolean|true|none||重置密码需要人机验证|
|»» emailActive|boolean|true|none||注册需要邮件验证|
|»» themes|string|true|none||主题|
|»» defaultTheme|string|true|none||默认主题|
|»» home_view_method|string|true|none||主页展示模式|
|»» share_view_method|string|true|none||分享展示模式|
|»» authn|boolean|true|none||none|
|»» user|[User](#schemauser)|true|none||none|
|»»» id|string|true|none||用户ID|
|»»» user_name|string|true|none||用户邮箱|
|»»» nickname|string|true|none||用户昵称|
|»»» status|integer|true|none||用户状态|
|»»» avatar|string|true|none||头像|
|»»» created_at|string|true|none||注册时间|
|»»» preferred_theme|string|true|none||默认主题|
|»»» anonymous|boolean|true|none||登录状态|
|»»» group|object|true|none||none|
|»»»» id|integer|true|none||组ID|
|»»»» name|string|true|none||组名称|
|»»»» allowShare|boolean|true|none||是否允许组内用户分享|
|»»»» allowRemoteDownload|boolean|true|none||是否允许组内用户离线下载|
|»»»» allowArchiveDownload|boolean|true|none||是否允许组内用户打包下载|
|»»»» shareDownload|boolean|true|none||none|
|»»»» compress|boolean|true|none||none|
|»»»» webdav|boolean|true|none||是否允许组内用户使用WebDAV|
|»»»» sourceBatch|integer|true|none||none|
|»»»» advanceDelete|boolean|true|none||是否允许组内用户使用高级删除|
|»»»» allowWebDAVProxy|boolean|true|none||none|
|»»» tags|[string]|true|none||none|
|»» captcha_ReCaptchaKey|string|true|none||ReCaptcha API Key|
|»» captcha_type|string|true|none||使用的人机验证类型|
|»» tcaptcha_captcha_app_id|string|true|none||tcaptcha API Key|
|»» registerEnabled|boolean|true|none||允许用户注册|
|»» app_promotion|boolean|true|none||none|
|»» wopi_exts|null|true|none||none|
|» msg|string|true|none|错误信息|none|

#### 枚举值

|属性|值|
|---|---|
|captcha_type|normal|
|captcha_type|recaptcha|
|captcha_type|tcaptcha|

## GET ping测试

GET /site/ping

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "data": "string",
  "msg": "string"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none|响应状态|none|
|» data|string|true|none|服务端Cloudreve版本|none|
|» msg|string|true|none|错误信息|none|

## GET 声明(静态文件)

GET /manifest.json

此接口无需前置/api/v3，可直接调用，比如https://127.0.0.1:5212/manifest.json

> 返回示例

```json
{
  "background_color": "#ffffff",
  "display": "standalone",
  "icons": [
    {
      "sizes": "64x64 32x32 24x24 16x16",
      "src": "/static/img/favicon.ico",
      "type": "image/x-icon"
    },
    {
      "sizes": "192x192",
      "src": "/static/img/logo192.png",
      "type": "image/png"
    },
    {
      "sizes": "512x512",
      "src": "/static/img/logo512.png",
      "type": "image/png"
    }
  ],
  "name": "海枫云存储",
  "short_name": "海枫云存储",
  "start_url": ".",
  "theme_color": "#000000"
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» background_color|string|true|none|背景颜色|none|
|» display|string|true|none||none|
|» icons|string|true|none|图标|none|
|» name|string|true|none|名称|none|
|» short_name|string|true|none|短名称|none|
|» start_url|string|true|none|初始地址|none|
|» theme_color|string|true|none|主题颜色|none|

# 数据模型

<h2 id="tocS_User">User</h2>

<a id="schemauser"></a>
<a id="schema_User"></a>
<a id="tocSuser"></a>
<a id="tocsuser"></a>

```json
{
  "id": "string",
  "user_name": "string",
  "nickname": "string",
  "status": 0,
  "avatar": "string",
  "created_at": "string",
  "preferred_theme": "string",
  "anonymous": true,
  "group": {
    "id": 0,
    "name": "string",
    "allowShare": true,
    "allowRemoteDownload": true,
    "allowArchiveDownload": true,
    "shareDownload": true,
    "compress": true,
    "webdav": true,
    "sourceBatch": 0,
    "advanceDelete": true,
    "allowWebDAVProxy": true
  },
  "tags": [
    "string"
  ]
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|string|true|none||用户ID|
|user_name|string|true|none||用户邮箱|
|nickname|string|true|none||用户昵称|
|status|integer|true|none||用户状态|
|avatar|string|true|none||头像|
|created_at|string|true|none||注册时间|
|preferred_theme|string|true|none||默认主题|
|anonymous|boolean|true|none||登录状态|
|group|object|true|none||none|
|» id|integer|true|none||组ID|
|» name|string|true|none||组名称|
|» allowShare|boolean|true|none||是否允许组内用户分享|
|» allowRemoteDownload|boolean|true|none||是否允许组内用户离线下载|
|» allowArchiveDownload|boolean|true|none||是否允许组内用户打包下载|
|» shareDownload|boolean|true|none||none|
|» compress|boolean|true|none||none|
|» webdav|boolean|true|none||是否允许组内用户使用WebDAV|
|» sourceBatch|integer|true|none||none|
|» advanceDelete|boolean|true|none||是否允许组内用户使用高级删除|
|» allowWebDAVProxy|boolean|true|none||none|
|tags|[string]|true|none||none|

<h2 id="tocS_Object">Object</h2>

<a id="schemaobject"></a>
<a id="schema_Object"></a>
<a id="tocSobject"></a>
<a id="tocsobject"></a>

```json
{
  "id": "string",
  "name": "string",
  "path": "string",
  "thumb": true,
  "size": 0,
  "type": "string",
  "date": "2019-08-24T14:15:22Z",
  "create_date": "2019-08-24T14:15:22Z",
  "source_enabled": true
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|string|true|none||文件ID|
|name|string|true|none||文件名称|
|path|string|true|none||文件所在文件夹相对根目录路径|
|thumb|boolean|true|none||none|
|size|integer|true|none||大小（字节）|
|type|string|true|none||类型，指示文件或文件夹|
|date|string(date-time)|true|none||修改时间|
|create_date|string(date-time)|true|none||创建时间|
|source_enabled|boolean|true|none||none|

<h2 id="tocS_Policy">Policy</h2>

<a id="schemapolicy"></a>
<a id="schema_Policy"></a>
<a id="tocSpolicy"></a>
<a id="tocspolicy"></a>

```json
{
  "id": "string",
  "name": "string",
  "type": "string",
  "max_size": 0,
  "file_type": [
    "string"
  ]
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|string|true|none||存储策略ID|
|name|string|true|none||存储策略名称|
|type|string|true|none||存储方式|
|max_size|integer|true|none||文件大小限制|
|file_type|[string]|true|none||文件扩展名限制|

<h2 id="tocS_Property">Property</h2>

<a id="schemaproperty"></a>
<a id="schema_Property"></a>
<a id="tocSproperty"></a>
<a id="tocsproperty"></a>

```json
{
  "created_at": "2019-08-24T14:15:22Z",
  "updated_at": "2019-08-24T14:15:22Z",
  "policy": "string",
  "size": 0,
  "child_folder_num": 0,
  "child_file_num": 0,
  "path": "string",
  "query_date": "2019-08-24T14:15:22Z"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|created_at|string(date-time)|true|none||创建时间|
|updated_at|string(date-time)|true|none||更新时间|
|policy|string|true|none||存储策略名称|
|size|integer|true|none||文件（夹）大小|
|child_folder_num|integer|true|none||文件夹中子文件夹数（若为文件属性则返回0）|
|child_file_num|integer|true|none||文件夹中子文件数（若为文件属性则返回0）|
|path|string|true|none||若为文件则返回所在目录，若为文件夹该参数无效|
|query_date|string(date-time)|true|none||查询日期（即请求到达服务器的时间）|

