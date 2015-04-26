import org.codehaus.groovy.grails.commons.ApplicationAttributes
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils



class BootStrap {

     def init = { servletContext ->


            // Prüft, ob die Verbindungen zur Datenbank noch stehen, damits keine Broken-Pipe-Fehler gibt
            // Nach: http://sacharya.com/grails-dbcp-stale-connections/


              def ctx=servletContext.getAttribute(

              ApplicationAttributes.APPLICATION_CONTEXT)

              def dataSource = ctx.dataSourceUnproxied

              dataSource.setMinEvictableIdleTimeMillis(1000 * 60 * 1)

              dataSource.setTimeBetweenEvictionRunsMillis(1000 * 60 * 1)

              dataSource.setNumTestsPerEvictionRun(3)

              dataSource.setTestOnBorrow(true)

              dataSource.setTestWhileIdle(true)

              dataSource.setTestOnReturn(false)

              dataSource.setValidationQuery("SELECT 1")


              SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl   = "/dashboard/"
              //dataSource.properties.each { println it }

    }



     def destroy = {
         println("stop")
     }
} 