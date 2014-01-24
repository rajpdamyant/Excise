dataSource {
    pooled = true
    driverClassName = "org.hsqldb.jdbcDriver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            driverClassName = "com.mysql.jdbc.Driver"
            url = "jdbc:mysql://localhost/excise?zeroDateTimeBehavior=convertToNull&useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8&autoReconnect=true"
            username = "root"
            password = "root123"

        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:mem:testDb"
        }
    }
    production {
        dataSource {


                        pooled = true
                        dbCreate = "update" // one of 'create', 'create-drop','update'
                        driverClassName = "com.mysql.jdbc.Driver"
                        url =
                        "jdbc:mysql://localhost/excise?zeroDateTimeBehavior=convertToNull&useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8&autoReconnect=true"
                        username = "root"
                        password = "root123"
                        maxActive = 50
                        maxIdle = 25
                        minIdle = 5
                        initialSize = 5
                        minEvictableIdleTimeMillis = 1800000
                        timeBetweenEvictionRunsMillis = 1800000
                        maxWait = 10000

                        //configure DBCP
                        properties {
                            maxActive = 50
                            maxIdle = 25
                            minIdle = 5
                            initialSize = 5
                            minEvictableIdleTimeMillis = 1800000
                            timeBetweenEvictionRunsMillis = 1800000
                            numTestsPerEvictionRun = 3
                            maxWait = 10000

                            testOnBorrow = true
                            testWhileIdle = true
                            testOnReturn = false

                            validationQuery = "SELECT 1"


                        }









          //  dbCreate = "update" // one of 'create', 'create-drop','update'
           // driverClassName = "com.mysql.jdbc.Driver"
           // url = "jdbc:mysql://localhost/excise?zeroDateTimeBehavior=convertToNull&useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8&autoReconnect=true"
          //  username = "root"
           // password = "root123"

        }
    }
}
