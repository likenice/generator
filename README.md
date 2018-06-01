# Spring Cloud Project Generator

Spring Cloud Project Generator 用来自动创建Spring Boot项目和Spring Cloud项目。随着微服务化的开展，将会拆分出越来越多的子项目，Generator 目的是为了减轻新建项目工程的工作量，减少重复性工作。

Generator 可以根据数据库表自动生成项目工程、代码和接口文档，实现最基本的CRUD功能，让开发人员更加专注于业务逻辑。最重要的思路是将重复出现的设置、属性配置和代码等做成模板，通过模板自动生成代码，随着使用的深入，逐步提炼公共代码到模板，既节省了时间，又易于形成规范。

Generator 只能减轻重复性的体力劳动，复杂的业务逻辑仍然需要自己完成。

# 1. 版本

## 0.1.0 (2018/02/25)

* SpringCloud项目拆分为Facade和Server两个子项目
* 重新整理了通用Mapper3的用法
* 解决FeignClient的Get请求使用对象作为参数的问题

## 0.0.2 (2018/01/23)

* 拆分生成spring boot项目和spring cloud项目的逻辑

## 0.0.1 (2017/12/07)

* 生成项目工程，包括pom.xml, application.properties, bootstrap.properties, Application类
* 集成通用mapper，实现对数据库单表的CRUD操作
* 生成Controller、Service类，以及DTO和VO对象

# 2. 使用

启动Web工程，输入相应的参数，然后点击“生成微服务工程代码”。目前，代码生成到本地磁盘；后面等项目稳定了，会部署成为Web服务，在服务端生成的项目后压缩成zip包下载到本地。

## 2.1 项目基本信息

### Project Type

项目类型，可选项为Spring Boot项目和Spring Cloud项目。选择了Spring Cloud项目后，pom.xml中将引入Spring Cloud需要的包，application.properties中增加Spring Cloud相关配置，多生成用于Feign调用的Client代码。

### AtifactId

项目名称，请使用连接符"-"进行连接。

### Port

服务端口。

### 作者

生成的类文件将自动加上作者和日期，请写上自己的名字。

### 项目目录

生成工程后，本地的存储路径。考虑到存储路径可以和AtifactId不同，目前需要自己输入完整的项目路径，没有自动添加AtifactId。例如：如果新建service-user项目，并想放置到e盘，那么需要录入e:/service-user

## 2.2 数据库表信息

Controller、Service、ServiceImpl、实体类、Mapper文件、VO、DTO、Query对象都是根据数据库表来生成的，每一个数据库表将生成对应的一套代码，并实现基础的CRUD操作。Controller和ServiceImpl都有基类，基类在kingold-common项目中。

字段注释、参数校验、查询字段、主键等信息都来自于数据库表信息，生成代码前，请检查数据库表信息是否完备。可能影响到生成代码的库表信息包括：表名、表注释、主键设置、索引设置、字段名、字段数据类型、字段是否可空、字段是否有默认值、字段长度限制、字段注释。

### DO、VO、DTO

根据数据库表将生成三个对象：

- 实体类对象：与数据库表字段一一对应，没有数据合法性校验和API文档属性
- DTO对象，Controller接收的参数对象，用于创建和修改，与数据库表字段一一对应（除了delete_flag、create_time和update_time），有数据合法性校验和API文档属性
- Query对象，Controller接收的参数对象，用于查询，对应数据库表的索引字段和枚举型字段，生成时可手工选择，有数据合法性校验和API文档属性
- VO对象，Controller返回给前端的对象，只有API文档属性

### 待生成列表

将数据库表添加到待生成列表后，才能自动生成代码。

### 主键类型

目前要求表必须有主键，可以是ID或者UUID，ID就是自增BIGINT型，UUID就是CHAR型。主键类型不同，生成的代码也不同。UUID目前还是在应用端生成，没有在数据库端生成。为了简化，目前还没有做分布式唯一ID，仍然在使用UUID。

# 3. 约定

## 3.1 数据库表约定

- 表名、字段名都必须使用下划线"_"连接多个单词，生成对应的JAVA代码时自动转为驼峰型
- 每个表都必须有主键、主键可以是自增ID或者UUID
- 每个表都必须有delete_flag、create_time、update_time三个字段
- 字段delete_flag用于做逻辑删除标识
- 字段create_time用于记录创建时间
- 字段update_time用于记录最后更新时间
- UUID在JAVA中赋值，然后写入到数据库中
- create_time和update_time使用数据库时间，JAVA中不用赋值
- 枚举型（例如：各种状态）请声明为tinyint类型，可以自动加入到查询字段中（也可以手工设置）

## 3.2 项目目录约定

- config：配置文件目录，相当于spring-xxx.xml
- dto：参数对象目录，放置Controller接收HTTP请求的参数
- entity：实体类对象目录，放置实体类对象，与数据库一一对应（实体对象属于贫血模型，没有业务逻辑）
- mapper: 对应mapper.xml文件，提供数据库表操作接口
- service: 服务类目录
- vo：值对象目录，放置返回给接口层的对象，根据实体类对象生成
- web：Controller类目录

# 4. 技术栈

## 4.1 Controller

- 使用@RestController
- 使用@GetMapping、@PostMapping等组合注解
- JsonUtil(kingold-common)用于做对象转换
- ListResultVO(kingold-common)用于返回列表数据，包含count和list两个属性

## 4.2 Service

- query方法实现了简单的查询，目前只有相等条件的AND查询，复杂查询需要自己实现
- 基类CrudService(kingold-common)实现基础的CRUD方法，删除是逻辑删除
- 基类的startPage()方法用于处理分页，代码可参考query方法
- 排序没有做通用方法，需要自己实现（@OrderBy注解可以做简单排序）

## 4.3 Mapper

- 自动生成的Mapper继承自CrudMapper，基类CrudMapper在代码中实现了CRUD基础SQL的拼接（mapper.xml文件中不再有大量xxxByPrimarySelective配置）
- 如果基础Mapper功能不满足需求，请在mapper.xml文件中添加SQL，并在Mapper中添加接口

## 4.4 DTO/VO

- VO对象与实体类对象类似，少了@Id等注解，多了字段注释说明
- 选择查询字段生成DTO对象，DTO对象有字段注视说明和参数校验
- 用了lombok，不用请删除，使用请安装插件

## 4.5 接口文档

- 通过swagger2注解自动生成接口文档
- @ApiOperation注解对接口进行说明
- @ApiParam注解对参数对象进行说明
- @ApiModelProperty注解对参数具体描述进行说明（请将必须传的参数设置为required=true） 
- 运行测试类的generateDocTest()方法生成接口文档到doc目录
- 接口文档使用markdown格式，可复制黏贴到showdoc（暂不考虑直接发布到showdoc）

## 4.6 编码规范

- 编码规范使用《阿里巴巴Java开发手册（终极版）》
- 请安装[插件]: https://github.com/alibaba/p3c 对编码规范进行检查

## 4.7 参数校验

- 数据合法性校验使用hibernate-validator，通过spring-boot-starter-web引入
- 使用@Validated注解进行参数校验
- 参数校验失败，抛出MethodArgumentNotValidException异常，GlobalExceptionHandler中捕获异常并返回400错误码

