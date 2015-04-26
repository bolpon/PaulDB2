dataSource {
	pooled = true
	driverClassName = "com.mysql.jdbc.Driver"


}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    //cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
    cache.provider_class='org.hibernate.cache.EhCacheProvider'
}

// environment specific settings
environments {
	development {
		dataSource { 
        username = "root"
	      password = ""
        url = "jdbc:mysql://localhost/pauldb2"
        logSql = false
		}
	}
	
	production {
		dataSource {
			//dbCreate = "update"
			//url = "jdbc:hsqldb:file:prodDb;shutdown=true"
            username = "xxxx"
            password = "xxxx"
            url = "jdbc:xxxx"
            logSql = false
        }
	}
}
